-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2024-06-12 23:25:48 CST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE clientes (
    cli_id            NUMBER NOT NULL,
    cli_nombre        VARCHAR2(50) NOT NULL,
    cli_direccion     VARCHAR2(50) NOT NULL,
    cli_telefono      NUMBER NOT NULL,
    cli_telefono_casa NUMBER,
    cli_correo        VARCHAR2(50) NOT NULL,
    cli_dpi           NUMBER NOT NULL,
    cli_nit           NUMBER NOT NULL
);

ALTER TABLE clientes ADD CONSTRAINT clientes_pk PRIMARY KEY ( cli_id );

CREATE TABLE departamento (
    dep_id     NUMBER NOT NULL,
    dep_nombre VARCHAR2(50) NOT NULL
);

ALTER TABLE departamento ADD CONSTRAINT departamento_pk PRIMARY KEY ( dep_id );

CREATE TABLE empleado (
    emp_id             NUMBER NOT NULL,
    emp_nombre         VARCHAR2(50) NOT NULL,
    emp_dpi            NUMBER NOT NULL,
    emp_nit            NUMBER NOT NULL,
    emp_telefono       NUMBER NOT NULL,
    emp_sueldo_inicial NUMBER NOT NULL
);

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( emp_id );

CREATE TABLE empleado_suc (
    es_id                      NUMBER NOT NULL,
    es_fecha_inicio            DATE NOT NULL,
    es_fecha_fin               DATE,
    empleado_emp_id            NUMBER NOT NULL,
    sucursal_suc_id            NUMBER NOT NULL,
    sucursal_municipios_mun_id NUMBER NOT NULL,
    sucursal_municipios_dep_id NUMBER NOT NULL
);

ALTER TABLE empleado_suc
    ADD CONSTRAINT empleado_suc_pk PRIMARY KEY ( es_id,
                                                 empleado_emp_id,
                                                 sucursal_suc_id,
                                                 sucursal_municipios_mun_id,
                                                 sucursal_municipios_dep_id );

CREATE TABLE inventario (
    inv_id                     NUMBER NOT NULL,
    inv_vehiculos_venta        NUMBER NOT NULL,
    inv_vehiculos_vendidos     NUMBER NOT NULL,
    sucursal_suc_id            NUMBER NOT NULL,
    sucursal_municipios_mun_id NUMBER NOT NULL,
    sucursal_municipios_dep_id NUMBER NOT NULL
);

CREATE UNIQUE INDEX inventario__idx ON
    inventario (
        sucursal_suc_id
    ASC,
        sucursal_municipios_mun_id
    ASC,
        sucursal_municipios_dep_id
    ASC );

ALTER TABLE inventario
    ADD CONSTRAINT inventario_pk PRIMARY KEY ( inv_id,
                                               sucursal_suc_id,
                                               sucursal_municipios_mun_id,
                                               sucursal_municipios_dep_id );

CREATE TABLE municipios (
    mun_id              NUMBER NOT NULL,
    mun_nombre          VARCHAR2(50) NOT NULL,
    departamento_dep_id NUMBER NOT NULL
);

ALTER TABLE municipios ADD CONSTRAINT municipios_pk PRIMARY KEY ( mun_id,
                                                                  departamento_dep_id );

CREATE TABLE proveedores (
    pro_id             NUMBER NOT NULL,
    pro_nombre         VARCHAR2(50) NOT NULL,
    pro_direccion      VARCHAR2(50) NOT NULL,
    pro_telefono       NUMBER NOT NULL,
    pro_correo         VARCHAR2(50) NOT NULL,
    pro_nombre_empresa VARCHAR2(50) NOT NULL
);

ALTER TABLE proveedores ADD CONSTRAINT proveedores_pk PRIMARY KEY ( pro_id );

CREATE TABLE sucursal (
    suc_id            NUMBER NOT NULL,
    suc_nombre        VARCHAR2(50) NOT NULL,
    suc_direccion     VARCHAR2(50) NOT NULL,
    suc_telefono      NUMBER NOT NULL,
    suc_sitio_web     VARCHAR2(50) NOT NULL,
    municipios_mun_id NUMBER NOT NULL,
    municipios_dep_id NUMBER NOT NULL
);

ALTER TABLE sucursal
    ADD CONSTRAINT sucursal_pk PRIMARY KEY ( suc_id,
                                             municipios_mun_id,
                                             municipios_dep_id );

CREATE TABLE tarjetas_credito (
    tar_id                NUMBER NOT NULL,
    tar_no_tarjeta        NUMBER NOT NULL,
    tar_banco             VARCHAR2(50) NOT NULL,
    tar_fecha_vencimiento DATE NOT NULL,
    clientes_cli_id       NUMBER NOT NULL
);

ALTER TABLE tarjetas_credito ADD CONSTRAINT tarjetas_credito_pk PRIMARY KEY ( tar_id,
                                                                              clientes_cli_id );

