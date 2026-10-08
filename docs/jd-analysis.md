# JD Analysis: What AI Skills Tech Companies Want

Source: 10 postings from Microsoft, Meta, Google and Amazon. Collected Oct 2026.

## Postings
| # | Company | Role | AI ask |
|---|---|---|---|
| 1 | Microsoft AI | Trust & Safety policy PM | Labeling. Ground truth. Eval design. Human-in-the-loop. |
| 2 | Microsoft | Sr Data Analyst, eCommerce | Copilot and agentic tools to automate reporting. |
| 3 | Microsoft | Sr Data Scientist, media | Causal inference. ML only when interpretable. |
| 4 | Meta | Data Scientist, Product Analytics | AI tools that redesign workflows. Responsible AI. |
| 5 | Meta | Data Scientist, Product Analytics | Same as #4. Prompt and context engineering. Agents. |
| 6 | Google.org | Data strategy consultant | Little AI. Impact metrics and narratives. |
| 7 | Google Global Affairs | Business Data Scientist | LLMs for text analysis and knowledge extraction. Eval metrics. |
| 8 | AWS Marketplace | Sr BI Engineer | Semantic layer and metric layer for agentic analytics. |
| 9 | Amazon Pricing | Sr BI Engineer | LLM insights. Anomaly detection. |
| 10 | Amazon SCOT | BI Engineer | GenAI to automate reporting. |

## Findings

### 1. The core did not change
Every posting asks for SQL and Python. Most ask for statistics and storytelling.
AI sits on top of the core. It does not replace it.

### 2. Four AI skills repeat
| Skill | What it means | Postings |
|---|---|---|
| AI workflow automation | Use LLMs to cut manual work. Show the time saved. | 2, 4, 5, 9, 10 |
| LLM evaluation | Build gold sets. Measure accuracy. Analyze errors. | 1, 4, 5, 7 |
| Agent-ready data | Clean metric definitions so an agent can query safely. | 2, 8 |
| LLM text analysis | Extract and classify text at scale. | 7, 9 |

### 3. Model training is rare
Only #7 asks to deploy LLM solutions. No posting asks to train a model from scratch.
The ask is to use, evaluate and integrate models.

### 4. Causal skill stays a differentiator
Postings 3, 4, 9 and 2 ask for experiments or causal methods.
An economics background is an edge here.

### 5. Risk and integrity is a theme
Trust & Safety, fraud and price errors all need anomaly detection plus human review.
Healthcare claims data maps well to this.

## Fit
| Area | Status |
|---|---|
| Data pipelines | Strong. Current work. |
| Causal inference | Strong. Economics training. |
| Health policy domain | Strong. CMS background. |
| LLM evaluation | Gap. Phase 2 and 3 fix it. |
| Agent tooling | Gap. Phase 2 fixes it. |
| Product metrics and dashboards | Partial. Phase 1 and 4 fix it. |

## Implication
Do not chase model training. Build one project that shows the four skills.
Every phase must end with a measured result.
