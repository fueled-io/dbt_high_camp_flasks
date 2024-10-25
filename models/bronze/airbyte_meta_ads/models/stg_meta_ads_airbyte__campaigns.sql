with 

source as (

    select * from {{ source('meta_ads_airbyte', 'campaigns') }}

),

renamed as (

    select
        _airbyte_raw_id,
        _airbyte_extracted_at,
        _airbyte_meta,
        _airbyte_generation_id,
        id as campaign_id,
        name as campaign_name,
        status,
        adlabels,
        objective,
        spend_cap,
        stop_time,
        account_id,
        start_time,
        buying_type,
        issues_info,
        bid_strategy,
        created_time,
        daily_budget,
        updated_time,
        lifetime_budget,
        budget_remaining,
        effective_status,
        boosted_object_id,
        configured_status,
        source_campaign_id,
        special_ad_category,
        smart_promotion_type,
        budget_rebalance_flag,
        special_ad_category_country

    from source

)

select * from renamed
