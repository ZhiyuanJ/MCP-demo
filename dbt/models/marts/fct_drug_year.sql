WITH orig AS(
    SELECT * FROM {{ref("stg_cms__prescriber_drug")}}
),

intm AS(
    SELECT year, brand_name, generic_name,
        COUNT(*) AS npi_n,
        COUNT(DISTINCT provider_type) as provider_type_n,
        SUM(total_claim_n) as total_claim_n,
        sum(total_30days_fill_n) as total_30days_fill_n,
        sum(total_supply_n) as total_supply_n,
        sum(total_cost) as total_cost,

        sum(ge65_total_claim_n) as ge65_total_claim_n,
        -- denominator for share_claim_ge65: total claims only on rows where GE65 claims are not suppressed
        sum(CASE WHEN is_ge65_claim_suppressed THEN NULL ELSE total_claim_n END) AS ge65_unsuppressed_total_claim_n,
        max(is_ge65_claim_suppressed) as ever_ge65_claim_suppressed,
        count_if(is_ge65_claim_suppressed) as record_ge65_claim_suppressed_n,

        sum(ge65_total_30days_fill_n) as ge65_total_30days_fill_n,
        sum(ge65_total_supply_n) as ge65_total_supply_n,
        sum(ge65_total_cost) as ge65_total_cost
        
FROM orig
GROUP BY year, brand_name, generic_name
)

SELECT 
  year, brand_name, generic_name, npi_n, provider_type_n,
  total_claim_n, total_supply_n, total_cost, total_30days_fill_n,
  ge65_total_claim_n, ever_ge65_claim_suppressed, record_ge65_claim_suppressed_n,
  ge65_total_30days_fill_n, ge65_total_supply_n, ge65_total_cost,

  total_claim_n/nullif(npi_n,0) AS claim_per_npi,
  total_supply_n/nullif(npi_n,0) as supply_per_npi,
  total_cost/nullif(npi_n,0) as cost_per_npi,
  total_30days_fill_n/nullif(npi_n,0) as fill_30day_per_npi,

  record_ge65_claim_suppressed_n/nullif(npi_n,0) as share_npi_ge65_suppressed,

  total_supply_n/nullif(total_claim_n,0) as supply_per_claim,
  total_cost/nullif(total_claim_n,0) as cost_per_claim,
  total_cost/nullif(total_supply_n,0) as cost_per_supply,
  total_30days_fill_n/nullif(total_claim_n,0) as fill_30day_per_claim,
  
  ge65_total_claim_n/nullif(ge65_unsuppressed_total_claim_n,0) as share_claim_ge65,
  ge65_total_supply_n/nullif(ge65_total_claim_n,0) as ge65_supply_per_claim,
  ge65_total_cost/nullif(ge65_total_claim_n,0) as ge65_cost_per_claim,
  ge65_total_30days_fill_n/nullif(ge65_total_claim_n,0) as ge65_fill_30day_per_claim,
  ge65_total_cost/nullif(ge65_total_supply_n,0) as ge65_cost_per_supply
FROM intm