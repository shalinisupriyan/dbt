-- models/production_plan.sql

{{ config(
    materialized='table',
    unique_key='month'
) }}

with production_data as (
    select
        date_trunc('month', date) as month,
        pn,
        sum(plan) as planned_units
    from
        {{ source('elephantsql_source', 'production_plan') }}
    group by
        1, 2
)

select
    *,
    lag(planned_units, 1, 0) over (order by month) as cumulative_planned_units
from
    production_data
order by
    month;
