with usuarios as (
    select * from {{ ref('stg_usuarios') }}
),
direcciones as (
    select * from {{ ref('stg_direccionesenvio') }}
)

select
    u.usuario_id as customer_id,
    u.nombre,
    u.apellido,
    u.email,
    u.fecha_registro,
    d.pais,
    d.ciudad,
    d.provincia,
    d.codigo_postal
from usuarios u
left join direcciones d
    on u.usuario_id = d.usuario_id