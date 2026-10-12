
SELECT 
    year,
    Prscrbr_NPI as npi,
    Prscrbr_City as city,
    Prscrbr_State_Abrvtn as state,
    Prscrbr_Type as provider_type,
    Prscrbr_Type_Src as provider_type_source,
    Brnd_Name as brand_name,
    Gnrc_Name as generic_name,
    Tot_Clms as total_claim_n,
    Tot_30day_Fills as total_30days_fill_n,
    Tot_day_Suply as total_supply_n,
    Tot_Drug_Cst as total_cost, 
    Tot_Benes as total_bene_n,
    Tot_Benes IS NULL AS is_total_bene_suppressed, --Binary suppress indicator

    GE65_Tot_Clms AS ge65_total_claim_n,
    GE65_Tot_CLms IS NULL AS is_ge65_claim_suppressed,
    CASE WHEN GE65_Sprsn_Flag IS NULL THEN 'not_suppressed' 
        WHEN GE65_Sprsn_Flag = '*' THEN 'suppressed_ge65_small_cell'
        WHEN GE65_Sprsn_Flag = '#' THEN 'suppressed_below_65_small_cell'
        ELSE 'Other'
    END AS why_ge65_claim_suppressed,

    GE65_Tot_30day_Fills as ge65_total_30days_fill_n,
    GE65_Tot_Day_Suply as ge65_total_supply_n,
    GE65_Tot_Drug_Cst as ge65_total_cost,

    GE65_Tot_Benes AS ge65_total_bene,
    GE65_Tot_Benes IS NULL AS is_ge65_total_bene_suppressed,
    CASE WHEN GE65_Bene_Sprsn_Flag IS NULL THEN 'not_suppressed' 
        WHEN GE65_Bene_Sprsn_Flag = '*' THEN 'suppressed_65+_small_cell'
        WHEN GE65_Bene_Sprsn_Flag = '#' THEN 'suppressed_below_65_small_cell' 
        ELSE 'Other'
    END AS why_ge65_bene_suppressed

FROM {{source('cms', 'prescriber_drug')}}