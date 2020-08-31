DROP TABLE IF EXISTS taxonomia_organismo;

DROP TABLE IF EXISTS prestamos;

DROP TABLE IF EXISTS municipio;

DROP TABLE IF EXISTS organismo;

DROP TABLE IF EXISTS resdes_sociales;

DROP TABLE IF EXISTS usuario;

DROP TABLE IF EXISTS departamento;

DROP TABLE IF EXISTS seccion;

DROP TABLE IF EXISTS ubicacion;

DROP TABLE IF EXISTS bases_registro;

DROP TABLE IF EXISTS etapas_vida;

DROP TABLE IF EXISTS conservacion_organismo;

DROP TABLE IF EXISTS configuracion;

DROP TABLE IF EXISTS bodega;

DROP TABLE IF EXISTS pais;

DROP TABLE IF EXISTS permisos_usuario;

DROP TABLE IF EXISTS personas;

DROP TABLE IF EXISTS tipo_rrss;

DROP TABLE IF EXISTS niveles_taxonomicos;

DROP TABLE IF EXISTS niveles_usuarios;

CREATE TABLE niveles_usuarios (
  codigo_nivel SERIAL  NOT NULL ,
  descripcion VARCHAR(50)      ,
PRIMARY KEY(codigo_nivel));




CREATE TABLE niveles_taxonomicos (
  codigo_nivel SERIAL  NOT NULL ,
  descripcion VARCHAR(50)    ,
  orden INT    ,
  activo BOOLEAN      ,
PRIMARY KEY(codigo_nivel));




CREATE TABLE tipo_rrss (
  codigo_red SERIAL  NOT NULL ,
  descripcion VARCHAR(50)    ,
  icono TEXT    ,
  activo BOOLEAN      ,
PRIMARY KEY(codigo_red));




CREATE TABLE personas (
  codigo_interno SERIAL  NOT NULL ,
  codigo_persona VARCHAR(10)    ,
  institucion VARCHAR(200)    ,
  nombre VARCHAR(75)    ,
  apellido VARCHAR(175)    ,
  correo VARCHAR(100)    ,
  telefono VARCHAR(15)    ,
  direccion VARCHAR(255)      ,
PRIMARY KEY(codigo_interno));




CREATE TABLE permisos_usuario (
  codigo_nivel INT   NOT NULL ,
  nombre_opcion SERIAL  NOT NULL ,
  permiso INTEGER      ,
PRIMARY KEY(codigo_nivel, nombre_opcion));




CREATE TABLE pais (
  codigo_pais SERIAL  NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BOOLEAN      ,
PRIMARY KEY(codigo_pais));



CREATE TABLE bodega (
  codigo_bodega SERIAL  NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BOOLEAN      ,
PRIMARY KEY(codigo_bodega));




CREATE TABLE configuracion (
  codigo_configuracion SERIAL  NOT NULL ,
  logo TEXT    ,
  imagen_portada TEXT    ,
  acerca_nosotros TEXT    ,
  dias_prestamo INT      ,
PRIMARY KEY(codigo_configuracion));




CREATE TABLE conservacion_organismo (
  codigo_conservacion SERIAL  NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BOOLEAN      ,
PRIMARY KEY(codigo_conservacion));




CREATE TABLE etapas_vida (
  codigo_etapa SERIAL  NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BOOLEAN      ,
PRIMARY KEY(codigo_etapa));




CREATE TABLE bases_registro (
  codigo_base SERIAL  NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BOOLEAN      ,
PRIMARY KEY(codigo_base));


CREATE TABLE ubicacion (
  codigo_ubicacion SERIAL  NOT NULL ,
  codigo_bodega INT   NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BOOLEAN      ,
PRIMARY KEY(codigo_ubicacion)  ,
  FOREIGN KEY(codigo_bodega)
    REFERENCES bodega(codigo_bodega));


CREATE INDEX ubicacion_FKcodigo_bodega ON ubicacion (codigo_bodega);


CREATE INDEX IFK_rbod_bicacion ON ubicacion (codigo_bodega);


CREATE TABLE seccion (
  codigo_seccion SERIAL  NOT NULL ,
  codigo_ubicacion INT   NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BOOLEAN      ,
PRIMARY KEY(codigo_seccion)  ,
  FOREIGN KEY(codigo_ubicacion)
    REFERENCES ubicacion(codigo_ubicacion));


CREATE INDEX seccion_FKcodigo_ubicacion ON seccion (codigo_ubicacion);


CREATE INDEX IFK_rub_seccion ON seccion (codigo_ubicacion);


