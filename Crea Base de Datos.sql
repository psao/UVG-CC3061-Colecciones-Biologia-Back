DROP TABLE IF EXISTS prestamo_organismos;

DROP TABLE IF EXISTS autorizacion_organismo;

DROP TABLE IF EXISTS taxonomia_organismo;

DROP TABLE IF EXISTS organismo;

DROP TABLE IF EXISTS autorizacion_prestamo;

DROP TABLE IF EXISTS municipio;

DROP TABLE IF EXISTS departamento;

DROP TABLE IF EXISTS prestamos;

DROP TABLE IF EXISTS seccion;

DROP TABLE IF EXISTS ubicacion;

DROP TABLE IF EXISTS bodega;

DROP TABLE IF EXISTS autorizadores;

DROP TABLE IF EXISTS bases_registro;

DROP TABLE IF EXISTS conservacion_organismo;

DROP TABLE IF EXISTS niveles_taxonomicos;

DROP TABLE IF EXISTS pais;

DROP TABLE IF EXISTS personas;

DROP TABLE IF EXISTS correlativos;

DROP TABLE IF EXISTS etapas_vida;

CREATE TABLE etapas_vida (
  codigo_etapa SERIAL  NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BIT      ,
PRIMARY KEY(codigo_etapa));




CREATE TABLE correlativos (
  codigo_opcion VARCHAR(45)   NOT NULL ,
  nombre_opcion VARCHAR(50)    ,
  prefijo CHAR(3)      ,
PRIMARY KEY(codigo_opcion));




CREATE TABLE personas (
  codigo_interno SERIAL  NOT NULL ,
  codigo_persona VARCHAR(20)    ,
  institucion VARCHAR(200)    ,
  nombre VARCHAR(75)    ,
  apellido VARCHAR(175)    ,
  correo VARCHAR(100)    ,
  telefono VARCHAR(15)    ,
  direccion VARCHAR(255)      ,
PRIMARY KEY(codigo_interno));




CREATE TABLE pais (
  codigo_pais SERIAL  NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BIT      ,
PRIMARY KEY(codigo_pais));




CREATE TABLE niveles_taxonomicos (
  codigo_nivel SERIAL  NOT NULL ,
  descripcion VARCHAR(50)    ,
  orden INT    ,
  activo BIT      ,
PRIMARY KEY(codigo_nivel));




CREATE TABLE conservacion_organismo (
  codigo_conservacion SERIAL  NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BIT      ,
PRIMARY KEY(codigo_conservacion));




CREATE TABLE bases_registro (
  codigo_base SERIAL  NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BIT      ,
PRIMARY KEY(codigo_base));




CREATE TABLE autorizadores (
  codigo_autorizador SERIAL  NOT NULL ,
  codigo_usuario INT    ,
  prestamos BIT    ,
  organismos BIT    ,
  frecha_asignado TIMESTAMP  DEFAULT CURRENT_TIMESTAMP  ,
  activo BIT      ,
PRIMARY KEY(codigo_autorizador));




CREATE TABLE bodega (
  codigo_interno SERIAL  NOT NULL ,
  codigo_bodega VARCHAR(10)    ,
  descripcion VARCHAR(50)    ,
  activo BIT      ,
PRIMARY KEY(codigo_interno));




CREATE TABLE ubicacion (
  codigo_interno SERIAL  NOT NULL ,
  interno_bodega INT   NOT NULL ,
  codigo_ubicacion VARCHAR(10)    ,
  descripcion VARCHAR(50)    ,
  activo BIT      ,
PRIMARY KEY(codigo_interno)  ,
  FOREIGN KEY(interno_bodega)
    REFERENCES bodega(codigo_interno));


CREATE INDEX ubicacion_FKIndex1 ON ubicacion (interno_bodega);


CREATE INDEX IFK_rbod_bicacion ON ubicacion (interno_bodega);


