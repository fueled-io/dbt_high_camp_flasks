{{ config(
    materialized='ephemeral'
) }}

SELECT
    so.order_id,
    so.order_number,
    so.customer_id,
    so.email,
    so.referring_site,
    so.landing_site_base_url,
    so.billing_address_first_name AS billing_first_name,
    so.billing_address_last_name AS billing_last_name,
    so.billing_address_phone AS billing_phone,
    so.billing_address_company AS billing_company,
    so.billing_address_address_1 AS billing_address_1,
    so.billing_address_address_2 AS billing_address_2,
    so.billing_address_city AS billing_address_city,
    so.billing_address_province AS billing_state,
    so.billing_address_province_code AS billing_state_code,
    so.billing_address_zip AS billing_zip,
    so.billing_address_country AS billing_country,
    so.billing_address_country_code AS billing_country_code,
    so.subtotal_price,
    so.total_line_items_price,
    so.total_price,
    so.total_discounts,
    so.total_tax,
    so.total_refund_amount,
    so.source_name,
    so.tags AS order_tags,
    so.financial_status,
    so.fulfillment_status,
    so.fulfillment_timestamp,
    so.cancel_reason,
    so.created_at_timestamp,
    so.updated_timestamp,
    so.cancelled_timestamp,
    so.currency,
    so.total_units_sold,  -- Total quantity of units sold
    so.total_shipping_fees,  -- Total shipping fees
    so.total_order_cogs,  -- Total cost of goods sold
    -- Order sequencing and customer details
    os.customer_order_seq_number,
    os.first_order_id AS customers_first_order_id,
    os.first_order_date AS customers_first_order_date,
    os.first_order_marketing_source,
    os.first_order_marketing_medium,
    os.days_since_first_order,
    os.months_since_first_order_rounded_down,
    os.days_since_prev_order,
    os.months_since_prev_order_rounded_down
FROM 
    {{ ref("shopify__orders") }} so
LEFT JOIN 
    {{ ref("stg_order_sequencing") }} os 
ON 
    so.order_id = os.order_id