CREATE TABLE departamento (
  codigo_departamento SERIAL  NOT NULL ,
  codigo_pais INT   NOT NULL ,
  deScripcion VARCHAR(50)    ,
  activo BOOLEAN      ,
PRIMARY KEY(codigo_departamento)  ,
  FOREIGN KEY(codigo_pais)
    REFERENCES pais(codigo_pais));



CREATE INDEX departamento_FKcodigo_pais ON departamento (codigo_pais);


CREATE INDEX IFK_rpai_departamento ON departamento (codigo_pais);


CREATE TABLE usuario (
  codigo_usuario SERIAL  NOT NULL ,
  nombre VARCHAR(50)    ,
  apellido VARCHAR(75)    ,
  usuario VARCHAR(50)    ,
  contrasenia VARCHAR(50)    ,
  correo VARCHAR(75)    ,
  permiso INT   NOT NULL ,
  activo BOOLEAN    ,
  memo TEXT    ,
  foto TEXT      ,
PRIMARY KEY(codigo_usuario)  ,
  FOREIGN KEY(permiso)
    REFERENCES niveles_usuarios(codigo_nivel));


CREATE INDEX usuario_FKIndex1 ON usuario (permiso);


CREATE INDEX IFK_rus_nusuarios ON usuario (permiso);


CREATE TABLE resdes_sociales (
  codigo_red SERIAL  NOT NULL ,
  tipo_red INT   NOT NULL ,
  codigo_configuracion INT   NOT NULL ,
  dato INTEGER    ,
  link VARCHAR(255)      ,
PRIMARY KEY(codigo_red)    ,
  FOREIGN KEY(codigo_configuracion)
    REFERENCES configuracion(codigo_configuracion),
  FOREIGN KEY(tipo_red)
    REFERENCES tipo_rrss(codigo_red));


CREATE INDEX resdes_sociales_FKcodigo_configuracion ON resdes_sociales (codigo_configuracion);
CREATE INDEX resdes_sociales_FKtipo_red ON resdes_sociales (tipo_red);


CREATE INDEX IFK_rred_configuracion ON resdes_sociales (codigo_configuracion);
CREATE INDEX IFK_rtip_rsocial ON resdes_sociales (tipo_red);


CREATE TABLE organismo (
  interno_organismo SERIAL  NOT NULL ,
  codigo_organismo VARCHAR(10)    ,
  colector VARCHAR(175)    ,
  codigo_departamento INT   NOT NULL ,
  codigo_pais INT   NOT NULL ,
  codigo_municipio INT    ,
  localidad VARCHAR(255)    ,
  latitud DECIMAL(18,7)    ,
  longitud DECIMAL(18,7)    ,
  altitud DECIMAL(18,7)    ,
  incertidubre_gps DECIMAL(18,7)    ,
  haBOOLEANat VARCHAR(100)    ,
  sexo CHAR(1)    ,
  etapa_vida INT   NOT NULL ,
  comentarios_colector TEXT    ,
  fecha_recoleccion DATE    ,
  tipo_conservacion INT   NOT NULL ,
  base_registro INT   NOT NULL ,
  codigo_bodega INT    ,
  codigo_ubicacion INT    ,
  codigo_seccion INT    ,
  informacion TEXT    ,
  publicado BOOLEAN    ,
  imagenes TEXT   NOT NULL   ,
PRIMARY KEY(interno_organismo)          ,
  FOREIGN KEY(tipo_conservacion)
    REFERENCES conservacion_organismo(codigo_conservacion),
  FOREIGN KEY(codigo_pais)
    REFERENCES pais(codigo_pais),
  FOREIGN KEY(codigo_departamento)
    REFERENCES departamento(codigo_departamento),
  FOREIGN KEY(etapa_vida)
    REFERENCES etapas_vida(codigo_etapa),
  FOREIGN KEY(base_registro)
    REFERENCES bases_registro(codigo_base));


CREATE INDEX especimen_FKtipo_conservacion ON organismo (tipo_conservacion);
CREATE INDEX organismo_FKcodigo_pais ON organismo (codigo_pais);
CREATE INDEX organismo_FKcodigo_departamento ON organismo (codigo_departamento);
CREATE INDEX organismo_FKetapa_vida ON organismo (etapa_vida);
CREATE INDEX organismo_FKbase_registro ON organismo (base_registro);



CREATE INDEX IFK_rorg_corganismo ON organismo (tipo_conservacion);
CREATE INDEX IFK_rorg_pais ON organismo (codigo_pais);
CREATE INDEX IFK_rorg_departamento ON organismo (codigo_departamento);
CREATE INDEX IFK_rorg_evida ON organismo (etapa_vida);
CREATE INDEX IFK_rorg_bregistro ON organismo (base_registro);


