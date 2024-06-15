-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2024-06-16 01:14:32 CEST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE area (
    are_id     NUMBER NOT NULL,
    are_nombre VARCHAR2(50) NOT NULL
);

ALTER TABLE area ADD CONSTRAINT area_pk PRIMARY KEY ( are_id );

CREATE TABLE cliente (
    cli_cui              NUMBER NOT NULL,
    cli_nombre           VARCHAR2(50) NOT NULL,
    cli_fecha_nacimiento DATE NOT NULL,
    cli_telefono         NUMBER NOT NULL,
    cli_direccion        VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    cli_edad             NUMBER NOT NULL,
    cli_correo           VARCHAR2(50) NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( cli_cui );

CREATE TABLE departamento (
    dep_id      NUMBER NOT NULL,
    dep_nombre  VARCHAR2(50) NOT NULL,
    area_are_id NUMBER NOT NULL
);

ALTER TABLE departamento ADD CONSTRAINT departamento_pk PRIMARY KEY ( dep_id,
                                                                      area_are_id );

CREATE TABLE funcion (
    fun_id                   NUMBER NOT NULL,
    fun_nombre               VARCHAR2(50) NOT NULL,
    departamento_dep_id      NUMBER NOT NULL,
    departamento_area_are_id NUMBER NOT NULL
);

ALTER TABLE funcion
    ADD CONSTRAINT funcion_pk PRIMARY KEY ( fun_id,
                                            departamento_dep_id,
                                            departamento_area_are_id );

CREATE TABLE llamada (
    lla_id                 NUMBER NOT NULL,
    lla_cliente_nombre     VARCHAR2(50) NOT NULL,
    lla_telefono_cliente   NUMBER NOT NULL,
    lla_fecha              DATE NOT NULL,
    lla_hora               DATE NOT NULL,
    lla_duracion           NUMBER NOT NULL,
    personal_per_id        NUMBER NOT NULL,
    personal_dep_id        NUMBER NOT NULL,
    personal_are_id        NUMBER NOT NULL,
    personal_poliza_pol_id NUMBER NOT NULL
);

CREATE UNIQUE INDEX llamada__idx ON
    llamada (
        personal_per_id
    ASC,
        personal_dep_id
    ASC,
        personal_are_id
    ASC,
        personal_poliza_pol_id
    ASC );

ALTER TABLE llamada
    ADD CONSTRAINT llamada_pk PRIMARY KEY ( lla_id,
                                            personal_per_id,
                                            personal_dep_id,
                                            personal_are_id,
                                            personal_poliza_pol_id );

CREATE TABLE pago (
    pag_id                 NUMBER NOT NULL,
    pag_tarifa             NUMBER NOT NULL,
    pag_mora               NUMBER NOT NULL,
    pag_monto_pago         NUMBER NOT NULL,
    pag_forma_pago         VARCHAR2(50) NOT NULL,
    pag_fecha_pago         DATE NOT NULL,
    poliza_pol_id          NUMBER NOT NULL,
    personal_per_id        NUMBER NOT NULL,
    personal_dep_id        NUMBER NOT NULL,
    personal_are_id        NUMBER NOT NULL,
    personal_poliza_pol_id NUMBER NOT NULL
);

ALTER TABLE pago
    ADD CONSTRAINT pago_pk PRIMARY KEY ( pag_id,
                                         poliza_pol_id,
                                         personal_per_id,
                                         personal_dep_id,
                                         personal_are_id,
                                         personal_poliza_pol_id );

CREATE TABLE personal (
    per_id                   NUMBER NOT NULL,
    per_nombre               VARCHAR2(100) NOT NULL,
    per_dpi                  NUMBER NOT NULL,
    per_fecha_nacimiento     DATE NOT NULL,
    per_fecha_ingreso        DATE NOT NULL,
    per_edad                 NUMBER NOT NULL,
    per_telefono             NUMBER NOT NULL,
    per_direccion            VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    per_salario              NUMBER NOT NULL,
    per_puesto               VARCHAR2(50) NOT NULL,
    per_departamento         VARCHAR2(50) NOT NULL,
    departamento_dep_id      NUMBER NOT NULL,
    departamento_area_are_id NUMBER NOT NULL,
    poliza_pol_id            NUMBER NOT NULL
);

CREATE UNIQUE INDEX personal__idx ON
    personal (
        poliza_pol_id
    ASC );

ALTER TABLE personal
    ADD CONSTRAINT personal_pk PRIMARY KEY ( per_id,
                                             departamento_dep_id,
                                             departamento_area_are_id,
                                             poliza_pol_id );

CREATE TABLE poliza (
    pol_id           NUMBER NOT NULL,
    pol_fecha_inicio DATE NOT NULL,
    pol_fecha_final  DATE NOT NULL,
    pol_monto        NUMBER NOT NULL,
    pol_periodicidad NUMBER NOT NULL
);

ALTER TABLE poliza ADD CONSTRAINT poliza_pk PRIMARY KEY ( pol_id );

CREATE TABLE relation_19 (
    poliza_pol_id   NUMBER NOT NULL,
    cliente_cli_cui NUMBER NOT NULL
);

ALTER TABLE relation_19 ADD CONSTRAINT relation_19_pk PRIMARY KEY ( poliza_pol_id,
                                                                    cliente_cli_cui );

CREATE TABLE seguro (
    seg_id                         NUMBER NOT NULL,
    seg_tipo                       VARCHAR2(50) NOT NULL,
    seg_descripcion                VARCHAR2(50) NOT NULL,
    poliza_pol_id                  NUMBER NOT NULL,
    llamada_lla_id                 NUMBER NOT NULL,
    llamada_personal_per_id        NUMBER NOT NULL,
    llamada_personal_dep_id        NUMBER NOT NULL,
    llamada_personal_are_id        NUMBER NOT NULL,
    llamada_personal_poliza_pol_id NUMBER NOT NULL
);

CREATE UNIQUE INDEX seguro__idx ON
    seguro (
        llamada_lla_id
    ASC,
        llamada_personal_per_id
    ASC,
        llamada_personal_dep_id
    ASC,
        llamada_personal_are_id
    ASC,
        llamada_personal_poliza_pol_id
    ASC );

CREATE UNIQUE INDEX seguro__idxv1 ON
    seguro (
        poliza_pol_id
    ASC );

ALTER TABLE seguro
    ADD CONSTRAINT seguro_pk PRIMARY KEY ( seg_id,
                                           poliza_pol_id,
                                           llamada_lla_id,
                                           llamada_personal_per_id,
                                           llamada_personal_dep_id,
                                           llamada_personal_are_id,
                                           llamada_personal_poliza_pol_id );

ALTER TABLE departamento
    ADD CONSTRAINT departamento_area_fk FOREIGN KEY ( area_are_id )
        REFERENCES area ( are_id );

ALTER TABLE funcion
    ADD CONSTRAINT funcion_departamento_fk FOREIGN KEY ( departamento_dep_id,
                                                         departamento_area_are_id )
        REFERENCES departamento ( dep_id,
                                  area_are_id );

ALTER TABLE llamada
    ADD CONSTRAINT llamada_personal_fk FOREIGN KEY ( personal_per_id,
                                                     personal_dep_id,
                                                     personal_are_id,
                                                     personal_poliza_pol_id )
        REFERENCES personal ( per_id,
                              departamento_dep_id,
                              departamento_area_are_id,
                              poliza_pol_id );

ALTER TABLE pago
    ADD CONSTRAINT pago_personal_fk FOREIGN KEY ( personal_per_id,
                                                  personal_dep_id,
                                                  personal_are_id,
                                                  personal_poliza_pol_id )
        REFERENCES personal ( per_id,
                              departamento_dep_id,
                              departamento_area_are_id,
                              poliza_pol_id );

ALTER TABLE pago
    ADD CONSTRAINT pago_poliza_fk FOREIGN KEY ( poliza_pol_id )
        REFERENCES poliza ( pol_id );

ALTER TABLE personal
    ADD CONSTRAINT personal_departamento_fk FOREIGN KEY ( departamento_dep_id,
                                                          departamento_area_are_id )
        REFERENCES departamento ( dep_id,
                                  area_are_id );

ALTER TABLE personal
    ADD CONSTRAINT personal_poliza_fk FOREIGN KEY ( poliza_pol_id )
        REFERENCES poliza ( pol_id );

ALTER TABLE relation_19
    ADD CONSTRAINT relation_19_cliente_fk FOREIGN KEY ( cliente_cli_cui )
        REFERENCES cliente ( cli_cui );

ALTER TABLE relation_19
    ADD CONSTRAINT relation_19_poliza_fk FOREIGN KEY ( poliza_pol_id )
        REFERENCES poliza ( pol_id );

ALTER TABLE seguro
    ADD CONSTRAINT seguro_llamada_fk FOREIGN KEY ( llamada_lla_id,
                                                   llamada_personal_per_id,
                                                   llamada_personal_dep_id,
                                                   llamada_personal_are_id,
                                                   llamada_personal_poliza_pol_id )
        REFERENCES llamada ( lla_id,
                             personal_per_id,
                             personal_dep_id,
                             personal_are_id,
                             personal_poliza_pol_id );

ALTER TABLE seguro
    ADD CONSTRAINT seguro_poliza_fk FOREIGN KEY ( poliza_pol_id )
        REFERENCES poliza ( pol_id );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            10
-- CREATE INDEX                             4
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
-- ERRORS                                   2
-- WARNINGS                                 0
