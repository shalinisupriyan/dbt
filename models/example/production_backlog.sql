{{ config(
    materialized='table'
) }}

select
    ms.month,
    ms.units_planned - ms.units_manufactured as production_backlog
from {{ ref('monthly_summary') }} ms
