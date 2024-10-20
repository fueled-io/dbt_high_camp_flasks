{{ config(materialized="table") }}

select 
    co.*,
from {{ ref("canonical_orders") }} co