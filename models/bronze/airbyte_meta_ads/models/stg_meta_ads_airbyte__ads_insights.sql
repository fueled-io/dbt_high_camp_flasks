
    select
        cpc,
        cpm,
        cpp,
        ctr,
        ad_id,
        reach,
        spend,
        clicks,
        actions,
        ad_name,
        adset_id,
        wish_bid,
        date_stop,
        frequency,
        objective,
        account_id,
        adset_name,
        date_start,
        unique_ctr,
        auction_bid,
        buying_type,
        campaign_id,
        conversions,
        impressions,
        website_ctr,
        account_name,
        created_time,
        social_spend,
        updated_time,
        action_values,
        campaign_name,
        purchase_roas,
        unique_clicks,
        unique_actions,
        full_view_reach,
        outbound_clicks,
        quality_ranking,
        account_currency,
        ad_click_actions,
        conversion_values,
        cost_per_ad_click,
        cost_per_thruplay,
        optimization_goal,
        inline_link_clicks,
        video_play_actions,
        attribution_setting,
        cost_per_conversion,
        outbound_clicks_ctr,
        canvas_avg_view_time,
        cost_per_action_type,
        ad_impression_actions,
        catalog_segment_value,
        cost_per_unique_click,
        full_view_impressions,
        inline_link_click_ctr,
        website_purchase_roas,
        estimated_ad_recallers,
        inline_post_engagement,
        unique_link_clicks_ctr,
        unique_outbound_clicks,
        auction_competitiveness,
        canvas_avg_view_percent,
        catalog_segment_actions,
        conversion_rate_ranking,
        converted_product_value,
        cost_per_outbound_click,
        engagement_rate_ranking,
        mobile_app_purchase_roas,
        video_play_curve_actions,
        unique_inline_link_clicks,
        video_p25_watched_actions,
        video_p50_watched_actions,
        video_p75_watched_actions,
        video_p95_watched_actions,
        auction_max_competitor_bid,
        converted_product_quantity,
        cost_per_15_sec_video_view,
        cost_per_inline_link_click,
        unique_outbound_clicks_ctr,
        video_p100_watched_actions,
        video_time_watched_actions,
        cost_per_unique_action_type,
        unique_inline_link_click_ctr,
        video_15_sec_watched_actions,
        video_30_sec_watched_actions,
        cost_per_unique_outbound_click,
        video_avg_time_watched_actions,
        cost_per_estimated_ad_recallers,
        cost_per_inline_post_engagement,
        cost_per_unique_inline_link_click,
        instant_experience_clicks_to_open,
        instant_experience_clicks_to_start,
        instant_experience_outbound_clicks,
        video_play_retention_graph_actions,
        cost_per_2_sec_continuous_video_view,
        video_play_retention_0_to_15s_actions,
        video_continuous_2_sec_watched_actions,
        video_play_retention_20_to_60s_actions,
        qualifying_question_qualify_answer_rate,
        catalog_segment_value_omni_purchase_roas,
        catalog_segment_value_mobile_purchase_roas,
        catalog_segment_value_website_purchase_roas

    from {{ source('meta_ads_airbyte', 'ads_insights') }}