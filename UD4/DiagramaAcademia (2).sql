alter session set "_oracle_script"=true;  
create user Academia identified by Academia;
GRANT CONNECT, RESOURCE, DBA TO Academia;

CREATE TABLE ALUMNOS(
	nombre VARCHAR2(100),
	apellido1 VARCHAR2(100),
	apellido2 VARCHAR2(100),
	dni NUMBER(10),
	direccion VARCHAR2(100),
	sexo VARCHAR2(10),
	fecha_nacimiento DATE,
	curso VARCHAR2(10),
	CONSTRAINT PK_ALUMNOS PRIMARY KEY (dni),
	CONSTRAINT CK_ALUMNOS CHECK (sexo IN ('H','M'))
);
	
CREATE TABLE CURSOS(
	nombre_curso VARCHAR2(100),
	cod_curso VARCHAR2(10),
	dni_profesor NUMBER(10),
	maximo_alumnos NUMBER(38),
	fecha_inicio DATE,
	fecha_fin DATE,
	num_horas NUMBER(38),
	CONSTRAINT PK_CURSOS PRIMARY KEY(cod_curso)

);
ALTER TABLE alumnos ADD CONSTRAINT FK_ALUMNOS FOREIGN KEY (curso) REFERENCES CURSOS(cod_curso);
CREATE TABLE PROFESORES(
	nombre VARCHAR2(100),
	apellido1 VARCHAR2(100),
	apellido2 VARCHAR2(100),
	dni NUMBER(10),
	direccion VARCHAR2(100),
	titulo VARCHAR2(100),
	gana NUMBER(38),
	CONSTRAINT PK_PROFESORES PRIMARY KEY(dni)
);
ALTER TABLE CURSOS ADD CONSTRAINT FK_CURSOS FOREIGN KEY(dni_profesor) REFERENCES PROFESORES(dni);

INSERT INTO PROFESORES(nombre,apellido1,apellido2,dni,direccion,titulo,gana)
VALUES ('Juan','Ardi','Lopez',32432455,'Puerta Negra4','Ing.Informatica',7500);

INSERT INTO PROFESORES(nombre,apellido1,apellido2,dni,direccion,titulo,gana)
VALUES ('Maria','Oliva','Rubio',43215643,'Juan Alfonso 32','Lda.Fil.Inglesa',5400);

INSERT INTO CURSOS(nombre_curso,cod_curso,dni_profesor,maximo_alumnos,fecha_inicio,fecha_fin,num_horas)
VALUES ('Ingles Basico',1,43215643,15,TO_DATE('01/11/00','dd/mm/yy'),TO_DATE('22/12/00','dd/mm/yy'),120);

INSERT INTO CURSOS(nombre_curso,cod_curso,dni_profesor,fecha_inicio,num_horas)
VALUES ('Administracion Linux',2,32432455,TO_DATE('01/09/00','dd/mm/yy'),80);

INSERT INTO ALUMNOS(nombre,apellido1,apellido2,dni,direccion,sexo,fecha_nacimiento,curso)
VALUES('Lucas','Manilva','Lopez',123523,'Alhamar,3','H',TO_DATE('01/11/79','dd/mm/yy'),1)


INSERT INTO ALUMNOS(nombre,apellido1,apellido2,dni,direccion,sexo,curso)
VALUES('Antonia','Lopez','Alcantara',2567567,'Maniqui,21','M',2)

INSERT INTO ALUMNOS(nombre,apellido1,apellido2,dni,direccion,sexo,curso)
VALUES('Manuel','Alcantara','Pedros',3123689,'Julian,2','H',2)


INSERT INTO ALUMNOS(nombre,apellido1,apellido2,dni,direccion,sexo,fecha_nacimiento,curso)
VALUES('Jose','Perez','Caballar',4896765,'Jarcha,5','H',TO_DATE('03/02/77','dd/mm/yy'),2)

INSERT INTO ALUMNOS(nombre,apellido1,apellido2,dni,sexo,curso)
VALUES('Sergio','Navas','Retal',123523,'H',1);

INSERT INTO PROFESORES(nombre,apellido1,apellido2,dni,direccion,titulo,gana)
VALUES('Juan','Arch','Lopez',32432456,'Puerta Negra,4','Ing.Informatica',NULL)

INSERT INTO ALUMNOS(nombre,apellido1,apellido2,dni,direccion,sexo,fecha_nacimiento)
VALUES('Maria','Jaen','Sevilla',789678,'Martos,5','M',NULL);

--La fecha de nacimiento de Antonia López está equivocada. La verdadera es 23 de diciembre de 1976.
UPDATE ALUMNOS
SET fecha_nacimiento=TO_DATE('23/12/1976','dd/mm/yy')
WHERE nombre='Antonia';

--Cambiar a Antonia López al curso de código 5.
UPDATE ALUMNOS
SET curso=5
WHERE nombre='Antonia';

--Eliminar la profesora Laura Jiménez
--No hay ninguna profesora que se llame Laura 
--Borrar el curso con código 1.
DELETE FROM CURSOS WHERE (cod_curso)=1;

--Añadir un campo llamado numero_alumnos en la tabla curso
ALTER TABLE CURSOS ADD numero_alumnos NUMBER(20);

--Modificar la fecha de nacimiento a 01/01/2012 en aquellos alumnos que no tengan fecha de nacimiento.
UPDATE ALUMNOS
SET fecha_nacimiento=TO_DATE('01/01/2012','dd/mm/yy')
WHERE fecha_nacimiento IS NULL;
--Borra el campo sexo en la tabla de alumnos.
ALTER TABLE ALUMNOS DROP COLUMN SEXO;
--Modificar la tabla profesores para que los  profesores de Informática cobren un 20 pro ciento más de lo que cobran actualmente.
UPDATE PROFESORES
SET gana=gana+gana*0.2/100
WHERE titulo='Ing.Informatica';
--Modifica el dni de Juan Arch a 1234567
UPDATE PROFESORES
SET dni=1234567
WHERE apellido1='Arch';
--Se tiene que buscar por el apellido1 debido a que nombre Juan hay 2

--Modifica el dni de todos los profesores de informática para que tengan el dni 7654321
SELECT * FROM PROFESORES WHERE (titulo) ='Ing.Informatica';
DELETE FROM PROFESORES WHERE (titulo) = 'Ing.Informatica';
ALTER TABLE ALUMNOS DROP CONSTRAINT FK_ALUMNOS;
ALTER TABLE ALUMNOS ADD CONSTRAINT FK_ALUMNOS FOREIGN KEY (curso) REFERENCES CURSOS(cod_curso) ON DELETE CASCADE;
ALTER TABLE CURSOS DROP CONSTRAINT FK_CURSOS;
ALTER TABLE CURSOS ADD CONSTRAINT FK_CURSOS FOREIGN KEY (dni_profesor) REFERENCES PROFESORES(dni) ON DELETE CASCADE;
--Cambia el sexo de la alumna María Jaén a H.
UPDATE ALUMNOS
SET sexo='H'
WHERE apellido1='Jaen';





