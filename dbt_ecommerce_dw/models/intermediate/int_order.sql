with ordenes as (
    select * from {{ ref('stg_ordenes') }}
)
select
    o.orden_id,
    o.usuario_id,
    o.fecha_orden,
    o.total,
    o.estado
from ordenes o