select
    sol.*,
    spt.tags,
    sso.created_timestamp as order_created_at
from {{ ref("shopify__order_lines") }} as sol
left join {{ ref("stg_product_tags") }} as spt on sol.sku = spt.sku
left join {{ ref("stg_shopify__order") }} as sso on sol.order_id = sso.order_id