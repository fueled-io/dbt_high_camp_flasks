{{ config(materialized="table") }}

select 
    cs.*,
    csc.* except(sku, product_type) -- Include all columns from both tables, excluding the duplicate sku and product_type.
from {{ ref("canonical_skus") }} cs
join {{ ref("canonical_skus_custom") }} csc on cs.sku = csc.sku