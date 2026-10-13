WITH AGG_PRESCRIBER AS(
    SELECT year, SUM(total_claim_n) as prescriber_total_clm
    FROM {{ref('fct_prescriber_year')}}
    GROUP BY year
),

AGG_DRUG AS(
    SELECT year, SUM(total_claim_n) as drug_total_clm 
    FROM {{ref('fct_drug_year')}}
    GROUP BY year

)

SELECT D.year AS d_year, P.year AS p_year,
    prescriber_total_clm, drug_total_clm
FROM AGG_DRUG AS D 
FULL JOIN AGG_PRESCRIBER AS P 
ON D.year = P.year
WHERE prescriber_total_clm - drug_total_clm IS NULL OR prescriber_total_clm - drug_total_clm != 0
