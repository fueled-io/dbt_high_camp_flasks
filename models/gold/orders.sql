{{ config(materialized="table") }}

select 
    co.*,
    coc.* except(order_id) -- Include all columns from both tables, excluding the duplicate order_id
from {{ ref("canonical_orders") }} co
join {{ ref("canonical_orders_custom") }} coc on co.order_id = coc.order_id