CREATE TABLE transacciones (
    tra_id                      NUMBER NOT NULL,
    tra_tipo_transaccion        VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    tra_tipo_pago               VARCHAR2(50) NOT NULL,
    tra_fecha                   DATE NOT NULL,
    tra_monto                   NUMBER NOT NULL,
    tra_nombre_banc             VARCHAR2(50),
    tra_no_tarjeta              NUMBER,
    tra_descuento               NUMBER,
    tra_motivo_desc             VARCHAR2(50),
    tra_hora_venta              DATE,
    sucursal_suc_id             NUMBER NOT NULL,
    empleado_emp_id             NUMBER NOT NULL,
    vehiculo_veh_id             NUMBER NOT NULL,
    vehiculo_proveedores_pro_id NUMBER NOT NULL,
    sucursal_municipios_mun_id  NUMBER NOT NULL,
    sucursal_municipios_dep_id  NUMBER NOT NULL
);

ALTER TABLE transacciones
    ADD CONSTRAINT transacciones_pk PRIMARY KEY ( tra_id,
                                                  sucursal_suc_id,
                                                  sucursal_municipios_mun_id,
                                                  sucursal_municipios_dep_id,
                                                  empleado_emp_id,
                                                  vehiculo_veh_id,
                                                  vehiculo_proveedores_pro_id );

CREATE TABLE vehiculo (
    veh_id             NUMBER NOT NULL,
    veh_placa          VARCHAR2(50) NOT NULL,
    veh_color          VARCHAR2(50) NOT NULL,
    veh_marca          VARCHAR2(50) NOT NULL,
    veh_modelo         VARCHAR2(50) NOT NULL,
    veh_kilometraje    NUMBER NOT NULL,
    veh_anio           NUMBER NOT NULL,
    veh_transmision    VARCHAR2(50) NOT NULL,
    veh_puertas        NUMBER NOT NULL,
    veh_condicion      VARCHAR2(50) NOT NULL,
    proveedores_pro_id NUMBER NOT NULL
);

CREATE UNIQUE INDEX vehiculo__idx ON
    vehiculo (
        proveedores_pro_id
    ASC );

ALTER TABLE vehiculo ADD CONSTRAINT vehiculo_pk PRIMARY KEY ( veh_id,
                                                              proveedores_pro_id );

ALTER TABLE empleado_suc
    ADD CONSTRAINT empleado_suc_empleado_fk FOREIGN KEY ( empleado_emp_id )
        REFERENCES empleado ( emp_id );

ALTER TABLE empleado_suc
    ADD CONSTRAINT empleado_suc_sucursal_fk FOREIGN KEY ( sucursal_suc_id,
                                                          sucursal_municipios_mun_id,
                                                          sucursal_municipios_dep_id )
        REFERENCES sucursal ( suc_id,
                              municipios_mun_id,
                              municipios_dep_id );

ALTER TABLE inventario
    ADD CONSTRAINT inventario_sucursal_fk FOREIGN KEY ( sucursal_suc_id,
                                                        sucursal_municipios_mun_id,
                                                        sucursal_municipios_dep_id )
        REFERENCES sucursal ( suc_id,
                              municipios_mun_id,
                              municipios_dep_id );

ALTER TABLE municipios
    ADD CONSTRAINT municipios_departamento_fk FOREIGN KEY ( departamento_dep_id )
        REFERENCES departamento ( dep_id );

ALTER TABLE sucursal
    ADD CONSTRAINT sucursal_municipios_fk FOREIGN KEY ( municipios_mun_id,
                                                        municipios_dep_id )
        REFERENCES municipios ( mun_id,
                                departamento_dep_id );

ALTER TABLE tarjetas_credito
    ADD CONSTRAINT tarjetas_credito_clientes_fk FOREIGN KEY ( clientes_cli_id )
        REFERENCES clientes ( cli_id );

ALTER TABLE transacciones
    ADD CONSTRAINT transacciones_empleado_fk FOREIGN KEY ( empleado_emp_id )
        REFERENCES empleado ( emp_id );

ALTER TABLE transacciones
    ADD CONSTRAINT transacciones_sucursal_fk FOREIGN KEY ( sucursal_suc_id,
                                                           sucursal_municipios_mun_id,
                                                           sucursal_municipios_dep_id )
        REFERENCES sucursal ( suc_id,
                              municipios_mun_id,
                              municipios_dep_id );

ALTER TABLE transacciones
    ADD CONSTRAINT transacciones_vehiculo_fk FOREIGN KEY ( vehiculo_veh_id,
                                                           vehiculo_proveedores_pro_id )
        REFERENCES vehiculo ( veh_id,
                              proveedores_pro_id );

ALTER TABLE vehiculo
    ADD CONSTRAINT vehiculo_proveedores_fk FOREIGN KEY ( proveedores_pro_id )
        REFERENCES proveedores ( pro_id );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             2
-- ALTER TABLE                             21
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   1
-- WARNINGS                                 0
