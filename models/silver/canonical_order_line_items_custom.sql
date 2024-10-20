-- Canonical dimensions about order line items that are specific to a given merchant,
-- not all merchants.


{{ config(
  enabled=false
) }}

select
    * 
from {{ ref("canonical_order_line_items") }} as coli