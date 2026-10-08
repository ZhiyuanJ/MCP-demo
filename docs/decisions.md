# Decision Log

Record one line per decision. Date. Decision. Reason.

- 2026-10-07. Use DuckDB not Snowflake. Free and local.
- 2026-10-07. Use one dataset for all phases. Less setup. Stronger story.
- 2026-10-07. Skip model training. JDs ask for model use and evaluation.
- 2026-10-08. Store one Parquet file per year. 4 GB CSV becomes about 0.5 GB. Queries take seconds.
- 2026-10-08. Read NPI and FIPS as text. They are IDs. FIPS has leading zeros.
- 2026-10-08. PUF covers 86.5% of 2024 claims and 78.6% of cost. Rows under 11 claims are suppressed. Note this in every result.
