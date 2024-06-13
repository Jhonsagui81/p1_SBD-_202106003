-- ----------------------------------------
-- Bodega
-- ----------------------------------------
-- bod_id (#)
-- bod_encargado
-- bod_direccion
-- bod_stock_productos
-- bod_tb_id (foranea)

-- ----------------------------------------
-- tipo_bodega
-- ----------------------------------------
-- tb_id (#)
-- tb_descripcion (partes, productos terminados, media, reclamos)

-- ----------------------------------------
-- tipo_etapas
-- ----------------------------------------
-- id (#)
-- etapa (inicio, intermedio, finalizacion)
-- costo_funcionamiento
-- id_producto


-- ----------------------------------------
-- Partes
-- ----------------------------------------
-- Par_id (#)
-- Par_codigo
-- Par_nombre
-- Par_color
-- Par_tipo
-- Par_garantia
-- Par_costo
-- Par_pro_id (foranea)


-- ----------------------------------------
-- Producto 
-- ----------------------------------------
-- Pro_id (#)
-- Pro_codigo
-- Pro_nombre
-- Pro_marca
-- Pro_fecha finalizo
-- Pro_costo_fabricacion (manoobra y maquinaria)
-- Pro_costo_verificacion
-- Pro_costo_partes
-- Pro_id_empleado_finalizo (foranea)
-- Pro_id_puesto_finalizado (foranea)
-- Pro_id_bodega (foranea)


-- ----------------------------------------
-- tipo_linea
-- ----------------------------------------
-- tl_id (#)
-- tl_descripcion (telefono, computadora)

-- ----------------------------------------
-- Linea_samblaje
-- ----------------------------------------
-- Lin_id (#)
-- Lin_//varios puestos de trabajo
-- Lin_pro_id (foranea)
-- Lin_tl_id (foranea)


-- ----------------------------------------
-- Empleados
-- ----------------------------------------
-- id
-- codigo
-- nombre
-- direccion
-- telefono
-- correo
-- pues_id (operario, jefe)

-- ----------------------------------------
-- puesto_trabajo
-- ----------------------------------------
-- id (#)
-- descripcion
-- lin_id (foranea)


-- ----------------------------------------
-- Empleado_puesto_trabajo
-- ----------------------------------------
-- id (#)
-- fecha_inicio
-- fecha_fin
-- emp_id (foranea)
-- puesto_id (foranea)


## Modelo Logico

![modelo logico](image.png)

## Modelo Relacional 

![modelo relacional](Relational_1.png)