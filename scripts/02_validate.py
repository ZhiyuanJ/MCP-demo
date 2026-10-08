"""Week 1: check Parquet totals against CMS grand totals.

The PUF drops prescriber-drug rows with fewer than 11 claims. So PUF totals
sit below the CMS grand totals. 2024 baseline: claims 86.5%. Cost 78.6%.
Prescribers 65.5%. Other years should land close to these numbers.
"""
from pathlib import Path

import duckdb

ROOT = Path(__file__).resolve().parents[1]
PARQUET = ROOT / "data" / "processed" / "prescriber_drug" / "*.parquet"

# From MUP_DPR_RY26_P06_V10_DYT24_HLSum.xlsx. All Part D events. Not suppressed.
CMS_TOTALS = {
    2022: {"claims": 1_543_890_687, "drug_cost": 240_372_180_263, "prescribers": 1_657_654},
    2023: {"claims": 1_616_937_313, "drug_cost": 275_812_762_317, "prescribers": 1_703_740},
    2024: {"claims": 1_711_077_387, "drug_cost": 288_577_373_314, "prescribers": 1_739_885},
}

con = duckdb.connect()
rows = con.execute(
    f"""
    SELECT year,
           COUNT(*)                    AS n_rows,
           SUM(Tot_Clms)               AS claims,
           SUM(Tot_Drug_Cst)           AS drug_cost,
           COUNT(DISTINCT Prscrbr_NPI) AS prescribers,
           COUNT(*) - COUNT(DISTINCT (Prscrbr_NPI, Brnd_Name, Gnrc_Name)) AS dup_keys
    FROM read_parquet('{PARQUET}')
    GROUP BY year ORDER BY year
    """
).fetchall()

print(f"{'year':>4} {'rows':>12} {'claims %':>9} {'cost %':>7} {'NPI %':>6} {'dup keys':>9}")
for year, n_rows, claims, cost, npis, dups in rows:
    ref = CMS_TOTALS[year]
    print(
        f"{year:>4} {n_rows:>12,} {claims / ref['claims']:>9.1%} "
        f"{cost / ref['drug_cost']:>7.1%} {npis / ref['prescribers']:>6.1%} {dups:>9,}"
    )
