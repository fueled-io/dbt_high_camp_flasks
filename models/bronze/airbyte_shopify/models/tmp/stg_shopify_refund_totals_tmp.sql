{{ config(
    materialized='ephemeral'
) }}

select
    id as order_id,
    SUM(CAST(JSON_VALUE(refund_line_item, '$.subtotal') AS FLOAT64)) as total_refund_amount
from {{ source('shopify_prod_airbyte','orders') }},
unnest(JSON_EXTRACT_ARRAY(refunds)) as refund,
unnest(JSON_EXTRACT_ARRAY(refund, '$.refund_line_items')) as refund_line_item
group by order_id
