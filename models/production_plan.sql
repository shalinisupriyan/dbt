{{ config(
    materialized='view'
) }}

select
    *,
    date_trunc('month', date) as month
from {{ source('my_source', 'production_plan') }}
