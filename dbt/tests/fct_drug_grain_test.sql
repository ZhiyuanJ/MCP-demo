SELECT year, brand_name, generic_name, COUNT(*) as count
FROM {{ ref('fct_drug_year') }}
GROUP BY year, brand_name, generic_name 
HAVING count > 1