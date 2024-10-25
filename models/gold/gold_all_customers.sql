{{ config(materialized="table") }}

select
    cc.*
from {{ ref("canonical_customers") }} as cc