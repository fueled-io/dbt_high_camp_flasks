{{ config(materialized="table") }}

select coli.*, colic.* except (order_id, order_line_id, sku)  -- Include all columns from both tables, excluding the duplicate order_line_id
from {{ ref("canonical_order_line_items") }} coli
join
    {{ ref("canonical_order_line_items_custom") }} colic
    on coli.order_line_id = colic.order_line_id
