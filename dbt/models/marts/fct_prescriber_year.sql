WITH orig AS(
    SELECT * FROM {{ref("stg_cms__prescriber_drug")}}
),

intm AS(
  SELECT 
    year, npi, any_value(city) AS city, any_value(state) as state, any_value(provider_type) as provider_type, any_value(provider_type_source) as provider_type_source,
    generic_name,
    COUNT(*) as drug_n,

    SUM(total_claim_n) as total_claim_n,
    SUM(total_30days_fill_n) as total_30days_fill_n,
    sum(total_supply_n) as total_supply_n,
    sum(total_cost) as total_cost,
    --sum(total_bene_n) as total_bene_n,
    --max(is_total_bene_suppressed) AS ever_total_bene_suppressed,
    --sum(case when is_total_bene_suppressed = True THEN 1 ELSE 0 END)  AS record_total_bene_suppressed_n,
    
    sum(ge65_total_claim_n) as ge65_total_claim_n,
    max(is_ge65_claim_suppressed) as ever_ge65_claim_suppressed,
    sum(case when is_ge65_claim_suppressed = True THEN 1 else 0 END) AS record_ge65_claim_suppressed_n,
    
    sum(ge65_total_30days_fill_n) as ge65_total_30days_fill_n,
    sum(ge65_total_supply_n) as ge65_total_supply_n,
    sum(ge65_total_cost) as ge65_total_cost
    
    --sum(ge65_total_bene) as ge65_total_bene,
    --max(is_ge65_total_bene_suppressed) as ever_ge65_total_bene_suppressed,
    --sum(case when is_ge65_total_bene_suppressed = True THEN 1 ELSE 0 END) as record_ge65_total_bene_suppressed_n
    
    FROM orig
    GROUP BY year, npi, generic_name)

SELECT 
  year, npi, any_value(city) AS city, any_value(state) as state, any_value(provider_type) as provider_type, any_value(provider_type_source) as provider_type_source,
  COUNT(*) AS generic_n, 
  sum(drug_n) as drug_n,
  
  SUM(total_claim_n) as total_claim_n,
  SUM(total_30days_fill_n) as total_30days_fill_n,
  sum(total_supply_n) as total_supply_n,
  sum(total_cost) as total_cost,
  --sum(total_bene_n) as total_bene_n,
  --max(ever_total_bene_suppressed) AS ever_total_bene_suppressed,
  --sum(record_total_bene_suppressed_n)  AS record_total_bene_suppressed_n,
  
  sum(ge65_total_claim_n) as ge65_total_claim_n,
  max(ever_ge65_claim_suppressed) as ever_ge65_claim_suppressed,
  sum(record_ge65_claim_suppressed_n) AS record_ge65_claim_suppressed_n,
  
  sum(ge65_total_30days_fill_n) as ge65_total_30days_fill_n,
  sum(ge65_total_supply_n) as ge65_total_supply_n,
  sum(ge65_total_cost) as ge65_total_cost
  
  --sum(ge65_total_bene) as ge65_total_bene,
  --max(ever_ge65_total_bene_suppressed) as ever_ge65_total_bene_suppressed,
  --sum(record_ge65_total_bene_suppressed_n) as record_ge65_total_bene_suppressed_n
  
  FROM intm
  GROUP BY year, npi
