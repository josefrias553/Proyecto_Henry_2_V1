select
    direccion_id,
    usuario_id,
    calle,
    ciudad,
    provincia,
    pais,
    codigo_postal
from {{ ref('stg_direccionesenvio') }}