-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2024-06-13 12:44:18 CST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE bodega (
    bod_id                NUMBER NOT NULL,
    bod_encargado         VARCHAR2(50) NOT NULL,
    bod_direccion         VARCHAR2(50) NOT NULL,
    bod_tipo_bodega       VARCHAR2(50) NOT NULL,
    bod_inventario_actual NUMBER NOT NULL
);

ALTER TABLE bodega ADD CONSTRAINT bodega_pk PRIMARY KEY ( bod_id );

CREATE TABLE cliente (
    cli_id        NUMBER NOT NULL,
    cli_nombre    VARCHAR2(50) NOT NULL,
    cli_direccion VARCHAR2(50) NOT NULL,
    cli_pais      VARCHAR2(50) NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( cli_id );

CREATE TABLE detalle_pedido (
    det_id              NUMBER NOT NULL,
    det_cantidad        NUMBER NOT NULL,
    det_precio_unitario NUMBER NOT NULL,
    pedido_ped_id       NUMBER NOT NULL,
    producto_pro_id     NUMBER NOT NULL,
    producto_bod_id     NUMBER NOT NULL,
    pedido_cli_id       NUMBER NOT NULL
);

ALTER TABLE detalle_pedido
    ADD CONSTRAINT detalle_pedido_pk PRIMARY KEY ( det_id,
                                                   pedido_ped_id,
                                                   pedido_cli_id,
                                                   producto_pro_id,
                                                   producto_bod_id );

CREATE TABLE empleado (
    emp_id           NUMBER NOT NULL,
    emp_nombre       VARCHAR2(50) NOT NULL,
    emp_direccion    VARCHAR2(50),
    emp_telefono     NUMBER NOT NULL,
    emp_correo       VARCHAR2(50) NOT NULL,
    emp_tipo         VARCHAR2(50) NOT NULL,
    emp_salario_hora NUMBER NOT NULL,
    emp_hora_entra   DATE NOT NULL
);

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( emp_id );

CREATE TABLE etapa (
    eta_id                 NUMBER NOT NULL,
    eta_nombre             VARCHAR2(50) NOT NULL,
    eta_estado             VARCHAR2(50) NOT NULL,
    eta_costo_funciona     NUMBER NOT NULL,
    producto_pro_id        NUMBER NOT NULL,
    producto_bodega_bod_id NUMBER NOT NULL,
    parte_par_id           NUMBER NOT NULL,
    parte_bodega_bod_id    NUMBER NOT NULL,
    parte_pro_id           NUMBER NOT NULL
);

ALTER TABLE etapa
    ADD CONSTRAINT etapa_pk PRIMARY KEY ( eta_id,
                                          producto_pro_id,
                                          producto_bodega_bod_id,
                                          parte_par_id,
                                          parte_bodega_bod_id,
                                          parte_pro_id );

CREATE TABLE factura (
    fac_id           NUMBER NOT NULL,
    fac_fecha        DATE NOT NULL,
    fac_monto_total  NUMBER NOT NULL,
    fac_estado_pago  VARCHAR2(50) NOT NULL,
    proveedor_pro_id NUMBER NOT NULL
);

ALTER TABLE factura ADD CONSTRAINT factura_pk PRIMARY KEY ( fac_id,
                                                            proveedor_pro_id );

CREATE TABLE linea_ensamblaje (
    lin_id                 NUMBER NOT NULL,
    lin_tipo               VARCHAR2(50) NOT NULL,
    producto_pro_id        NUMBER NOT NULL,
    producto_bodega_bod_id NUMBER NOT NULL
);

ALTER TABLE linea_ensamblaje
    ADD CONSTRAINT linea_ensamblaje_pk PRIMARY KEY ( lin_id,
                                                     producto_pro_id,
                                                     producto_bodega_bod_id );

CREATE TABLE parte (
    par_id           NUMBER NOT NULL,
    par_codigo       NUMBER NOT NULL,
    par_nombre       VARCHAR2(50) NOT NULL,
    par_color        VARCHAR2(50) NOT NULL,
    par_tipo         VARCHAR2(50) NOT NULL,
    par_garantia     NUMBER NOT NULL,
    par_costo        NUMBER NOT NULL,
    bodega_bod_id    NUMBER NOT NULL,
    proveedor_pro_id NUMBER NOT NULL
);

ALTER TABLE parte
    ADD CONSTRAINT parte_pk PRIMARY KEY ( par_id,
                                          bodega_bod_id,
                                          proveedor_pro_id );

CREATE TABLE parte_factura (
    pf_id                    NUMBER NOT NULL,
    pf_cantidad              NUMBER NOT NULL,
    pf_precio_unitario       NUMBER NOT NULL,
    parte_par_id             NUMBER NOT NULL,
    parte_bodega_bod_id      NUMBER NOT NULL,
    parte_pro_id             NUMBER NOT NULL,
    factura_fac_id           NUMBER NOT NULL,
    factura_proveedor_pro_id NUMBER NOT NULL
);

ALTER TABLE parte_factura
    ADD CONSTRAINT parte_factura_pk PRIMARY KEY ( pf_id,
                                                  parte_par_id,
                                                  parte_bodega_bod_id,
                                                  parte_pro_id,
                                                  factura_fac_id,
                                                  factura_proveedor_pro_id );

CREATE TABLE pedido (
    ped_id              NUMBER NOT NULL,
    ped_fecha           DATE NOT NULL,
    ped_fecha_entrega   DATE NOT NULL,
    ped_pago_adelantado NUMBER NOT NULL,
    ped_estado          VARCHAR2(50) NOT NULL,
    cliente_cli_id      NUMBER NOT NULL
);

ALTER TABLE pedido ADD CONSTRAINT pedido_pk PRIMARY KEY ( ped_id,
                                                          cliente_cli_id );

CREATE TABLE producto (
    pro_id                 NUMBER NOT NULL,
    pro_nombre             VARCHAR2(50) NOT NULL,
    pro_marca              VARCHAR2(50) NOT NULL,
    pro_fecha_finaliza     DATE NOT NULL,
    pro_costo_fabricacion  NUMBER NOT NULL,
    pro_costo_verificacion NUMBER NOT NULL,
    pro_costo_total        NUMBER NOT NULL,
    bodega_bod_id          NUMBER NOT NULL
);

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( pro_id,
                                                              bodega_bod_id );

CREATE TABLE proveedor (
    pro_id       NUMBER NOT NULL,
    pro_nombre   VARCHAR2(50) NOT NULL,
    pro_telefono NUMBER NOT NULL,
    pro_compania VARCHAR2(50) NOT NULL,
    pro_pais     VARCHAR2(50) NOT NULL
);

ALTER TABLE proveedor ADD CONSTRAINT proveedor_pk PRIMARY KEY ( pro_id );

CREATE TABLE puesto (
    pue_id                  NUMBER NOT NULL,
    pue_nombre              VARCHAR2(50) NOT NULL,
    pue_descripcion         VARCHAR2(50) NOT NULL,
    linea_ensamblaje_lin_id NUMBER NOT NULL,
    empleado_emp_id         NUMBER NOT NULL,
    linea_ensamblaje_pro_id NUMBER NOT NULL,
    linea_ensamblaje_bod_id NUMBER NOT NULL,
    puesto_id               NUMBER NOT NULL
);

ALTER TABLE puesto ADD CONSTRAINT puesto_pk PRIMARY KEY ( puesto_id );

--  ERROR: UK name length exceeds maximum allowed length(30) 
ALTER TABLE puesto
    ADD CONSTRAINT puesto_pue_id_lin_id_pro_id_bod_id_emp_id_un UNIQUE ( pue_id,
                                                                         linea_ensamblaje_lin_id,
                                                                         linea_ensamblaje_pro_id,
                                                                         linea_ensamblaje_bod_id,
                                                                         empleado_emp_id );

CREATE TABLE soporte_tecnico (
    tec_id              NUMBER NOT NULL,
    tec_fecha_recepcion DATE NOT NULL,
    tec_descripcion     VARCHAR2(50) NOT NULL,
    tec_solucion        VARCHAR2(50) NOT NULL,
    tec_reembolso       NUMBER NOT NULL,
    cliente_cli_id      NUMBER NOT NULL,
    producto_pro_id     NUMBER NOT NULL,
    producto_bod_id     NUMBER NOT NULL
);

ALTER TABLE soporte_tecnico
    ADD CONSTRAINT soporte_tecnico_pk PRIMARY KEY ( tec_id,
                                                    cliente_cli_id,
                                                    producto_pro_id,
                                                    producto_bod_id );

ALTER TABLE detalle_pedido
    ADD CONSTRAINT detalle_pedido_pedido_fk FOREIGN KEY ( pedido_ped_id,
                                                          pedido_cli_id )
        REFERENCES pedido ( ped_id,
                            cliente_cli_id );

ALTER TABLE detalle_pedido
    ADD CONSTRAINT detalle_pedido_producto_fk FOREIGN KEY ( producto_pro_id,
                                                            producto_bod_id )
        REFERENCES producto ( pro_id,
                              bodega_bod_id );

ALTER TABLE etapa
    ADD CONSTRAINT etapa_parte_fk FOREIGN KEY ( parte_par_id,
                                                parte_bodega_bod_id,
                                                parte_pro_id )
        REFERENCES parte ( par_id,
                           bodega_bod_id,
                           proveedor_pro_id );

ALTER TABLE etapa
    ADD CONSTRAINT etapa_producto_fk FOREIGN KEY ( producto_pro_id,
                                                   producto_bodega_bod_id )
        REFERENCES producto ( pro_id,
                              bodega_bod_id );

ALTER TABLE factura
    ADD CONSTRAINT factura_proveedor_fk FOREIGN KEY ( proveedor_pro_id )
        REFERENCES proveedor ( pro_id );

ALTER TABLE linea_ensamblaje
    ADD CONSTRAINT linea_ensamblaje_producto_fk FOREIGN KEY ( producto_pro_id,
                                                              producto_bodega_bod_id )
        REFERENCES producto ( pro_id,
                              bodega_bod_id );

ALTER TABLE parte
    ADD CONSTRAINT parte_bodega_fk FOREIGN KEY ( bodega_bod_id )
        REFERENCES bodega ( bod_id );

ALTER TABLE parte_factura
    ADD CONSTRAINT parte_factura_factura_fk FOREIGN KEY ( factura_fac_id,
                                                          factura_proveedor_pro_id )
        REFERENCES factura ( fac_id,
                             proveedor_pro_id );

ALTER TABLE parte_factura
    ADD CONSTRAINT parte_factura_parte_fk FOREIGN KEY ( parte_par_id,
                                                        parte_bodega_bod_id,
                                                        parte_pro_id )
        REFERENCES parte ( par_id,
                           bodega_bod_id,
                           proveedor_pro_id );

ALTER TABLE parte
    ADD CONSTRAINT parte_proveedor_fk FOREIGN KEY ( proveedor_pro_id )
        REFERENCES proveedor ( pro_id );

ALTER TABLE pedido
    ADD CONSTRAINT pedido_cliente_fk FOREIGN KEY ( cliente_cli_id )
        REFERENCES cliente ( cli_id );

ALTER TABLE producto
    ADD CONSTRAINT producto_bodega_fk FOREIGN KEY ( bodega_bod_id )
        REFERENCES bodega ( bod_id );

ALTER TABLE puesto
    ADD CONSTRAINT puesto_empleado_fk FOREIGN KEY ( empleado_emp_id )
        REFERENCES empleado ( emp_id );

ALTER TABLE puesto
    ADD CONSTRAINT puesto_linea_ensamblaje_fk FOREIGN KEY ( linea_ensamblaje_lin_id,
                                                            linea_ensamblaje_pro_id,
                                                            linea_ensamblaje_bod_id )
        REFERENCES linea_ensamblaje ( lin_id,
                                      producto_pro_id,
                                      producto_bodega_bod_id );

ALTER TABLE soporte_tecnico
    ADD CONSTRAINT soporte_tecnico_cliente_fk FOREIGN KEY ( cliente_cli_id )
        REFERENCES cliente ( cli_id );

ALTER TABLE soporte_tecnico
    ADD CONSTRAINT soporte_tecnico_producto_fk FOREIGN KEY ( producto_pro_id,
                                                             producto_bod_id )
        REFERENCES producto ( pro_id,
                              bodega_bod_id );

CREATE SEQUENCE puesto_puesto_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER puesto_puesto_id_trg BEFORE
    INSERT ON puesto
    FOR EACH ROW
    WHEN ( new.puesto_id IS NULL )
BEGIN
    :new.puesto_id := puesto_puesto_id_seq.nextval;
END;
/



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            14
-- CREATE INDEX                             0
-- ALTER TABLE                             31
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           1
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
-- CREATE SEQUENCE                          1
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
