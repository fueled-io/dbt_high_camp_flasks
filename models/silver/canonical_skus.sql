-- Technically, SKU is not a unique parameter in Shopify's data model.
-- Two variants can have the same SKU. Therefore, we grab the most recently updated
-- variant for each SKU to get pricing. It's not perfect, and should be refactored.
with
    ranked_variants as (
        select
            sku,
            product_id,
            variant_id,
            inventory_item_id,
            title as sku_title,
            price,
            compare_at_price,
            is_taxable,
            tax_code,
            barcode,
            grams,
            weight,
            option_1,
            option_2,
            option_3,
            created_timestamp as variant_created_at,
            updated_timestamp as variant_updated_at,
            row_number() over (partition by sku order by updated_timestamp desc) as rn
        from {{ ref("stg_shopify__product_variant") }}
        where sku is not null and sku != ''
    )

-- TODO: Join with shopify_product by shopify_product_id 
select rv.*, sp.* except (product_id, created_timestamp, updated_timestamp)
from ranked_variants rv
left join {{ ref("shopify__products") }} sp on rv.product_id = sp.product_id
where rn = 1
