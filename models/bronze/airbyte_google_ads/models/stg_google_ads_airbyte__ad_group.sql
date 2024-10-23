with

    source as (select * from {{ source("google_ads_airbyte", "ad_group") }}),

    renamed as (

        select
            ad_group_id,
            campaign_id as ad_campaign_id,
            ad_group_name,
            ad_group_type,
            segments_date,
            ad_group_labels,
            ad_group_status,
            ad_group_campaign,
            metrics_cost_micros,
            ad_group_target_roas,
            ad_group_base_ad_group,
            ad_group_resource_name,
            ad_group_cpc_bid_micros,
            ad_group_cpm_bid_micros,
            ad_group_cpv_bid_micros,
            ad_group_ad_rotation_mode,
            ad_group_final_url_suffix,
            ad_group_target_cpa_micros,
            ad_group_target_cpm_micros,
            ad_group_effective_target_roas,
            ad_group_tracking_url_template,
            ad_group_url_custom_parameters,
            ad_group_percent_cpc_bid_micros,
            ad_group_effective_target_cpa_micros,
            ad_group_effective_target_cpa_source,
            ad_group_optimized_targeting_enabled,
            ad_group_display_custom_bid_dimension,
            ad_group_effective_target_roas_source,
            ad_group_excluded_parent_asset_field_types,
            ad_group_targeting_setting_target_restrictions

        from source

    )

select *
from renamed
