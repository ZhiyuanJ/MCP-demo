# Week 01 Log

- Dates: Oct 7 - Oct 8 2026
- Hours spent: less than 1 hour.

## Done
- Set up Python venv on Mac.
- Downloaded Part D Prescriber by Provider and Drug for 2022, 2023 and 2024.
- Converted each CSV to one Parquet file. About 4 GB CSV became about 0.5 GB.
- Validated totals against CMS grand totals.
- Pushed the repo to GitHub.

## Number of the week
| Year | Rows | Claims coverage | Cost coverage | NPI coverage | Duplicate keys |
|---|---|---|---|---|---|
| 2022 | 25,869,521 | 86.0% | 76.2% | 63.8% | 0 |
| 2023 | 26,794,878 | 86.2% | 77.1% | 64.8% | 0 |
| 2024 | 28,023,892 | 86.5% | 78.6% | 65.5% | 0 |

## Blocked
- macOS python.org build had no CA certificates. Fixed with certifi.

## Learned
- What is parquet and why it is faster/smaller
- How to set up the virtual environment and why a venv is better for project like this, what's the benefits it brings.

## Next week
- dbt models plus metric layer. See ROADMAP v2 W2.