CREATE TABLE seccion (
  codigo_interno SERIAL  NOT NULL ,
  interno_ubicacion INT   NOT NULL ,
  codigo_seccion VARCHAR(10)    ,
  descripcion VARCHAR(50)    ,
  activo BIT      ,
PRIMARY KEY(codigo_interno)  ,
  FOREIGN KEY(interno_ubicacion)
    REFERENCES ubicacion(codigo_interno));


CREATE INDEX seccion_FKIndex1 ON seccion (interno_ubicacion);


CREATE INDEX IFK_rub_seccion ON seccion (interno_ubicacion);


CREATE TABLE prestamos (
  codigo_prestamo SERIAL  NOT NULL ,
  interno_persona INT   NOT NULL ,
  fecha_prestamo DATE    ,
  fecha_retorno DATE    ,
  fecha_retornado DATE    ,
  autorizado BIT    ,
  usuario_ingreso INT      ,
PRIMARY KEY(codigo_prestamo)  ,
  FOREIGN KEY(interno_persona)
    REFERENCES personas(codigo_interno));


CREATE INDEX prestamos_FKinterno_persona ON prestamos (interno_persona);


CREATE INDEX IFK_rpre_personas ON prestamos (interno_persona);


CREATE TABLE departamento (
  codigo_departamento SERIAL  NOT NULL ,
  codigo_pais INT   NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BIT      ,
PRIMARY KEY(codigo_departamento)  ,
  FOREIGN KEY(codigo_pais)
    REFERENCES pais(codigo_pais));


CREATE INDEX departamento_FKcodigo_pais ON departamento (codigo_pais);


CREATE INDEX IFK_rpai_departamento ON departamento (codigo_pais);


CREATE TABLE municipio (
  codigo_municipio SERIAL  NOT NULL ,
  codigo_departamento INT   NOT NULL ,
  decripcion VARCHAR(50)    ,
  activo BIT      ,
PRIMARY KEY(codigo_municipio)  ,
  FOREIGN KEY(codigo_departamento)
    REFERENCES departamento(codigo_departamento));


CREATE INDEX municipio_FKcodigo_departamento ON municipio (codigo_departamento);


CREATE INDEX IFK_rdep_municipio ON municipio (codigo_departamento);


CREATE TABLE autorizacion_prestamo (
  codigo_autorizacion INT   NOT NULL ,
  codigo_autorizador INT   NOT NULL ,
  codigo_prestamo INT   NOT NULL ,
  fecha_autorizado TIMESTAMP  DEFAULT CURRENT_TIMESTAMP    ,
PRIMARY KEY(codigo_autorizacion)    ,
  FOREIGN KEY(codigo_prestamo)
    REFERENCES prestamos(codigo_prestamo),
  FOREIGN KEY(codigo_autorizador)
    REFERENCES autorizadores(codigo_autorizador));


CREATE INDEX autorizacion_prestamo_FKcodigo_prestamo ON autorizacion_prestamo (codigo_prestamo);
CREATE INDEX autorizacion_prestamo_FKcodigo_autorizador ON autorizacion_prestamo (codigo_autorizador);


CREATE INDEX IFK_rpr_auprestamos ON autorizacion_prestamo (codigo_prestamo);
CREATE INDEX IFK_rau_auprestamo ON autorizacion_prestamo (codigo_autorizador);


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
  habitat VARCHAR(100)    ,
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
  publicado BIT    ,
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


CREATE TABLE taxonomia_organismo (
  nivel_taxonomico INT   NOT NULL ,
  interno_organismo INT   NOT NULL ,
  descripcion VARCHAR(75)        ,
  FOREIGN KEY(interno_organismo)
    REFERENCES organismo(interno_organismo),
  FOREIGN KEY(nivel_taxonomico)
    REFERENCES niveles_taxonomicos(codigo_nivel));


