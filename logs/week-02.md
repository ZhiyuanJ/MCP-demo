# Week 02 Log

- Dates: Oct 9 2026 -
- Hours spent: 5 hours (as of Oct 9)

## Done
- Installed dbt-core 1.12.5 and dbt-duckdb 1.11.0 in the venv.
- Initialized the dbt project in `dbt/` (flattened, no nested folder). Project name `partd`.
- Added an in-repo `dbt/profiles.yml`. Database file at `data/partd.duckdb`. `dbt debug` passes.
- Configured `staging/` as views and `marts/` as tables in `dbt_project.yml`.
- Declared the source `cms.prescriber_drug` in `models/staging/_sources.yml`. One logical table over three yearly Parquet files via `*.parquet`.
- Profiled the raw data with DuckDB: suppression flags, `Tot_Benes` nulls, `Prscrbr_Type_Src` values.
- Built the first model `stg_cms__prescriber_drug` (view): snake_case names, provider names dropped, suppression labels and a boolean bene-suppression flag added.
- Logged staging decisions in `docs/decisions.md`.

## Number of the week
Source reconciliation: `dbt show` row counts match the Week 1 Parquet counts exactly.

| Year | Rows via dbt source | Week 1 rows |
|---|---|---|
| 2022 | 25,869,521 | 25,869,521 |
| 2023 | 26,794,878 | 26,794,878 |
| 2024 | 28,023,892 | 28,023,892 |

Suppression rates in 2024 (share of rows):

| Field | Suppressed |
|---|---|
| `Tot_Benes` | 54.5% |
| `GE65_Tot_Clms` | 44.5% |
| `GE65_Tot_Benes` | 88.0% |

## Blocked
- `pip install` failed on `dbt-core-experimental-parser` with an SSL certificate error. Same root cause as Week 1 (python.org build has no CA store). Its build script downloads a wheel from GitHub with `urllib`.
- `dbt debug` failed with "No such file or directory". `.data/...` is a hidden folder named `.data`, not the current directory.
- YAML parse errors: missing space after `-` and `:`, and two `key: value` pairs on one line.
- `dbt show` errors: queried `source()` for a column that only exists in the model; then passed two arguments to `ref()`.
- Typed `exit` and closed the terminal. `deactivate` is the command that leaves a venv.

## Learned
- YAML: indentation is the structure. `- ` starts a list item. `key: value` needs a space after the colon. Properties of the same object align in the same column. Need more practice.
- Staging model rules: minimal transformation, a single `select` from one source, no aggregation. Names must be self-explanatory so an agent or another person can use them with minimal context.
- `source('cms', 'prescriber_drug')` points to raw data declared in YAML. `ref('stg_cms__prescriber_drug')` points to a model by file name and requires `dbt run` first. `ref()` with two arguments means (package, model).
- Paths: `./` is the current directory, `../` is the parent directory. A name that starts with a dot (`.data`) is a hidden folder.
- Relative paths in `profiles.yml` and `external_location` resolve from where `dbt` is run, not from the YAML file. Always run dbt from `dbt/`.
- Config inheritance: settings on a parent (source, folder) apply to every child unless the child overrides them. A hardcoded `external_location` at source level would point every future table to the same files.
- Suppression: flag NULL means the value is present. `*` means the 65+ part is 1-10. `#` means the under-65 part is 1-10 (complementary suppression), so 65+ is close to the total. The reason carries bounds on the true value.
- Do not impute in staging. NULL means unknown, 0 means none, and an imputed 5.5 hides which values were observed. Estimate in marts or metrics, and use bounds (1 and 10) as a sensitivity check.
- A comparison like `Tot_Benes IS NULL` is already a boolean. No `CASE` needed. Prefix boolean columns with `is_`.
- Do not end a dbt model with a semicolon. dbt wraps the SQL in `create view ... as (...)`.
- `ELSE` should catch unexpected values, not stand in for a known one.
- Start from the questions, then metrics, then models. Keep only columns that serve a question.

## Next week
- S2: build two marts, prescriber-year and drug-year. Decide each grain and which columns are additive.
- S3: five data tests (`not_null`, `unique` on the grain, `accepted_values` on suppression labels). `dbt build` passes.
- S4: 10 metrics in `semantic/metrics.yml` and `semantic/data_dictionary.md`.
- Add "Questions this project answers" to `README.md` and fix its outdated 12-week / 5-hour text.
- Pin `dbt-core` and `dbt-duckdb` versions in `requirements.txt`.
- Optional renames in staging: `total_supply_n` to `total_day_supply`, `65+` to `ge65` in label values.
- SQL prep: window functions and CTEs, two sessions.
