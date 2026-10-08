# Roadmap

- Start: Mon Oct 12 2026
- End: Sun Jan 3 2027
- Budget: 5 hours per week. Two 2-hour build sessions. One hour for log and review.
- Dataset: CMS Medicare Part D Prescribers by Provider and Drug. Three years that span 2023.

## Goal
Ship one project that proves four skills:
1. Build agent-ready data foundations.
2. Build and evaluate an LLM analytics agent.
3. Run LLM labeling with ground truth and error analysis.
4. Turn data into causal answers and automated reports.

## Phases
| Phase | Weeks | Theme | Deliverable | JD signal |
|---|---|---|---|---|
| 1 | 1-3 | Data foundation | dbt models. Metric layer. Data dictionary. | Semantic layer. KPI standards. SQL. |
| 2 | 4-6 | Analytics agent | MCP server. 30-question eval set. Accuracy report. | Agentic analytics. LLM evaluation. |
| 3 | 7-9 | Labeling and risk | LLM drug classifier vs gold labels. Anomaly flags. | Ground truth. Eval metrics. Fraud and abuse. |
| 4 | 10-12 | Causal and ship | Insulin cap DiD. Dashboard. Auto-report. Write-up. | Causal inference. Dashboards. AI automation. |

## Weekly plan

### Phase 1: Data foundation
**W1 Oct 12. Setup and load**
- Create Python env. Install duckdb and pandas.
- Download three years of Part D data.
- Load raw tables into DuckDB.
- Done when: row counts match CMS documentation.

**W2 Oct 19. dbt models**
- Init dbt-duckdb project.
- Build staging models and two marts: prescriber-year and drug-year.
- Add five data tests.
- Done when: `dbt build` passes.

**W3 Oct 26. Metric layer**
- Define 10 metrics in `semantic/metrics.yml`. Examples: total cost, cost per claim, generic share.
- Write `semantic/data_dictionary.md`.
- Done when: each metric has a SQL definition and a plain-English meaning.

### Phase 2: Analytics agent
**W4 Nov 2. MCP server v0**
- Tools: `list_metrics`, `describe_table`, `run_readonly_query`.
- Connect it to Claude.
- Done when: Claude answers three real questions through the tools.

**W5 Nov 9. Eval set**
- Write 30 business questions with gold answers.
- Script runs the agent and scores each answer.
- Done when: baseline accuracy is logged.

**W6 Nov 16. Improve and measure**
- Add better metric descriptions and query guardrails.
- Rerun the eval. Group errors by type.
- Done when: accuracy change and error types are written up.

### Phase 3: Labeling and risk
**W7 Nov 23. Guideline and gold set**
- Pick 150 drug names.
- Write labeling rules for therapeutic class.
- Label all 150 by hand.
- Done when: guideline v1 and gold set exist.

**W8 Nov 30. LLM classifier**
- LLM labels the same 150 drugs.
- Measure precision, recall and Cohen's kappa.
- Review disagreements. Update the guideline.
- Done when: error analysis is written.

**W9 Dec 7. Anomaly detection**
- Flag outlier opioid prescribers with z-scores or isolation forest.
- LLM drafts a review note per flag.
- Review 20 flags by hand.
- Done when: flag precision is estimated.

### Phase 4: Causal and ship
**W10 Dec 14. Causal study**
- The $35 insulin cap in Part D began Jan 2023.
- Compare insulin with other diabetes drugs before and after.
- Run difference-in-differences. Check parallel trends.
- Done when: estimate and caveats are written.

**W11 Dec 21. Dashboard and auto-report**
- Build a dashboard in Streamlit or Power BI.
- LLM writes a summary from metric outputs.
- Log manual time vs automated time.
- Done when: one command generates the report.

**W12 Dec 28. Ship**
- Finish README with results.
- Draft three resume bullets.
- Write one blog post.
- Push to GitHub.
- Done when: repo is public and on the resume.

## Rules
- Each week ends with a log in `logs/`.
- If a week slips, cut scope. Do not shift the whole plan.
- Every phase must produce one number. Accuracy. Kappa. Precision. Effect size. Time saved.
