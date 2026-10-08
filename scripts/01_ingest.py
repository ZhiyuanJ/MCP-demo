"""Week 1: download Part D Prescriber files and convert them to Parquet.

Run from the repo root:
    python scripts/01_ingest.py            # all years
    python scripts/01_ingest.py 2024       # one year
"""
import ssl
import sys
import time
import urllib.request
from pathlib import Path

import certifi
import duckdb

ROOT = Path(__file__).resolve().parents[1]
RAW = ROOT / "data" / "raw"
OUT = ROOT / "data" / "processed" / "prescriber_drug"

# Source: data.cms.gov "Medicare Part D Prescribers - by Provider and Drug".
URLS = {
    2022: "https://data.cms.gov/sites/default/files/2024-05/18f82097-61a6-4889-9941-9a0b6ad7523c/MUP_DPR_RY24_P04_V10_DY22_NPIBN.csv",
    2023: "https://data.cms.gov/sites/default/files/2025-04/0d5915ce-002c-4d87-bde8-24ffb08bb6cc/MUP_DPR_RY25_P04_V10_DY23_NPIBN.csv",
    2024: "https://data.cms.gov/sites/default/files/2026-05/0ae165f4-eb44-495d-8cac-67f4571b6b83/MUP_DPR_RY26_P04_V10_DY24_NPIBN.csv",
}

# IDs are text. A FIPS code like "06" loses its zero if read as a number.
# python.org builds on macOS ship without root certificates.
# certifi provides a trusted CA bundle so HTTPS works everywhere.
SSL_CONTEXT = ssl.create_default_context(cafile=certifi.where())

TEXT_COLUMNS = {"Prscrbr_NPI": "VARCHAR", "Prscrbr_State_FIPS": "VARCHAR"}


def download(year: int) -> Path:
    """Download one year into data/raw/<year>/. Skip if the file exists."""
    url = URLS[year]
    target = RAW / str(year) / url.rsplit("/", 1)[-1]
    if target.exists():
        print(f"[{year}] CSV found: {target.name}")
        return target
    target.parent.mkdir(parents=True, exist_ok=True)
    part = target.with_suffix(".part")
    print(f"[{year}] downloading {target.name}")
    with urllib.request.urlopen(url, context=SSL_CONTEXT) as resp, open(part, "wb") as f:
        total = int(resp.headers.get("Content-Length", 0))
        done = 0
        while chunk := resp.read(8 * 1024 * 1024):
            f.write(chunk)
            done += len(chunk)
            if total:
                print(f"\r[{year}] {done / total:6.1%}", end="", flush=True)
    print()
    part.rename(target)
    return target


def to_parquet(year: int, csv_path: Path) -> Path:
    """Convert one CSV to one Parquet file with a year column added."""
    OUT.mkdir(parents=True, exist_ok=True)
    target = OUT / f"year={year}.parquet"
    if target.exists():
        print(f"[{year}] Parquet found: {target.name}")
        return target
    start = time.time()
    con = duckdb.connect()
    con.execute("SET preserve_insertion_order = false")  # lowers memory use
    con.execute(
        f"""
        COPY (
            SELECT {year} AS year, *
            FROM read_csv(?, header = true, types = {TEXT_COLUMNS})
        ) TO '{target}' (FORMAT parquet, COMPRESSION zstd)
        """,
        [str(csv_path)],
    )
    mb_in = csv_path.stat().st_size / 1e6
    mb_out = target.stat().st_size / 1e6
    print(f"[{year}] {mb_in:,.0f} MB CSV -> {mb_out:,.0f} MB Parquet in {time.time() - start:.0f}s")
    return target


if __name__ == "__main__":
    years = [int(y) for y in sys.argv[1:]] or sorted(URLS)
    for y in years:
        to_parquet(y, download(y))
