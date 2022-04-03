alter session set "_oracle_script"=true;  
create USER Hipodromo identified by Hipodromo;
GRANT CONNECT, RESOURCE, DBA TO Hipodromo;

CREATE TABLE CABALLOS(
	cod_caballo VARCHAR(4),
	nombre VARCHAR(20) NOT NULL,
	peso INT(3),
	fecha_nacimiento YEAR,
	propietario VARCHAR(25),
	nacionalidad VARCHAR(20),
	CONSTRAINT PK_CABALLOS PRIMARY KEY (cod_caballo),
	CONSTRAINT CK_CABALLOS CHECK (peso>240 AND peso<300),
	CONSTRAINT CK2_CABALLOS CHECK (CHAR(fecha_nacimiento,'yyyy')>2000),
	CONSTRAINT CK3_CABALLOS CHECK (nacionalidad = UPPER (nacionalidad))
);

CREATE TABLE PARTICIPACIONES(
	cod_caballo VARCHAR(4),
	cod_carrera VARCHAR(4),
	dorsal INT(2) NOT NULL,
	jockey VARCHAR(10) NOT NULL,
	posicion_final INT(2),
	CONSTRAINT PK_PARTICIPACIONES PRIMARY KEY (cod_caballo,cod_carrera),
	CONSTRAINT FK_PARTICIPACIONES FOREIGN KEY (cod_caballo) REFERENCES CABALLOS(cod_caballo),
	CONSTRAINT CK_PARTICIPACIONES CHECK (posicion_final>0)
);

CREATE TABLE CARRERAS(
	cod_carrera VARCHAR(4),
	fecha_hora DATE,
	importe_premio INT(6),
	apuesta_limite DOUBLE(5,2),
	CONSTRAINT PK_CARRERAS PRIMARY KEY(cod_carrera),
	CONSTRAINT CK_CARRERAS CHECK (CHAR(fecha_hora,'HH:MI')>='09:00' AND CHAR(fecha_hora , 'HH:MI')<='14:30'),
	CONSTRAINT CK2_CARRERAS CHECK (apuesta_limite<20000)
	);
ALTER TABLE PARTICIPACIONES ADD CONSTRAINT FK2_PARTICIPACIONES FOREIGN KEY(cod_carrera) REFERENCES CARRERAS(cod_carrera);

CREATE TABLE APUESTAS(
	dni_cliente VARCHAR(10),
	cod_caballo VARCHAR(4),
	cod_carrera VARCHAR(4),
	importe INT(6) DEFAULT 300 NOT NULL,
	tantoporuno DOUBLE(4,2),
	CONSTRAINT PK_APUESTAS PRIMARY KEY(dni_cliente),
	CONSTRAINT FK_APUESTAS FOREIGN KEY (cod_caballo) REFERENCES CABALLOS(cod_caballo) ON DELETE CASCADE,
	CONSTRAINT FK2_APUESTAS FOREIGN KEY(cod_carrera) REFERENCES CARRERAS(cod_carrera)ON  DELETE CASCADE,
	CONSTRAINT CK_APUESTAS CHECK (tantoporuno>1)
);
CREATE TABLE CLIENTES(
	dni VARCHAR(10),
	nombre VARCHAR(20),
	nacionalidad VARCHAR(20),
	CONSTRAINT PK_CLIENTES PRIMARY KEY(dni),
	CONSTRAINT CK_CLIENTES CHECK(regexp_like(dni,'[0-9]{8}[A-Z]{1}')),
	CONSTRAINT CK2_CLIENTES CHECK (nacionalidad = UPPER (nacionalidad))
);
ALTER TABLE APUESTAS ADD CONSTRAINT FK3_APUESTAS FOREIGN KEY(dni_cliente) REFERENCES CLIENTES(dni)ON DELETE CASCADE;
--Inserta el registro o registros necesarios para guardar la siguiente información:
--El cliente escocés realiza una apuesta al caballo más pesado de la primera carrera que se corra en el verano de 2009 por un importe de 2000 euros. En ese momento ese caballo en esa carrera se paga 30 a 1.
INSERT INTO CLIENTES(dni,nacionalidad)
VALUES ('47545324X','ESCOCES');

-- INSERT INTO CABALLOS(cod_caballo,nombre,peso,fecha_nacimiento)
-- VALUES ('1','RAYO',299,2022);

INSERT INTO CARRERAS(cod_carrera,fecha_hora)
VALUES ('1',DATE('09/06/2009 10:00','DD/MM/YYYY HH:MI'));

INSERT INTO APUESTAS
VALUES ('47545324X','1','1',2000,30.1);

--Inscribe a 2 caballos  en la carrera cuyo código es C6. La carrera aún no se ha celebrado. Invéntate los jockeys y los dorsales y los caballos.
INSERT INTO CARRERAS(cod_carrera)
VALUES ('C6');
INSERT INTO CABALLOS(cod_caballo,nombre)
VALUES ('2','Trueno');
INSERT INTO PARTICIPACIONES (cod_caballo,cod_carrera,dorsal,jockey)
VALUES ('2','C6',12,'2');
INSERT INTO CABALLOS(cod_caballo,nombre)
VALUES ('3','Bestia');
INSERT INTO PARTICIPACIONES (cod_caballo,cod_carrera,dorsal,jockey)
VALUES ('3','C6',13,'3');
--Inserta dos carreras con los datos que creas necesario.
INSERT INTO CARRERAS(cod_carrera)
VALUES ('C1');
INSERT INTO CARRERAS(cod_carrera)
VALUES ('C2');
--Quita el campo propietario de la tabla caballos
ALTER TABLE CABALLOS DROP COLUMN propietario;

--Añadir las siguientes restricciones a las tablas:
--En la Tabla Participaciones los nombres de los jockeys tienen siempre las iniciales en mayúsculas.
ALTER TABLE PARTICIPACIONES ADD CONSTRAINT CK2_PARTICIPACIONES CHECK (jockey = INITCAP (jockey));
--La temporada de carreras transcurre del 10 de Marzo al 10 de Noviembre.
ALTER TABLE CARRERAS ADD CONSTRAINT CK3_CARRERAS CHECK fecha_hora BETWEEN (TO_CHAR(fecha_hora,'DD/MM')>='10/03' AND TO_CHAR(fecha_hora , 'DD/MM')<='10/11');

--La nacionalidad de los caballos sólo puede ser Española, Británica o �?rabe.
ALTER TABLE CABALLOS ADD CONSTRAINT CK4_CABALLOS CHECK (nacionalidad IN ('Española','Británica','�?rabe'));      
--Borra las carreras en las que no hay caballos inscritos.
DELETE FROM PARTICIPACIONES WHERE (cod_caballo) IS NULL;
--Añade un campo llamado código en el campo clientes, que no permita valores nulos ni repetidos
ALTER TABLE CLIENTES ADD codigo VARCHAR2(4);
--Nos hemos equivocado y el código C6 de la carrera en realidad es C66.
UPDATE CARRERAS
SET cod_carrera ='C66'
WHERE cod_carrera = 'C6';

--Añade un campo llamado premio a la tabla apuestas.
ALTER TABLE APUESTAS ADD premio NUMBER(20);
--Borra todas las tablas y datos con el número menor de instrucciones posibles.
DROP TABLE CABALLOS CASCADE CONSTRAINT;
DROP TABLE PARTICIPACIONES CASCADE CONSTRAINT;
DROP TABLE CARRERAS CASCADE CONSTRAINT;
DROP TABLE APUESTAS CASCADE CONSTRAINT;
DROP TABLE CLIENTES CASCADE CONSTRAINT;
