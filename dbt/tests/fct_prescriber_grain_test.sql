SELECT year, npi, count(*) as count 
FROM {{ ref('fct_prescriber_year') }}
GROUP BY year, npi
HAVING count > 1