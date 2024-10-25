select
    ad_id, ad_name, campaign_id, date_start, spend, clicks, impressions, cpc, cpm, ctr
    FROM {{ ref("stg_meta_ads_airbyte__ads_insights") }}