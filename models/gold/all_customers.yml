{{ config(materialized="table") }}

-- Subqueries to determine if a customer has purchased coffee and has an active coffee
-- subscription.
-- Then, we add Faraday predictions to the end of the model.
with
coffee_orders as (
    -- Max() function returns true if any order returns true value.
    select
        co.customer_id,
        max(co.contains_coffee_sku) as has_purchased_coffee
    from {{ ref("orders") }} as co
    group by co.customer_id
),

coffee_subscription as (
    select
        shopify_customer_id,
        -- Use max to ensure one row per customer
        max(has_active_coffee_subscription) as has_active_coffee_subscription
    from {{ ref("subscribers") }}
    group by shopify_customer_id
),

oats_subscription as (
    select
        shopify_customer_id,
        -- Use max to ensure one row per customer
        max(has_active_oats_subscription) as has_active_oats_subscription
    from {{ ref("subscribers") }}
    group by shopify_customer_id
)

select
    cc.*,
    -- Use COALESCE to replace NULL with FALSE
    cp.fdy_persona_set_customers_personas_v1_persona_name as persona,
    cp.fdy_outcome_churn_risk_propensity_probability as churn_risk_probability,
    -- Use COALESCE to replace NULL with FALSE
    cp.fdy_outcome_churn_risk_propensity_percentile as churn_risk_percentile,
    cp.fdy_outcome_customers_to_high_spenders_propensity_probability
        as high_spender_probability,
    cp.fdy_outcome_customers_to_high_spenders_propensity_percentile
        as high_spender_percentile,
    cp.fdy_outcome_national_outcome_likely_to_provide_5_star_reviews_propensity_probability
        as five_star_review_probability,
    cp.fdy_outcome_national_outcome_likely_to_provide_5_star_reviews_propensity_percentile
        as five_star_review_percentile,
    coalesce(co.has_purchased_coffee, false) as has_purchased_coffee,
    coalesce(
        cs.has_active_coffee_subscription, false
    -- Use COALESCE to replace NULL with FALSE
    ) as has_active_coffee_subscription,
    coalesce(os.has_active_oats_subscription, false)
        as has_active_oats_subscription
from {{ ref("canonical_customers") }} as cc
left join
    {{ ref("customer_predictions") }} as cp
    on cast(cp.customer_id as string) = cast(cc.customer_id as string)
left join coffee_orders as co on cc.customer_id = co.customer_id
left join
    coffee_subscription as cs
    -- Ensure the types match
    on cast(cc.customer_id as string) = cs.shopify_customer_id
left join
    oats_subscription as os
    -- Ensure the types match
    on cast(cc.customer_id as string) = os.shopify_customer_id
