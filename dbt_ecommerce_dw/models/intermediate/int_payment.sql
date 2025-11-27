with pagos as (
    select * from {{ ref('stg_historialpagos') }}
),
metodos as (
    select * from {{ ref('stg_metodospago') }}
)
select
    p.pago_id,
    p.orden_id,
    p.metodo_pago_id,
    m.nombre as metodo_nombre,
    m.descripcion as metodo_descripcion,
    p.monto,
    p.fecha_pago,
    p.estado_pago
from pagos p
left join metodos m on p.metodo_pago_id = m.metodo_pago_id