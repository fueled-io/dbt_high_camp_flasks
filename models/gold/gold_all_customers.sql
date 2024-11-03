{{ config(materialized="table") }}

SELECT
    customer_id,
    email,
    first_name,
    last_name,
    phone,
    customer_tags,
    -- Billing address columns excluded
    billing_city,
    billing_state,
    billing_country,
    customer_lifetime_order_count,
    customer_lifetime_total_value_avg,
    first_order_referring_site,
    first_order_timestamp,
    TIMESTAMP(FORMAT_TIMESTAMP('%F %T', first_order_timestamp, 'America/Los_Angeles')) AS first_order_timestamp_pt,
    days_since_first_order,
    most_recent_order_referring_site,
    most_recent_order_timestamp,
    TIMESTAMP(FORMAT_TIMESTAMP('%F %T', most_recent_order_timestamp, 'America/Los_Angeles')) AS most_recent_order_timestamp_pt,
    days_since_most_recent_order,
    shopify_customer_created_at,
    TIMESTAMP(FORMAT_TIMESTAMP('%F %T', shopify_customer_created_at, 'America/Los_Angeles')) AS shopify_customer_created_at_pt,
    shopify_customer_updated_at,
    TIMESTAMP(FORMAT_TIMESTAMP('%F %T', shopify_customer_updated_at, 'America/Los_Angeles')) AS shopify_customer_updated_at_pt

FROM {{ ref("canonical_customers") }}
