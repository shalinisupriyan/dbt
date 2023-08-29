-- Model: production_backlog.sql
select
    month,
    units_planned - units_manufactured as production_backlog
from
    {{ ref('manufactured_planned') }};
