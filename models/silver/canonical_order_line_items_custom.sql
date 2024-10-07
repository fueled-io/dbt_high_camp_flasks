-- Canonical dimensions about order line items that are specific to a given merchant,
-- not all merchants.

select
    coli.order_id,
    coli.order_line_id,
    coli.sku,
from {{ ref("canonical_order_line_items") }} as coli