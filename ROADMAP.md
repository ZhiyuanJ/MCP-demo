# Roadmap v2

- Start: Wed Oct 7 2026
- Core done: Sun Nov 29 2026
- Polish done: Sun Dec 20 2026
- Budget: 10 hours per week. About 7.5 hours on the project. About 2.5 hours on interview prep.
- Dataset: CMS Medicare Part D Prescribers by Provider and Drug. 2022 to 2024.

## What changed from v1
- Budget doubled. Timeline cut from 12 weeks to about 8 weeks for the core.
- Added an interview prep track. JDs list skills. Interviews test them.
- Added statistical tests to the agent eval.
- Added a fairness check to anomaly detection.
- Added a December block to deploy, demo and apply.

## Goal
Ship one project that proves four skills:
1. Build agent-ready data foundations.
2. Build and evaluate an LLM analytics agent.
3. Run LLM labeling with ground truth and error analysis.
4. Turn data into causal answers and automated reports.

## Phases
| Phase | Dates | Theme | Deliverable | JD signal |
|---|---|---|---|---|
| 1 | Oct 7 - Oct 18 | Data foundation | Parquet. dbt models. Metric layer. Data dictionary. | Semantic layer. KPI standards. SQL. |
| 2 | Oct 19 - Nov 1 | Analytics agent | MCP server. Eval set. Significance test on gains. | Agentic analytics. LLM eval. Experimentation. |
| 3 | Nov 2 - Nov 15 | Labeling and risk | LLM classifier vs gold labels. Anomaly flags. Fairness check. | Ground truth. Fraud and abuse. Responsible AI. |
| 4 | Nov 16 - Nov 29 | Causal and ship | Insulin cap DiD. Dashboard. Auto-report. Write-up. | Causal inference. Dashboards. AI automation. |
| 5 | Nov 30 - Dec 20 | Polish and apply | Live demo. Blog posts. Tailored resumes. Mock interviews. | Communication. Visibility. |

## Weekly plan

### Phase 1: Data foundation
**W1 Oct 7. Setup and load. DONE**
- Python env. Three years of data. Parquet. Validation.
- Result: PUF covers about 86% of claims and 77% of cost each year. No duplicate keys.

**W2 Oct 12. dbt models and metric layer**
- Init dbt-duckdb project.
- Staging model plus two marts: prescriber-year and drug-year.
- Five data tests.
- Define 10 metrics in `semantic/metrics.yml`.
- Write `semantic/data_dictionary.md`.
- Done when: `dbt build` passes and every metric has SQL plus a plain-English meaning.

### Phase 2: Analytics agent
**W3 Oct 19. MCP server and eval set**
- Tools: `list_metrics`, `describe_table`, `run_readonly_query`.
- Connect to Claude. Answer three real questions.
- Write 40 business questions with gold answers.
- Script scores the agent. Log baseline accuracy.
- Done when: baseline is logged.

**W4 Oct 26. Improve and test**
- Add metric descriptions and query guardrails.
- Rerun the eval. Group errors by type.
- Test the gain with McNemar's test and a bootstrap confidence interval.
- Done when: you can say if the gain is real or noise.

### Phase 3: Labeling and risk
**W5 Nov 2. Guideline, gold set and LLM classifier**
- Pick 200 drug names. Write labeling rules for therapeutic class.
- Label all 200 by hand.
- LLM labels the same 200. Measure precision, recall and Cohen's kappa.
- Review disagreements. Update the guideline.
- Done when: error analysis is written.

**W6 Nov 9. Anomaly detection and fairness**
- Flag outlier opioid prescribers with z-scores and isolation forest.
- LLM drafts a review note per flag.
- Review 30 flags by hand. Estimate precision.
- Check flag rates by specialty and by rural vs urban.
- Done when: precision and fairness findings are written.

### Phase 4: Causal and ship
**W7 Nov 16. Causal study**
- The $35 insulin cap in Part D began Jan 2023.
- Compare insulin with other diabetes drugs before and after.
- Run difference-in-differences. Check parallel trends with the Geography file for more pre years.
- Done when: estimate and caveats are written.

**W8 Nov 23. Dashboard, auto-report and README**
- Dashboard in Streamlit.
- LLM writes a summary from metric outputs. Log manual vs automated time.
- Finish README with results from every phase.
- Thanksgiving week. Keep it light if needed.
- Done when: one command makes the report and the README tells the full story.

### Phase 5: Polish and apply
**W9 Nov 30. Deploy and demo**
- Deploy the dashboard to Streamlit Community Cloud.
- Record a 3-minute demo video of the agent.
- Done when: a recruiter can see results without running code.

**W10 Dec 7. Write and share**
- Two blog posts: agent eval and insulin cap.
- Draft resume bullets for each phase.
- Done when: both posts are live.

**W11 Dec 14. Interview sprint**
- Two mock interviews. One product case. One technical.
- Tailor resumes for five target roles.
- Done when: five applications are out.

## Interview prep track
About 2.5 hours every week from W2.
| Weeks | Focus | Practice |
|---|---|---|
| W2-W3 | SQL | Window functions. CTEs. Self joins. Two problems per session. |
| W4-W5 | Experiments | A/B test design. Power. P-values. Common pitfalls. |
| W6-W7 | Product sense | Define metrics. Diagnose a metric drop. Trade-offs. |
| W8-W9 | Stats and ML basics | Regression. Bias and variance. Precision and recall. |
| W10-W11 | Behavioral | Five STAR stories. Map each to a JD theme. |

## Rules
- Each week ends with a log in `logs/`.
- If a week slips, cut scope. Do not shift the whole plan.
- Every phase must produce one number. Accuracy. Kappa. Precision. Effect size. Time saved.
