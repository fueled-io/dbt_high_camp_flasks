{{ config(
    materialized='ephemeral'
) }}

select
    ad_group_campaign_id,
    ad_group_id,
    ad_group_segments_date,
    sum(metrics_cost_micros) / 1e6 as total_ad_spend  -- Convert micros to standard currency
from {{ ref("stg_google_ads_airbyte__ad_group") }}
group by ad_group_campaign_id, ad_group_id, ad_group_segments_date
