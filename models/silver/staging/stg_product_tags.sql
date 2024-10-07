select
    pv.sku,
    p.product_id,
    pv.variant_id,
    p.title,
    array_agg(pt.value) as tags
from {{ ref("stg_shopify__product") }} as p
inner join
    {{ ref("stg_shopify__product_variant") }} as pv
    on p.product_id = pv.product_id
inner join
    {{ ref("stg_shopify__product_tag") }} as pt
    on p.product_id = pt.product_id
where pv.sku like '40-%'
group by p.product_id, pv.variant_id, p.title, pv.sku
