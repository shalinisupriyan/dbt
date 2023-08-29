-- Model: manufactured_planned.sql
with manufactured_units as (
    select
        date_trunc('month', production_date) as month,
        sum(units) as units_manufactured
    from
        {{ source('elephantsql_source', 'manufacturing_units') }}
    group by 1
),
planned_units as (
    select
        date_trunc('month', planned_date) as month,
        sum(units_planned) as units_planned
    from
        {{ source('elephantsql_source', 'production_plan') }}
    group by 1
)

select
    m.month,
    coalesce(m.units_manufactured, 0) as units_manufactured,
    coalesce(p.units_planned, 0) as units_planned
from
    manufactured_units m
full outer join
    planned_units p
on m.month = p.month
order by m.month;
