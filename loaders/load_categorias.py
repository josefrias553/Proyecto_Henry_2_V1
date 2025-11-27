import csv
from sqlalchemy import exc
from M2_V1.db import SessionLocal
from M2_V1.models import Categoria
from M2_V1.utils import map_row_keys, exists_by_unique, get_csv_path

CSV_PATH = get_csv_path("2.Categorias.csv")

def load_categorias(csv_path=CSV_PATH):
    with SessionLocal() as session:
        created = 0
        with open(csv_path, encoding="utf-8") as f:
            reader = csv.DictReader(f)
            for raw in reader:
                row = map_row_keys(raw)

                nombre = row.get("nombre")
                if not nombre:
                    continue
                nombre = nombre.strip()

                if exists_by_unique(session, Categoria, nombre=nombre):
                    continue

                c = Categoria(
                    nombre=nombre,
                    descripcion=row.get("descripcion") or None
                )
                session.add(c)
                created += 1

        try:
            session.commit()
        except exc.SQLAlchemyError:
            session.rollback()
            raise

        print(f"[Categorias] Inserciones: {created}")