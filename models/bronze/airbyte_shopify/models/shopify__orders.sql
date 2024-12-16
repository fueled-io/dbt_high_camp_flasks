{{ config(
    materialized='ephemeral'
) }}

select
    o.order_id,
    o.order_number,
    o.customer_id,
    o.email,
    o.created_at_timestamp,
    o.updated_at as updated_timestamp,
    o.cancelled_at as cancelled_timestamp,
    o.source_name,
    u.total_quantity as total_units_sold,  -- Added total_quantity from the units sold table
    o.total_line_items_price,
    o.subtotal_price,
    o.total_price,
    o.total_discounts,
    o.total_tax,
    r.total_refund_amount,
    c.total_order_cogs,
    o.currency,
    s.total_shipping_fees,  -- Added total_shipping_fee from stg_shopify_orders_tmp.sql
    o.financial_status,
    o.fulfillment_status,
    f.most_recent_fulfillment_created_at as fulfillment_timestamp, -- Added most recent fulfillment created_at from stg_shopify_fulfillments_tmp.sql
    o.cancel_reason,
    o.tags,
    o.referring_site,
    o.landing_site_base_url,
    o.billing_address_1 as billing_address_address_1,
    o.billing_address_2 as billing_address_address_2,
    o.billing_city as billing_address_city,
    o.billing_company as billing_address_company,
    o.billing_country as billing_address_country,
    o.billing_country_code as billing_address_country_code,
    o.billing_first_name as billing_address_first_name,
    o.billing_last_name as billing_address_last_name,
    o.billing_latitude as billing_address_latitude,
    o.billing_longitude as billing_address_longitude,
    o.billing_name as billing_address_name,
    o.billing_phone as billing_address_phone,
    o.billing_province as billing_address_province,
    o.billing_province_code as billing_address_province_code,
    o.billing_zip as billing_address_zip,
from 
    {{ ref('stg_shopify_orders_tmp') }} as o
left join 
    {{ ref('stg_shopify_orders_units_sold_tmp') }} as u on o.order_id = u.order_id
left join 
    {{ ref('stg_shopify_orders_shipping_fees_tmp') }} as s on o.order_id = s.order_id
left join
    {{ ref('stg_shopify_orders_cogs_tmp') }} as c on o.order_id = c.order_id
left join
    {{ ref('stg_shopify_refunds_tmp') }} as r on o.order_id = r.order_id
left join
    {{ ref('stg_shopify_fulfillments_tmp') }} as f on o.order_id = f.order_id
