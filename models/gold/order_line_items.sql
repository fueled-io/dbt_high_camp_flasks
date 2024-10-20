{{ config(enabled=false) }}

{{ config(materialized="table") }}

-- Include all columns from both tables, excluding the duplicate order_line_id
select
    coli.*,
    ---colic.* except (order_id, order_line_id, sku)
from {{ ref("canonical_order_line_items") }} as coli
-- inner join
--     {{ ref("canonical_order_line_items_custom") }} as colic
--     on coli.order_line_id = colic.order_line_id
