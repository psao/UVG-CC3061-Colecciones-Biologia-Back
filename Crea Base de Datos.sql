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
  activo BIT      ,
PRIMARY KEY(codigo_nivel));




CREATE TABLE etapas_vida (
  codigo_etapa SERIAL  NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BIT      ,
PRIMARY KEY(codigo_etapa));




CREATE TABLE pais (
  codigo_pais SERIAL  NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BIT      ,
PRIMARY KEY(codigo_pais));




CREATE TABLE tipo_rrss (
  codigo_red SERIAL  NOT NULL ,
  descripcion VARCHAR(50)    ,
  icono TEXT    ,
  activo BIT      ,
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




CREATE TABLE configuracion (
  codigo_configuracion SERIAL  NOT NULL ,
  logo TEXT    ,
  imagen_portada TEXT    ,
  acerca_nosotros TEXT    ,
  dias_prestamo INT      ,
PRIMARY KEY(codigo_configuracion));




CREATE TABLE bodega (
  codigo_bodega SERIAL  NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BIT      ,
PRIMARY KEY(codigo_bodega));




CREATE TABLE bases_registro (
  codigo_base SERIAL  NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BIT      ,
PRIMARY KEY(codigo_base));




CREATE TABLE conservacion_organismo (
  codigo_conservacion SERIAL  NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BIT      ,
PRIMARY KEY(codigo_conservacion));




CREATE TABLE usuario (
  codigo_usuario INT   NOT NULL ,
  nombre VARCHAR(50)    ,
  apellido VARCHAR(75)    ,
  usuario SERIAL   ,
  contrasenia VARCHAR(50)    ,
  correo VARCHAR(75)    ,
  permiso INT   NOT NULL ,
  activo BIT    ,
  actividad TEXT    ,
  foto TEXT      ,
PRIMARY KEY(codigo_usuario)  ,
  FOREIGN KEY(permiso)
    REFERENCES niveles_usuarios(codigo_nivel));


CREATE INDEX usuario_FKIndex1 ON usuario (permiso);


CREATE INDEX IFK_rus_nusuarios ON usuario (permiso);


CREATE TABLE ubicacion (
  codigo_ubicacion SERIAL  NOT NULL ,
  codigo_bodega INT   NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BIT      ,
PRIMARY KEY(codigo_ubicacion)  ,
  FOREIGN KEY(codigo_bodega)
    REFERENCES bodega(codigo_bodega));


CREATE INDEX ubicacion_FKcodigo_bodega ON ubicacion (codigo_bodega);


CREATE INDEX IFK_rbod_bicacion ON ubicacion (codigo_bodega);


CREATE TABLE autorizadores (
  codigo_autorizador SERIAL  NOT NULL ,
  codigo_usuario INT   NOT NULL ,
  prestamos BIT    ,
  organismos BIT    ,
  frecha_ingresado TIMESTAMP      ,
PRIMARY KEY(codigo_autorizador)  ,
  FOREIGN KEY(codigo_usuario)
    REFERENCES usuario(codigo_usuario));


CREATE INDEX autorizadores_FKcodigo_usuario ON autorizadores (codigo_usuario);


CREATE INDEX IFK_rus_autorizador ON autorizadores (codigo_usuario);


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
  habitat VARCHAR(100)    ,
  sexo CHAR(1)    ,
  etapa_vida INT   NOT NULL ,
  comentarios_colector TEXT    ,
  fecha_recoleccion DATETIME    ,
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


CREATE TABLE seccion (
  codigo_seccion SERIAL  NOT NULL ,
  codigo_ubicacion INT   NOT NULL ,
  descripcion VARCHAR(50)    ,
  activo BIT      ,
PRIMARY KEY(codigo_seccion)  ,
  FOREIGN KEY(codigo_ubicacion)
    REFERENCES ubicacion(codigo_ubicacion));


CREATE INDEX seccion_FKcodigo_ubicacion ON seccion (codigo_ubicacion);


CREATE INDEX IFK_rub_seccion ON seccion (codigo_ubicacion);


CREATE TABLE autorizacion_organismo (
  codigo_autorizacion SERIAL  NOT NULL ,
  codigo_autorizador INT   NOT NULL ,
  codigo_organismo INT   NOT NULL   ,
PRIMARY KEY(codigo_autorizacion)    ,
  FOREIGN KEY(codigo_organismo)
    REFERENCES organismo(interno_organismo),
  FOREIGN KEY(codigo_autorizador)
    REFERENCES autorizadores(codigo_autorizador));


CREATE INDEX autorizacion_organismo_FKcodigo_organismo ON autorizacion_organismo (codigo_organismo);
CREATE INDEX autorizacion_organismo_FKcodigo_autorizador ON autorizacion_organismo (codigo_autorizador);


CREATE INDEX IFK_ror_autorizacion ON autorizacion_organismo (codigo_organismo);
CREATE INDEX IFK_rau_auorganismo ON autorizacion_organismo (codigo_autorizador);


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


CREATE TABLE prestamos (
  codigo_prestamo SERIAL  NOT NULL ,
  interno_organismo INT   NOT NULL ,
  interno_persona INT   NOT NULL ,
  fecha_prestamo DATETIME    ,
  fecha_retorno DATETIME    ,
  fecha_retornado DATETIME    ,
  autorizado BIT      ,
PRIMARY KEY(codigo_prestamo)    ,
  FOREIGN KEY(interno_persona)
    REFERENCES personas(codigo_interno),
  FOREIGN KEY(interno_organismo)
    REFERENCES organismo(interno_organismo));


CREATE INDEX prestamos_FKinterno_persona ON prestamos (interno_persona);
CREATE INDEX prestamos_FKinterno_organismo ON prestamos (interno_organismo);


CREATE INDEX IFK_rpre_personas ON prestamos (interno_persona);
CREATE INDEX IFK_rorg_prestamos ON prestamos (interno_organismo);


CREATE TABLE autorizacion_prestamo (
  codigo_autorizacion INT   NOT NULL ,
  codigo_autorizador INT   NOT NULL ,
  codigo_prestamo INT   NOT NULL   ,
PRIMARY KEY(codigo_autorizacion)    ,
  FOREIGN KEY(codigo_prestamo)
    REFERENCES prestamos(codigo_prestamo),
  FOREIGN KEY(codigo_autorizador)
    REFERENCES autorizadores(codigo_autorizador));


CREATE INDEX autorizacion_prestamo_FKcodigo_prestamo ON autorizacion_prestamo (codigo_prestamo);
CREATE INDEX autorizacion_prestamo_FKcodigo_autorizador ON autorizacion_prestamo (codigo_autorizador);


CREATE INDEX IFK_rpr_auprestamos ON autorizacion_prestamo (codigo_prestamo);
CREATE INDEX IFK_rau_auprestamo ON autorizacion_prestamo (codigo_autorizador);







-- CREANDO CONFIGURACION INICIAL

INSERT INTO niveles_taxonomicos(descripcion,orden,activo) VALUES('Reino',1,TRUE);
INSERT INTO niveles_taxonomicos(descripcion,orden,activo) VALUES('Filo',2,TRUE);
INSERT INTO niveles_taxonomicos(descripcion,orden,activo) VALUES('Clase',3,TRUE);
INSERT INTO niveles_taxonomicos(descripcion,orden,activo) VALUES('Orden',4,TRUE);
INSERT INTO niveles_taxonomicos(descripcion,orden,activo) VALUES('Familia',5,TRUE);

-- CREANDO PAISES

INSERT INTO pais(descripcion,activo) values('Guatemala',TRUE);

-- CREANDO DEPARTAMENTOS

INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (1,'Guatemala',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (2,'Alta Verapaz',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (3,'Baja Verapaz',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (4,'Izabal',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (5,'Chiquimula',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (6,'Zacapa',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (7,'El Progreso',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (8,'Jutiapa',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (9,'Jalapa',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (10,'Santa Rosa',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (11,'Chimaltenango',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (12,'Sacatepéquez',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (13,'Escuintla',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (14,'San Marcos',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (15,'Quetzaltenango',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (16,'Totonicapán',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (17,'Sololá',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (18,'Retalhuleu',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (19,'Suchitepéquez',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (20,'Hueheutenango',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (21,'Quiché',TRUE);
INSERT INTO departamento(codigo_pais,descripcion,activo) VALUES (22,'Petén',TRUE);

-- CREANDO MUNICIPIOS

INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(1, 1, 'Guatemala', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(2, 1, 'Santa Catarina Pinula', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(3, 1, 'San José Pinula', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(4, 1, 'San José del Golfo', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(5, 1, 'Palencia', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(6, 1, 'Chinautla', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(7, 1, 'San Pedro Ayampuc', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(8, 1, 'Mixco', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(9, 1, 'San Pedro Sacatepéquez', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(10, 1, 'San Juan Sacatepéquez', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(11, 1, 'Chuarrancho', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(12, 1, 'San Raymundo', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(13, 1, 'Fraijanes', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(14, 1, 'Amátitlán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(15, 1, 'Villa Nueva', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(16, 1, 'Villa Canales', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(17, 1, 'San Miguel Petapa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(18, 2, 'Cobán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(19, 2, 'Santa Cruz Verapaz', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(20, 2, 'San Cristóbal Verapaz', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(21, 2, 'Tactic', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(22, 2, 'Tamahú', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(23, 2, 'San Miguel Tucurú', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(24, 2, 'Panzóz', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(25, 2, 'Senahú', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(26, 2, 'San Pedro Carchá', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(27, 2, 'San Juan Chamelco', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(28, 2, 'San Agustín Lanquín', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(29, 2, 'Santa María Cahabón', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(30, 2, 'Chisec', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(31, 2, 'Chahal', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(32, 2, 'Fray Bartolomé de las Casas', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(33, 2, 'Santa Catalina La Tinta', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(34, 2, 'Raxruhá', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(35, 3, 'Salamá', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(36, 3, 'San Miguel Chicaj', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(37, 3, 'Rabinal', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(38, 3, 'Cubulco', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(39, 3, 'Granados', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(40, 3, 'Santa Cruz el Chol', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(41, 3, 'San Jerónimo', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(42, 3, 'Purulhá', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(43, 4, 'Morales', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(44, 4, 'Los Amates', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(45, 4, 'Livingston', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(46, 4, 'El Estor', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(47, 4, 'Puerto Barrios', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(48, 5, 'Chiquimula', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(49, 5, 'Jocotán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(50, 5, 'Esquipulas', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(51, 5, 'Comotán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(52, 5, 'Quezaltepeque', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(53, 5, 'Olopa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(54, 5, 'Ipala', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(55, 5, 'San Juan Hermita', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(56, 5, 'Concepción Las Minas', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(57, 5, 'San Jacinto', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(58, 5, 'San José la Arada', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(59, 6, 'Zacapa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(60, 6, 'Estanzuela', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(61, 6, 'Gualán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(62, 6, 'Huité', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(63, 6, 'La Unión', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(64, 6, 'Cabañas', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(65, 6, 'Río Hondo', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(66, 6, 'San Jorge', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(67, 6, 'San Diego', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(68, 6, 'Teculután', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(69, 6, 'Usumatlán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(70, 7, 'El Jícaro', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(71, 7, 'Morazán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(72, 7, 'San Agustín Acasaguastlán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(73, 7, 'San Antonio La Paz', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(74, 7, 'San Cristóbal Acasaguastlán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(75, 7, 'Sanarate', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(76, 7, 'Guastatoya', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(77, 7, 'Sansare', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(78, 8, 'Jutiapa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(79, 8, 'El Progreso Jutiapa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(80, 8, 'Santa Catarina Mita', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(81, 8, 'Yupiltepeque', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(82, 8, 'Atescatempa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(83, 8, 'Jerez', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(84, 8, 'El Adelanto', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(85, 8, 'Zopotitlán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(86, 8, 'Comapa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(87, 8, 'Jalpatagua', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(88, 8, 'Conguaco', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(89, 8, 'Moyuta', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(90, 8, 'Pasaco', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(91, 8, 'Quesada', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(92, 8, 'Agua Blanca', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(93, 8, 'Asunción Mita', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(94, 9, 'Jalapa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(95, 9, 'San Pedro Pinula', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(96, 9, 'San Luis Jilotepeque', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(97, 9, 'San Manuel Chaparrón', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(98, 9, 'San Carlos Alzatate', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(99, 9, 'Monjas', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(100, 9, 'Mataquescuintla', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(101, 10, 'Cuilapa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(102, 10, 'Casillas Santa Rosa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(103, 10, 'Chiquimulilla', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(104, 10, 'Guazacapán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(105, 10, 'Nueva Santa Rosa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(106, 10, 'Oratorio', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(107, 10, 'Pueblo Nuevo Viñas', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(108, 10, 'San Juan Tecuaco', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(109, 10, 'San Rafael Las Flores', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(110, 10, 'Santa Cruz Naranjo', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(111, 10, 'Santa María Ixhuatán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(112, 10, 'Santa Rosa de Lima', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(113, 10, 'Taxisco', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(114, 10, 'Barberena', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(115, 11, 'Chimaltenango', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(116, 11, 'San José Poaquil', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(117, 11, 'San Martín Jilotepeque', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(118, 11, 'San Juan Comalapa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(119, 11, 'Santa Aplolonia', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(120, 11, 'Tecpán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(121, 11, 'Patzún', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(122, 11, 'San Miguel Pochuta', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(123, 11, 'Patzicía', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(124, 11, 'Santa Cruz Balanyá', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(125, 11, 'Acatenango', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(126, 11, 'San Pedro Yepocapa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(127, 11, 'San Andrés Itzapa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(128, 11, 'Parramos', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(129, 11, 'Zaragoza', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(130, 11, 'El Tejar', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(131, 12, 'Antigua Guatemala', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(132, 12, 'San Juan Alotenango', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(133, 12, 'Ciudad Vieja', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(134, 12, 'Jocotenango', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(135, 12, 'Magdalena Milpas Altas', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(136, 12, 'Pastores', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(137, 12, 'San Antonio Aguas Calientes', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(138, 12, 'San Bartolomé Milpas Altas', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(139, 12, 'San Lucas Sacatepéquez', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(140, 12, 'San Miguel Dueñas', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(141, 12, 'Santa Catarina Barahona', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(142, 12, 'Santa Lucía Milpas Altas', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(143, 12, 'Santa María de Jesús', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(144, 12, 'Santiago Sacatepéquez', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(145, 12, 'Santiago Sacatepéquez', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(146, 12, 'Santo Domingo Xenacoj', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(147, 12, 'Supango', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(148, 13, 'Escuintla', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(149, 13, 'Santa Lucía Cotzumalguapa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(150, 13, 'La Democracia', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(151, 13, 'Siquinalá', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(152, 13, 'Masagua', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(153, 13, 'Tiquisate', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(154, 13, 'La Gomera', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(155, 13, 'Guaganazapa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(156, 13, 'San José', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(157, 13, 'Iztapa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(158, 13, 'Palín', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(159, 13, 'San Vicente Pacaya', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(160, 13, 'Nueva Concepción', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(161, 14, 'San Marcos', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(162, 14, 'Ayutla / Tecún Umán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(163, 14, 'Catalina', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(164, 14, 'Comitancillo', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(165, 14, 'Concepción Tutuapa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(166, 14, 'El Quetzal', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(167, 14, 'El Rodeo', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(168, 14, 'El Tumblador', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(169, 14, 'Ixchiguán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(170, 14, 'La Reforma', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(171, 14, 'Malacatán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(172, 14, 'Nuevo Progreso', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(173, 14, 'Ocós', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(174, 14, 'Pajapita', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(175, 14, 'Esquipulas Palo Gordo', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(176, 14, 'San Antonio Sacatepéquez', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(177, 14, 'San Cristóbal Cucho', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(178, 14, 'San José Ojetenam', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(179, 14, 'San Lorenzo', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(180, 14, 'San Miguel Ixtahuacán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(181, 14, 'San Pablo', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(182, 14, 'San Pedro Sacatepéquez', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(183, 14, 'San Rafael Pie de la Cuesta', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(184, 14, 'Sibinal', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(185, 14, 'Sipacapa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(186, 14, 'Tacaná', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(187, 14, 'Tajumulco', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(188, 14, 'Tejutla', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(189, 14, 'Río Blanco', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(190, 14, 'La Blanca', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(191, 15, 'Quetzaltenango', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(192, 15, 'Salcajá', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(193, 15, 'Olintepeque', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(194, 15, 'San Carlos Sija', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(195, 15, 'Sibilia', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(196, 15, 'Cabricán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(197, 15, 'Cajolá', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(198, 15, 'San Miguel Sigüilá', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(199, 15, 'San Juan Ostuncalco', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(200, 15, 'San Mateo', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(201, 15, 'Concepción Chiquirichapa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(202, 15, 'San Martín Sacatepéquez', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(203, 15, 'Almolonga', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(204, 15, 'Cantel', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(205, 15, 'Huitán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(206, 15, 'Zunil', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(207, 15, 'Colomba', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(208, 15, 'San Francisco La Unión', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(209, 15, 'El Palmar', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(210, 15, 'Coatepeque', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(211, 15, 'Génova', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(212, 15, 'Flores Costa Cuca', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(213, 15, 'La Esperanza', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(214, 15, 'Palestina de Los Altos', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(215, 16, 'Totonicapán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(216, 16, 'San Cristóbal Totonicapán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(217, 16, 'San Francisco El Alto', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(218, 16, 'San Andrés Xecul', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(219, 16, 'Momostenango', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(220, 16, 'Santa María Chiquimula', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(221, 16, 'Santa Lucía La Reforma', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(222, 16, 'San Bartolo', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(223, 17, 'Sololá', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(224, 17, 'Concepción', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(225, 17, 'Nahualá', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(226, 17, 'Panajachel', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(227, 17, 'San Andrés Semetabaj', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(228, 17, 'San Antonio Palopó', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(229, 17, 'San José Chacayá', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(230, 17, 'San Juan La Laguna', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(231, 17, 'San Lucas Tolimán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(232, 17, 'San Marcos La Laguna', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(233, 17, 'San Pablo La Laguna', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(234, 17, 'San Pedro La Laguna', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(235, 17, 'Santa Catarina Ixtahuacán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(236, 17, 'Santa Catarina Palopó', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(237, 17, 'Santa Clara La Laguna', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(238, 17, 'Santa Cruz La Laguna', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(239, 17, 'Santa Lucía Utatlán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(240, 17, 'Santa María Visitación', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(241, 17, 'Santiago Atitlán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(242, 18, 'Retalhuleu', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(243, 18, 'San Sebastián', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(244, 18, 'Santa Cruz Muluá', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(245, 18, 'San Martín Zapotitlán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(246, 18, 'San Felipe', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(247, 18, 'San Andrés Villa Seca', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(248, 18, 'Champerico', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(249, 18, 'Nuevo San Carlos', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(250, 18, 'El Asintal', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(251, 19, 'Mazatenango', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(252, 19, 'Cuyotenango', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(253, 19, 'San Francisco Zapotitlán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(254, 19, 'San Bernardino', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(255, 19, 'San José el Ídolo', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(256, 19, 'Santo Domingo Suchitépequez', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(257, 19, 'San Lorenzo', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(258, 19, 'Samayac', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(259, 19, 'San Pablo Jocopilas', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(260, 19, 'San Antonio Suchitépequez', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(261, 19, 'San Miguel Panám', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(262, 19, 'San Gabriel', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(263, 19, 'Chicacao', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(264, 19, 'Patulul', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(265, 19, 'Santa Bárbara', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(266, 19, 'San Juan Bautista', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(267, 19, 'Santo Tomás La Unión', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(268, 19, 'Zunilito', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(269, 19, 'Pueblo Nuevo', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(270, 19, 'Río Bravo', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(271, 20, 'Huehuetenango', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(272, 20, 'Chiantla', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(273, 20, 'Malacatancito', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(274, 20, 'Cuilco', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(275, 20, 'Nentón', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(276, 20, 'San Pedro Necta', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(277, 20, 'Jacaltenango', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(278, 20, 'Soloma', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(279, 20, 'Ixtahuacán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(280, 20, 'Santa Bárbara', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(281, 20, 'La Libertad', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(282, 20, 'La Democracia', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(283, 20, 'San Miguel Acatán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(284, 20, 'San Rafael La Independencia', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(285, 20, 'Todos Santos Cuchumatán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(286, 20, 'San Juan Atitlán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(287, 20, 'Santa Eulalia', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(288, 20, 'San Mateo Ixtatán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(289, 20, 'Colotenango', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(290, 20, 'San Sebastián Huehuetenango', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(291, 20, 'Tectitán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(292, 20, 'Concepción Huista', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(293, 20, 'San Juan Ixcoy', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(294, 20, 'San Antnio Huista', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(295, 20, 'Santa Cruz Barillas', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(296, 20, 'San Sebastián Coatán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(297, 20, 'Aguacatán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(298, 20, 'San Rafael Petzal', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(299, 20, 'San Gaspar Ixchil', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(300, 20, 'Santiago Chimaltenango', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(301, 20, 'Santa Ana Huista', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(302, 21, 'Santa Cruz de Quiché', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(303, 21, 'Chiché', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(304, 21, 'Chinique', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(305, 21, 'Zacualpa', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(306, 21, 'Chajul', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(307, 21, 'Santo Tomás Chichicastenango', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(308, 21, 'Patzité', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(309, 21, 'San Antonio Ilotenango', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(310, 21, 'San Pedro Jocopilas', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(311, 21, 'Cunén', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(312, 21, 'San Juan Cotzal', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(313, 21, 'Santa María Joyabaj', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(314, 21, 'Santa María Nebaj', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(315, 21, 'San Andrés Sajcabajá', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(316, 21, 'Uspatán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(317, 21, 'Sacapulas', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(318, 21, 'San Bartolomé Jocotenango', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(319, 21, 'Canillá', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(320, 21, 'Chicamán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(321, 21, 'Ixcán', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(322, 21, 'Pachalum', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(323, 22, 'Flores', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(324, 22, 'San José', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(325, 22, 'San Benito', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(326, 22, 'San Andrés', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(327, 22, 'La Libertad', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(328, 22, 'San Francisco', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(329, 22, 'Santa Ana', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(330, 22, 'Dolores', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(331, 22, 'San Luis', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(332, 22, 'Sayaxché', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(333, 22, 'Melchor de Mencos', true);
INSERT INTO municipios (codigo_municipio,codigo_departamento,decripcion,activo) VALUES(334, 22, 'Poptún', true);

INSERT INTO bases_registro(descripcion,activo) VALUES ('Espécimen Preservado',TRUE);
INSERT INTO bases_registro(descripcion,activo) VALUES ('Observación por Máquina',TRUE);
INSERT INTO bases_registro(descripcion,activo) VALUES ('Observación Humana',TRUE);
INSERT INTO bases_registro(descripcion,activo) VALUES ('Espécimen Vivo',TRUE);
INSERT INTO bases_registro(descripcion,activo) VALUES ('Espécimen Fósil',TRUE);

INSERT INTO etapas_vida(descripcion,activo) VALUES ('Larva',TRUE);
INSERT INTO etapas_vida(descripcion,activo) VALUES ('Juvenil',TRUE);
INSERT INTO etapas_vida(descripcion,activo) VALUES ('Adulto',TRUE);
INSERT INTO etapas_vida(descripcion,activo) VALUES ('Otro',TRUE);

INSERT INTO conservacion_organismo(descripcion,activo) VALUES ('Piel',TRUE);
INSERT INTO conservacion_organismo(descripcion,activo) VALUES ('Esqueleto',TRUE);
INSERT INTO conservacion_organismo(descripcion,activo) VALUES ('Formol',TRUE);
INSERT INTO conservacion_organismo(descripcion,activo) VALUES ('Etanol',TRUE);
