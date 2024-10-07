with
    -- Extracts relevant order lines and their tags
    order_product_tags as (
        select
            o.order_id,
            o.customer_id,
            oli.order_line_id,
            oli.product_id,
            oli.quantity,
            tag
        from {{ ref("shopify__order_lines") }} as oli
        inner join {{ ref("shopify__orders") }} as o on oli.order_id = o.order_id
        inner join {{ ref("stg_product_tags") }} as pt on oli.product_id = pt.product_id,
        unnest(pt.tags) as tag
    ),
    -- Aggregates tag counts per customer and tag
    customer_tag_counts as (
        select
            customer_id,
            tag,
            sum(quantity) as tag_count
        from order_product_tags
        group by customer_id, tag
    ),
    -- Aggregates total tag counts per customer
    customer_total_tag_counts as (
        select
            customer_id,
            sum(tag_count) as total_tag_count
        from customer_tag_counts
        group by customer_id
    ),
    -- Calculates tag percentages per customer
    customer_tag_counts_with_percentage as (
        select
            ctc.customer_id,
            ctc.tag,
            ctc.tag_count,
            ctc.tag_count / cttc.total_tag_count as tag_percentage
        from customer_tag_counts ctc
        join customer_total_tag_counts cttc on ctc.customer_id = cttc.customer_id
    )

-- Aggregates final counts and percentages for specific tags per customer
select
    ctcwp.customer_id,
    sum(case when ctcwp.tag = 'fruit-flavor' then ctcwp.tag_count else 0 end) as fruit_flavor_units_purchased,
    sum(case when ctcwp.tag = 'fruit-flavor' then ctcwp.tag_percentage else 0 end) as fruit_flavor_units_percentage_of_total,
    sum(case when ctcwp.tag = 'vegan' then ctcwp.tag_count else 0 end) as vegan_units_purchased,
    sum(case when ctcwp.tag = 'vegan' then ctcwp.tag_percentage else 0 end) as vegan_units_percentage_of_total,
    sum(case when ctcwp.tag = 'whey-protein' then ctcwp.tag_count else 0 end) as whey_units_purchased,
    sum(case when ctcwp.tag = 'whey-protein' then ctcwp.tag_percentage else 0 end) as whey_units_percentage_of_total,
    sum(case when ctcwp.tag = 'caffeinated' then ctcwp.tag_count else 0 end) as caffeinated_units_purchased,
    sum(case when ctcwp.tag = 'caffeinated' then ctcwp.tag_percentage else 0 end) as caffeinated_units_percentage_of_total,
    case 
        when sum(case when ctcwp.tag = 'whey-protein' then ctcwp.tag_percentage else 0 end) > sum(case when ctcwp.tag = 'vegan' then ctcwp.tag_percentage else 0 end) 
        then 'whey' 
        else 'vegan' 
    end as whey_vs_vegan
from customer_tag_counts_with_percentage ctcwp
group by ctcwp.customer_id
