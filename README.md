# Dashboard Condominio

Proyecto de Power BI Desktop con su libro de Excel de origen.

## Abrir después de clonar

1. Instala Power BI Desktop en Windows.
2. Clona este repositorio.
3. Con Power BI Desktop cerrado, haz doble clic en `abrir-dashboard.cmd`.

El iniciador apunta las consultas `Gastos` y `CEA` al Excel que está en la misma carpeta del proyecto y abre `Dashboard de resultados.pbip`. Puedes actualizar el reporte desde Power BI Desktop.

Power BI guarda la ruta del Excel como una ruta absoluta. Por eso, después de usar el iniciador, Git puede mostrar un cambio local en `Gastos.tmdl` y `CEA.tmdl`. Esos cambios de ruta son propios de cada computadora: revísalos antes de incluirlos en un commit.

## Contenido

- `Dashboard de resultados.pbip` y las carpetas `.Report` y `.SemanticModel`: definiciones del reporte y modelo.
- `Chapulin PRESUPUESTO JAC2026.xlsm`: datos de origen. Los vínculos antiguos a otros libros se eliminaron de esta copia.

El libro contiene información financiera y personal. Mantén el repositorio **privado** y concede acceso solo a quienes deban consultar esos datos.
