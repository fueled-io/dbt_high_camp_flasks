select distinct campaign_id, campaign_name, campaign_status
from {{ ref("stg_google_ads_airbyte__campaign") }}