CREATE TABLE municipio (
  codigo_municipio SERIAL  NOT NULL ,
  codigo_departamento INT   NOT NULL ,
  decripcion VARCHAR(50)    ,
  activo BOOLEAN      ,
PRIMARY KEY(codigo_municipio)  ,
  FOREIGN KEY(codigo_departamento)
    REFERENCES departamento(codigo_departamento));


CREATE INDEX municipio_FKcodigo_departamento ON municipio (codigo_departamento);


CREATE INDEX IFK_rdep_municipio ON municipio (codigo_departamento);


CREATE TABLE prestamos (
  codigo_prestamo SERIAL  NOT NULL ,
  interno_organismo INT   NOT NULL ,
  interno_persona INT   NOT NULL ,
  fecha_prestamo DATE    ,
  fecha_retorno DATE    ,
  fecha_retornado DATE      ,
PRIMARY KEY(codigo_prestamo)    ,
  FOREIGN KEY(interno_persona)
    REFERENCES personas(codigo_interno),
  FOREIGN KEY(interno_organismo)
    REFERENCES organismo(interno_organismo));


CREATE INDEX prestamos_FKinterno_persona ON prestamos (interno_persona);
CREATE INDEX prestamos_FKinterno_organismo ON prestamos (interno_organismo);


CREATE INDEX IFK_rpre_personas ON prestamos (interno_persona);
CREATE INDEX IFK_rorg_prestamos ON prestamos (interno_organismo);


CREATE TABLE taxonomia_organismo (
  codigo_nivel INT   NOT NULL ,
  interno_organismo INT   NOT NULL     ,
  FOREIGN KEY(interno_organismo)
    REFERENCES organismo(interno_organismo),
  FOREIGN KEY(codigo_nivel)
    REFERENCES niveles_taxonomicos(codigo_nivel));


CREATE INDEX taxonomia_organismo_FKinterno_organismo ON taxonomia_organismo (interno_organismo);
CREATE INDEX taxonomia_organismo_FKcodigo_nivel ON taxonomia_organismo (codigo_nivel);


CREATE INDEX IFK_rorg_torganismo ON taxonomia_organismo (interno_organismo);
CREATE INDEX IFK_rniv_torganismo ON taxonomia_organismo (codigo_nivel);


-- CREANDO CONFIGURACION INICIAL

INSERT INTO niveles_taxonomicos(descripcion,orden,activo) VALUES('Reino',1,TRUE);
INSERT INTO niveles_taxonomicos(descripcion,orden,activo) VALUES('Filo',2,TRUE);
INSERT INTO niveles_taxonomicos(descripcion,orden,activo) VALUES('Clase',3,TRUE);
INSERT INTO niveles_taxonomicos(descripcion,orden,activo) VALUES('Orden',4,TRUE);
INSERT INTO niveles_taxonomicos(descripcion,orden,activo) VALUES('Familia',5,TRUE);


INSERT INTO pais(descripcion,activo) values('Guatemala',TRUE);

INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Guatemala',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Alta Verapaz',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Baja Verapaz',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Izabal',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Chiquimula',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Zacapa',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'El Progreso',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Jutiapa',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Jalapa',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Santa Rosa',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Chimaltenango',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Sacatepéquez',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Escuintla',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'San Marcos',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Quetzaltenango',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Totonicapán',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Sololá',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Retalhuleu',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Suchitepéquez',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Hueheutenango',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Quiché',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Petén',TRUE);

INSERT INTO bases_registro(descripcion,activo) VALUES ('Espécimen Preservado',TRUE);
INSERT INTO bases_registro(descripcion,activo) VALUES ('Observación por Máquina',TRUE);
INSERT INTO bases_registro(descripcion,activo) VALUES ('Observación Humana',TRUE);
INSERT INTO bases_registro(descripcion,activo) VALUES ('Espécimen Vivo',TRUE);
INSERT INTO bases_registro(descripcion,activo) VALUES ('Espécimen Fósil',TRUE);

INSERT INTO etapas_vida(descripcion,activo) VALUES ('Larva',TRUE);
INSERT INTO etapas_vida(descripcion,activo) VALUES ('Juvenil',TRUE);
INSERT INTO etapas_vida(descripcion,activo) VALUES ('Adulto',TRUE);
INSERT INTO etapas_vida(descripcion,activo) VALUES ('Otro',TRUE);
