select
    categoria_id,
    nombre,
    descripcion
from {{ ref('stg_categorias') }}