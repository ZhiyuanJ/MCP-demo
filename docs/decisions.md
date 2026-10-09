# Decision Log

Record one line per decision. Date. Decision. Reason.

- 2026-10-07. Use DuckDB not Snowflake. Free and local.
- 2026-10-07. Use one dataset for all phases. Less setup. Stronger story.
- 2026-10-07. Skip model training. JDs ask for model use and evaluation.
- 2026-10-08. Store one Parquet file per year. 4 GB CSV becomes about 0.5 GB. Queries take seconds.
- 2026-10-08. Read NPI and FIPS as text. They are IDs. FIPS has leading zeros.
- 2026-10-08. PUF covers 86.5% of 2024 claims and 78.6% of cost. Rows under 11 claims are suppressed. Note this in every result.
- 2026-10-08. Moved to 10 hours per week. Core ends Nov 29. Added interview prep track and Phase 5.

## Staging Model

- 2026-10-09. Remove provider name since not-relevant to study.
- 2026-10-09. Keep city, low cost to keep and with supplement data (if have) could determine rural/urban
- 2026-10-09. Keep all GE65 variables, allows to investigate 65+ senior
- 2026-10-09. Suppression flag keep three values (not suppressed, suppressed for small cell, suppressed for calculation)
- 2026-10-09. Keep suppressed bene indicator using NULL, also add a binary suppression indicator
- 2026-10-09. Keep the prescriber type source, low cost to keep and further analysis potential.