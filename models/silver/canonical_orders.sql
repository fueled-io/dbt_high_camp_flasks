{{ config(
    materialized='ephemeral'
) }}

select
    so.order_id,
    so.order_number,
    so.customer_id,
    so.email,
    so.referring_site,
    so.landing_site_base_url,
    so.billing_address_first_name as billing_first_name,
    so.billing_address_last_name as billing_last_name,
    so.billing_address_phone as billing_phone,
    so.billing_address_company as billing_company,
    so.billing_address_address_1 as billing_address_1,
    so.billing_address_address_2 as billing_address_2,
    so.billing_address_city as billing_address_city,
    so.billing_address_province as billing_state,
    so.billing_address_province_code as billing_state_code,
    so.billing_address_zip as billing_zip,
    so.billing_address_country as billing_country,
    so.billing_address_country_code as billing_country_code,
    so.subtotal_price,
    so.total_line_items_price,
    so.total_price,
    so.total_discounts,
    so.total_tax,
    so.source_name,
    so.tags as order_tags,
    so.financial_status,
    so.fulfillment_status,
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
    os.first_order_id as customers_first_order_id,
    os.first_order_date as customers_first_order_date,
    os.first_order_marketing_source,
    os.first_order_marketing_medium,
    os.days_between_orders as days_between_customers_first_and_current_order,
    os.months_between_orders_rounded_down
    as months_rounded_down_between_customers_first_and_current_order

from 
    {{ ref("shopify__orders") }} so
left join 
    {{ ref("stg_order_sequencing") }} os 
on 
    so.order_id = os.order_id
