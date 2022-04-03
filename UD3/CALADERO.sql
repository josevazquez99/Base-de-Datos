CREATE TABLE BARCOS(
	matricula VARCHAR2(50),
	nombre VARCHAR2(50),
	clase VARCHAR2(50),
	armador VARCHAR2(50),
	capacidad NUMBER(8),
	nacionalidad VARCHAR2(50),
	CONSTRAINT PK_BARCOS PRIMARY KEY (matricula),
	CONSTRAINT CK_BARCOS CHECK(regexp_like(matricula,'[A-Z]{2}[-][0-9]{4}'))
);

CREATE TABLE LOTES(
	codigo VARCHAR2(50),
	matricula VARCHAR2(50),
	num_kilos NUMBER(8),
	precio_porkilosalida NUMBER(8),
	precio_porkiloadjudicado NUMBER(8),
	fecha_venta NUMBER(8) NOT NULL,
	cod_especie VARCHAR2(50),
	CONSTRAINT PK_LOTES PRIMARY KEY (codigo),
	CONSTRAINT FK_LOTES FOREIGN KEY (matricula) REFERENCES BARCOS(matricula),
	CONSTRAINT CK_LOTES CHECK (precio_porkiloadjudicado > precio_porkilosalida),
	CONSTRAINT CK2_LOTES CHECK(num_kilos > 0)
);

CREATE TABLE ESPECIE(
	codigo VARCHAR2(50) NOT NULL,
	nombre VARCHAR2(50),
	tipo VARCHAR2(50),
	cupo_porbarco NUMBER(8),
	caladero_principal NUMBER(8),
	CONSTRAINT PK_ESPECIE PRIMARY KEY (codigo)
);

ALTER TABLE LOTES ADD CONSTRAINT FK2_LOTES FOREIGN KEY (codigo) REFERENCES ESPECIE(codigo);

CREATE TABLE CALADERO(
	codigo VARCHAR2(50),
	nombre VARCHAR2(50),
	ubicacion VARCHAR2(50),
	especie_principal VARCHAR2(50),
	CONSTRAINT PK_CALADERO PRIMARY KEY (codigo),
	CONSTRAINT FK_CALADERO FOREIGN KEY (codigo) REFERENCES ESPECIE(codigo),
	CONSTRAINT CK_CALADERO CHECK(nombre= UPPER(nombre) AND ubicacion = UPPER(ubicacion))

);

ALTER TABLE ESPECIE ADD CONSTRAINT FK2_ESPECIE FOREIGN KEY (codigo) REFERENCES CALADERO(codigo);

CREATE TABLE FECHAS_CAPTURAS_PERMITIDAS(
	cod_especie VARCHAR2(50),
	cod_caladero VARCHAR2(50),
	fecha_inicial NUMBER(8),
	fecha_final NUMBER(8),
	CONSTRAINT PK_FECHAS_CAPTURAS PRIMARY KEY (cod_especie),
	CONSTRAINT FK_FECHAS_CAPTURAS FOREIGN KEY (cod_especie) REFERENCES ESPECIE(codigo),
	CONSTRAINT FK2_FECHAS_CAPTURAS FOREIGN KEY (cod_caladero) REFERENCES CALADERO(codigo)
);
ALTER TABLE LOTES MODIFY fecha_venta DATE;

--Las restricciones que hay que tener en cuenta son:
-- La matrícula de los barcos empieza por dos letras mayúsculas, luego tiene un guión y luego cuatro números
--La fechaventa de la tabla lotes no admite valores nulos.
-- El campo precioporkiloadjudicado debe ser mayor que el campo precioporkilosalida.
--El campo numkilos y los campos precio de la tabla lotes deben ser mayor que cero
-- El campo nombre y ubicación de la tabla caladero deben estar siempre en mayúsculas.
--Hay que tener en cuenta que en ningún caladero se permite ninguna captura de especie desde el 2 de febrero al 28 de marzo
ALTER TABLE FECHAS_CAPTURAS_PERMITIDAS ADD CONSTRAINT CK_FECHAS_CAPTURAS CHECK(TO_CHAR(fecha_inicial,'dd/mm')<'02/02' OR TO_CHAR(fecha_inicial,'mm/dd')>'03/28');
ALTER TABLE FECHAS_CAPTURAS_PERMITIDAS ADD CONSTRAINT CK2_FECHAS_CAPTURAS CHECK(TO_CHAR(fecha_final,'mm/dd')<'02/02' OR TO_CHAR (fecha_final,'mm/dd')>'03/28');


--Añade un nuevo campo a la tabla caladero que almacene el nombre científico.
ALTER TABLE CALADERO ADD nombre_cientifico VARCHAR2(50); 

--3. Borra el campo armador de la tabla barco
ALTER TABLE BARCOS DROP COLUMN armador;

--4. Borra todas las tablas 
DROP TABLE BARCOS CASCADE CONSTRAINT;
DROP TABLE CALADERO CASCADE CONSTRAINT;
DROP TABLE ESPECIE CASCADE CONSTRAINT;
DROP TABLE LOTES CASCADE CONSTRAINT;
DROP TABLE FECHAS_CAPTURAS_PERMITIDAS CASCADE CONSTRAINT;