CREATE INDEX taxonomia_organismo_FKinterno_organismo ON taxonomia_organismo (interno_organismo);
CREATE INDEX taxonomia_organismo_FKcodigo_nivel ON taxonomia_organismo (nivel_taxonomico);


CREATE INDEX IFK_rorg_torganismo ON taxonomia_organismo (interno_organismo);
CREATE INDEX IFK_rniv_torganismo ON taxonomia_organismo (nivel_taxonomico);


CREATE TABLE autorizacion_organismo (
  codigo_autorizacion SERIAL  NOT NULL ,
  codigo_autorizador INT   NOT NULL ,
  codigo_organismo INT   NOT NULL ,
  fecha_autorizado TIMESTAMP  DEFAULT CURRENT_TIMESTAMP    ,
PRIMARY KEY(codigo_autorizacion)    ,
  FOREIGN KEY(codigo_organismo)
    REFERENCES organismo(interno_organismo),
  FOREIGN KEY(codigo_autorizador)
    REFERENCES autorizadores(codigo_autorizador));


CREATE INDEX autorizacion_organismo_FKcodigo_organismo ON autorizacion_organismo (codigo_organismo);
CREATE INDEX autorizacion_organismo_FKcodigo_autorizador ON autorizacion_organismo (codigo_autorizador);


CREATE INDEX IFK_ror_autorizacion ON autorizacion_organismo (codigo_organismo);
CREATE INDEX IFK_rau_auorganismo ON autorizacion_organismo (codigo_autorizador);


CREATE TABLE prestamo_organismos (
  codigo_organismo INT   NOT NULL ,
  codigo_prestamo INT   NOT NULL     ,
  FOREIGN KEY(codigo_prestamo)
    REFERENCES prestamos(codigo_prestamo),
  FOREIGN KEY(codigo_organismo)
    REFERENCES organismo(interno_organismo));


CREATE INDEX prestamo_organismos_FKcodigo_prestamo ON prestamo_organismos (codigo_prestamo);
CREATE INDEX prestamo_organismos_FKcodigo_organismo ON prestamo_organismos (codigo_organismo);


CREATE INDEX IFK_rpr_prorganismos ON prestamo_organismos (codigo_prestamo);
CREATE INDEX IFK_rporg_organismo ON prestamo_organismos (codigo_organismo);













-- CREANDO CONFIGURACION INICIAL

INSERT INTO niveles_taxonomicos(descripcion,orden,activo) VALUES('Reino',1,b'1');
INSERT INTO niveles_taxonomicos(descripcion,orden,activo) VALUES('Filo',2,b'1');
INSERT INTO niveles_taxonomicos(descripcion,orden,activo) VALUES('Clase',3,b'1');
INSERT INTO niveles_taxonomicos(descripcion,orden,activo) VALUES('Orden',4,b'1');
INSERT INTO niveles_taxonomicos(descripcion,orden,activo) VALUES('Familia',5,b'1');

-- CREANDO PAISES

INSERT INTO pais(descripcion,activo) values('Guatemala',b'1');

-- CREANDO DEPARTAMENTOS

INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Guatemala',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Alta Verapaz',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Baja Verapaz',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Izabal',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Chiquimula',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Zacapa',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'El Progreso',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Jutiapa',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Jalapa',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Santa Rosa',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Chimaltenango',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Sacatepéquez',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Escuintla',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'San Marcos',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Quetzaltenango',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Totonicapán',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Sololá',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Retalhuleu',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Suchitepéquez',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Hueheutenango',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Quiché',b'1');
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Petén',b'1');

-- CREANDO MUNICIPIOS

INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(1, 1, 'Guatemala', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(2, 1, 'Santa Catarina Pinula', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(3, 1, 'San José Pinula', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(4, 1, 'San José del Golfo', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(5, 1, 'Palencia', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(6, 1, 'Chinautla', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(7, 1, 'San Pedro Ayampuc', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(8, 1, 'Mixco', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(9, 1, 'San Pedro Sacatepéquez', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(10, 1, 'San Juan Sacatepéquez', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(11, 1, 'Chuarrancho', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(12, 1, 'San Raymundo', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(13, 1, 'Fraijanes', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(14, 1, 'Amátitlán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(15, 1, 'Villa Nueva', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(16, 1, 'Villa Canales', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(17, 1, 'San Miguel Petapa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(18, 2, 'Cobán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(19, 2, 'Santa Cruz Verapaz', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(20, 2, 'San Cristóbal Verapaz', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(21, 2, 'Tactic', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(22, 2, 'Tamahú', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(23, 2, 'San Miguel Tucurú', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(24, 2, 'Panzóz', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(25, 2, 'Senahú', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(26, 2, 'San Pedro Carchá', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(27, 2, 'San Juan Chamelco', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(28, 2, 'San Agustín Lanquín', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(29, 2, 'Santa María Cahabón', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(30, 2, 'Chisec', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(31, 2, 'Chahal', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(32, 2, 'Fray Bartolomé de las Casas', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(33, 2, 'Santa Catalina La Tinta', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(34, 2, 'Raxruhá', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(35, 3, 'Salamá', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(36, 3, 'San Miguel Chicaj', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(37, 3, 'Rabinal', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(38, 3, 'Cubulco', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(39, 3, 'Granados', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(40, 3, 'Santa Cruz el Chol', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(41, 3, 'San Jerónimo', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(42, 3, 'Purulhá', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(43, 4, 'Morales', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(44, 4, 'Los Amates', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(45, 4, 'Livingston', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(46, 4, 'El Estor', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(47, 4, 'Puerto Barrios', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(48, 5, 'Chiquimula', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(49, 5, 'Jocotán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(50, 5, 'Esquipulas', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(51, 5, 'Comotán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(52, 5, 'Quezaltepeque', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(53, 5, 'Olopa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(54, 5, 'Ipala', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(55, 5, 'San Juan Hermita', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(56, 5, 'Concepción Las Minas', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(57, 5, 'San Jacinto', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(58, 5, 'San José la Arada', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(59, 6, 'Zacapa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(60, 6, 'Estanzuela', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(61, 6, 'Gualán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(62, 6, 'Huité', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(63, 6, 'La Unión', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(64, 6, 'Cabañas', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(65, 6, 'Río Hondo', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(66, 6, 'San Jorge', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(67, 6, 'San Diego', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(68, 6, 'Teculután', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(69, 6, 'Usumatlán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(70, 7, 'El Jícaro', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(71, 7, 'Morazán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(72, 7, 'San Agustín Acasaguastlán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(73, 7, 'San Antonio La Paz', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(74, 7, 'San Cristóbal Acasaguastlán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(75, 7, 'Sanarate', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(76, 7, 'Guastatoya', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(77, 7, 'Sansare', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(78, 8, 'Jutiapa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(79, 8, 'El Progreso Jutiapa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(80, 8, 'Santa Catarina Mita', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(81, 8, 'Yupiltepeque', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(82, 8, 'Atescatempa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(83, 8, 'Jerez', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(84, 8, 'El Adelanto', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(85, 8, 'Zopotitlán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(86, 8, 'Comapa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(87, 8, 'Jalpatagua', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(88, 8, 'Conguaco', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(89, 8, 'Moyuta', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(90, 8, 'Pasaco', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(91, 8, 'Quesada', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(92, 8, 'Agua Blanca', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(93, 8, 'Asunción Mita', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(94, 9, 'Jalapa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(95, 9, 'San Pedro Pinula', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(96, 9, 'San Luis Jilotepeque', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(97, 9, 'San Manuel Chaparrón', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(98, 9, 'San Carlos Alzatate', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(99, 9, 'Monjas', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(100, 9, 'Mataquescuintla', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(101, 10, 'Cuilapa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(102, 10, 'Casillas Santa Rosa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(103, 10, 'Chiquimulilla', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(104, 10, 'Guazacapán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(105, 10, 'Nueva Santa Rosa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(106, 10, 'Oratorio', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(107, 10, 'Pueblo Nuevo Viñas', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(108, 10, 'San Juan Tecuaco', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(109, 10, 'San Rafael Las Flores', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(110, 10, 'Santa Cruz Naranjo', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(111, 10, 'Santa María Ixhuatán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(112, 10, 'Santa Rosa de Lima', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(113, 10, 'Taxisco', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(114, 10, 'Barberena', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(115, 11, 'Chimaltenango', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(116, 11, 'San José Poaquil', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(117, 11, 'San Martín Jilotepeque', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(118, 11, 'San Juan Comalapa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(119, 11, 'Santa Aplolonia', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(120, 11, 'Tecpán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(121, 11, 'Patzún', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(122, 11, 'San Miguel Pochuta', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(123, 11, 'Patzicía', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(124, 11, 'Santa Cruz Balanyá', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(125, 11, 'Acatenango', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(126, 11, 'San Pedro Yepocapa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(127, 11, 'San Andrés Itzapa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(128, 11, 'Parramos', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(129, 11, 'Zaragoza', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(130, 11, 'El Tejar', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(131, 12, 'Antigua Guatemala', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(132, 12, 'San Juan Alotenango', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(133, 12, 'Ciudad Vieja', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(134, 12, 'Jocotenango', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(135, 12, 'Magdalena Milpas Altas', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(136, 12, 'Pastores', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(137, 12, 'San Antonio Aguas Calientes', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(138, 12, 'San Bartolomé Milpas Altas', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(139, 12, 'San Lucas Sacatepéquez', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(140, 12, 'San Miguel Dueñas', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(141, 12, 'Santa Catarina Barahona', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(142, 12, 'Santa Lucía Milpas Altas', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(143, 12, 'Santa María de Jesús', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(144, 12, 'Santiago Sacatepéquez', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(145, 12, 'Santiago Sacatepéquez', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(146, 12, 'Santo Domingo Xenacoj', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(147, 12, 'Supango', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(148, 13, 'Escuintla', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(149, 13, 'Santa Lucía Cotzumalguapa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(150, 13, 'La Democracia', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(151, 13, 'Siquinalá', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(152, 13, 'Masagua', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(153, 13, 'Tiquisate', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(154, 13, 'La Gomera', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(155, 13, 'Guaganazapa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(156, 13, 'San José', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(157, 13, 'Iztapa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(158, 13, 'Palín', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(159, 13, 'San Vicente Pacaya', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(160, 13, 'Nueva Concepción', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(161, 14, 'San Marcos', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(162, 14, 'Ayutla / Tecún Umán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(163, 14, 'Catalina', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(164, 14, 'Comitancillo', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(165, 14, 'Concepción Tutuapa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(166, 14, 'El Quetzal', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(167, 14, 'El Rodeo', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(168, 14, 'El Tumblador', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(169, 14, 'Ixchiguán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(170, 14, 'La Reforma', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(171, 14, 'Malacatán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(172, 14, 'Nuevo Progreso', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(173, 14, 'Ocós', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(174, 14, 'Pajapita', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(175, 14, 'Esquipulas Palo Gordo', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(176, 14, 'San Antonio Sacatepéquez', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(177, 14, 'San Cristóbal Cucho', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(178, 14, 'San José Ojetenam', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(179, 14, 'San Lorenzo', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(180, 14, 'San Miguel Ixtahuacán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(181, 14, 'San Pablo', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(182, 14, 'San Pedro Sacatepéquez', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(183, 14, 'San Rafael Pie de la Cuesta', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(184, 14, 'Sibinal', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(185, 14, 'Sipacapa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(186, 14, 'Tacaná', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(187, 14, 'Tajumulco', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(188, 14, 'Tejutla', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(189, 14, 'Río Blanco', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(190, 14, 'La Blanca', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(191, 15, 'Quetzaltenango', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(192, 15, 'Salcajá', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(193, 15, 'Olintepeque', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(194, 15, 'San Carlos Sija', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(195, 15, 'Sibilia', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(196, 15, 'Cabricán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(197, 15, 'Cajolá', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(198, 15, 'San Miguel Sigüilá', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(199, 15, 'San Juan Ostuncalco', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(200, 15, 'San Mateo', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(201, 15, 'Concepción Chiquirichapa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(202, 15, 'San Martín Sacatepéquez', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(203, 15, 'Almolonga', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(204, 15, 'Cantel', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(205, 15, 'Huitán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(206, 15, 'Zunil', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(207, 15, 'Colomba', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(208, 15, 'San Francisco La Unión', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(209, 15, 'El Palmar', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(210, 15, 'Coatepeque', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(211, 15, 'Génova', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(212, 15, 'Flores Costa Cuca', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(213, 15, 'La Esperanza', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(214, 15, 'Palestina de Los Altos', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(215, 16, 'Totonicapán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(216, 16, 'San Cristóbal Totonicapán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(217, 16, 'San Francisco El Alto', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(218, 16, 'San Andrés Xecul', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(219, 16, 'Momostenango', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(220, 16, 'Santa María Chiquimula', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(221, 16, 'Santa Lucía La Reforma', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(222, 16, 'San Bartolo', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(223, 17, 'Sololá', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(224, 17, 'Concepción', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(225, 17, 'Nahualá', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(226, 17, 'Panajachel', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(227, 17, 'San Andrés Semetabaj', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(228, 17, 'San Antonio Palopó', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(229, 17, 'San José Chacayá', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(230, 17, 'San Juan La Laguna', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(231, 17, 'San Lucas Tolimán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(232, 17, 'San Marcos La Laguna', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(233, 17, 'San Pablo La Laguna', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(234, 17, 'San Pedro La Laguna', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(235, 17, 'Santa Catarina Ixtahuacán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(236, 17, 'Santa Catarina Palopó', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(237, 17, 'Santa Clara La Laguna', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(238, 17, 'Santa Cruz La Laguna', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(239, 17, 'Santa Lucía Utatlán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(240, 17, 'Santa María Visitación', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(241, 17, 'Santiago Atitlán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(242, 18, 'Retalhuleu', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(243, 18, 'San Sebastián', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(244, 18, 'Santa Cruz Muluá', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(245, 18, 'San Martín Zapotitlán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(246, 18, 'San Felipe', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(247, 18, 'San Andrés Villa Seca', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(248, 18, 'Champerico', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(249, 18, 'Nuevo San Carlos', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(250, 18, 'El Asintal', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(251, 19, 'Mazatenango', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(252, 19, 'Cuyotenango', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(253, 19, 'San Francisco Zapotitlán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(254, 19, 'San Bernardino', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(255, 19, 'San José el Ídolo', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(256, 19, 'Santo Domingo Suchitépequez', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(257, 19, 'San Lorenzo', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(258, 19, 'Samayac', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(259, 19, 'San Pablo Jocopilas', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(260, 19, 'San Antonio Suchitépequez', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(261, 19, 'San Miguel Panám', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(262, 19, 'San Gabriel', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(263, 19, 'Chicacao', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(264, 19, 'Patulul', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(265, 19, 'Santa Bárbara', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(266, 19, 'San Juan Bautista', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(267, 19, 'Santo Tomás La Unión', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(268, 19, 'Zunilito', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(269, 19, 'Pueblo Nuevo', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(270, 19, 'Río Bravo', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(271, 20, 'Huehuetenango', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(272, 20, 'Chiantla', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(273, 20, 'Malacatancito', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(274, 20, 'Cuilco', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(275, 20, 'Nentón', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(276, 20, 'San Pedro Necta', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(277, 20, 'Jacaltenango', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(278, 20, 'Soloma', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(279, 20, 'Ixtahuacán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(280, 20, 'Santa Bárbara', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(281, 20, 'La Libertad', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(282, 20, 'La Democracia', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(283, 20, 'San Miguel Acatán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(284, 20, 'San Rafael La Independencia', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(285, 20, 'Todos Santos Cuchumatán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(286, 20, 'San Juan Atitlán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(287, 20, 'Santa Eulalia', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(288, 20, 'San Mateo Ixtatán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(289, 20, 'Colotenango', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(290, 20, 'San Sebastián Huehuetenango', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(291, 20, 'Tectitán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(292, 20, 'Concepción Huista', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(293, 20, 'San Juan Ixcoy', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(294, 20, 'San Antnio Huista', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(295, 20, 'Santa Cruz Barillas', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(296, 20, 'San Sebastián Coatán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(297, 20, 'Aguacatán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(298, 20, 'San Rafael Petzal', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(299, 20, 'San Gaspar Ixchil', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(300, 20, 'Santiago Chimaltenango', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(301, 20, 'Santa Ana Huista', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(302, 21, 'Santa Cruz de Quiché', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(303, 21, 'Chiché', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(304, 21, 'Chinique', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(305, 21, 'Zacualpa', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(306, 21, 'Chajul', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(307, 21, 'Santo Tomás Chichicastenango', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(308, 21, 'Patzité', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(309, 21, 'San Antonio Ilotenango', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(310, 21, 'San Pedro Jocopilas', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(311, 21, 'Cunén', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(312, 21, 'San Juan Cotzal', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(313, 21, 'Santa María Joyabaj', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(314, 21, 'Santa María Nebaj', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(315, 21, 'San Andrés Sajcabajá', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(316, 21, 'Uspatán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(317, 21, 'Sacapulas', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(318, 21, 'San Bartolomé Jocotenango', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(319, 21, 'Canillá', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(320, 21, 'Chicamán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(321, 21, 'Ixcán', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(322, 21, 'Pachalum', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(323, 22, 'Flores', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(324, 22, 'San José', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(325, 22, 'San Benito', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(326, 22, 'San Andrés', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(327, 22, 'La Libertad', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(328, 22, 'San Francisco', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(329, 22, 'Santa Ana', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(330, 22, 'Dolores', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(331, 22, 'San Luis', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(332, 22, 'Sayaxché', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(333, 22, 'Melchor de Mencos', b'1');
INSERT INTO municipio (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(334, 22, 'Poptún', b'1');

INSERT INTO bases_registro(descripcion,activo) VALUES ('Espécimen Preservado',b'1');
INSERT INTO bases_registro(descripcion,activo) VALUES ('Observación por Máquina',b'1');
INSERT INTO bases_registro(descripcion,activo) VALUES ('Observación Humana',b'1');
INSERT INTO bases_registro(descripcion,activo) VALUES ('Espécimen Vivo',b'1');
INSERT INTO bases_registro(descripcion,activo) VALUES ('Espécimen Fósil',b'1');

INSERT INTO etapas_vida(descripcion,activo) VALUES ('Larva',b'1');
INSERT INTO etapas_vida(descripcion,activo) VALUES ('Juvenil',b'1');
INSERT INTO etapas_vida(descripcion,activo) VALUES ('Adulto',b'1');
INSERT INTO etapas_vida(descripcion,activo) VALUES ('Otro',b'1');

INSERT INTO conservacion_organismo(descripcion,activo) VALUES ('Piel',b'1');
INSERT INTO conservacion_organismo(descripcion,activo) VALUES ('Esqueleto',b'1');
INSERT INTO conservacion_organismo(descripcion,activo) VALUES ('Formol',b'1');
INSERT INTO conservacion_organismo(descripcion,activo) VALUES ('Etanol',b'1');
