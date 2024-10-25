select
    campaign_id,
    campaign_name,
    objective,
    spend_cap,
    start_time,
    stop_time,
    daily_budget,
    lifetime_budget,
    effective_status,
    buying_type
from {{ ref("stg_meta_ads_airbyte__campaigns") }}
