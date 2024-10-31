{{ config(
    materialized='ephemeral'
) }}

select
    id as order_id,  -- The Shopify Order ID
    sum(cast(json_extract_scalar(item, '$.quantity') as int64)) as total_quantity
from
    {{ source('shopify_prod_airbyte', 'orders') }},
    unnest(json_extract_array(line_items)) as item
group by
    order_id
