# AI + Data Portfolio: Medicare Part D

One project. Eight weeks. Ten hours per week.
It shows the AI skills that big tech data roles ask for.

## Read first
- `ROADMAP.md`: the 12-week plan and weekly tasks.
- `docs/jd-analysis.md`: what the target JDs want and why this plan fits.
- `logs/`: one log per week. Copy `logs/_template.md`.

## Layout
| Folder | Phase | Purpose |
|---|---|---|
| `data/` | 1 | Raw and processed files. Not committed. |
| `dbt/` | 1 | Staging and mart models on DuckDB. |
| `semantic/` | 1 | Metric definitions and data dictionary. |
| `mcp_server/` | 2 | MCP server that exposes the metric layer to an LLM. |
| `evals/` | 2 | Question set and scoring script for the agent. |
| `labeling/` | 3 | Labeling guideline, gold labels, LLM labels. |
| `anomaly/` | 3 | Outlier prescriber flags and review notes. |
| `analysis/causal/` | 4 | Insulin cap difference-in-differences study. |
| `dashboard/` | 4 | Dashboard and auto-report. |
| `reports/` | 4 | Final write-up and generated summaries. |
| `docs/` | all | JD analysis and decision log. |

## Stack
Python. DuckDB. dbt-duckdb. Claude via MCP. Streamlit or Power BI.
