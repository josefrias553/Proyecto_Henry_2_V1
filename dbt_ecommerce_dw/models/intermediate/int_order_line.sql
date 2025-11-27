with detalle as (
    select * from {{ ref('stg_detalleordenes') }}
),
ordenes as (
    select * from {{ ref('stg_ordenes') }}
),
productos as (
    select * from {{ ref('stg_productos') }}
)
select
    d.detalle_id,
    d.orden_id,
    o.usuario_id,
    d.producto_id,
    p.nombre as producto_nombre,
    d.cantidad,
    d.precio_unitario,
    d.cantidad * d.precio_unitario as total,
    o.fecha_orden,
    o.estado
from detalle d
join ordenes o on d.orden_id = o.orden_id
join productos p on d.producto_id = p.producto_id