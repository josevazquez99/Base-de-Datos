--APARTADO 1 
INSERT INTO PERSONA
VALUES ('47545311X','Jose Antonio','Vazquez','Sevilla','C/Andalucia',38,'678133593',TO_DATE('12/12/1999','DD/MM/YYYY'),1);
INSERT INTO ALUMNO
VALUES('1','47545311X');
INSERT INTO ASIGNATURA(idasignatura,nombre)
VALUES('1','Contabilidad');
INSERT INTO ALUMNO_ASIGNATURA
VALUES('1','1',1);

--APARTADO 2
INSERT INTO PERSONA
VALUES('77222122K','MARTA LÓPEZ','MARTOS','SEVILLA','CALLE	 TARFIA',9,'615891432',TO_DATE('22/07/1981','DD/MM/YYYY'),0);
INSERT INTO PROFESOR
VALUES('1','77222122K');
INSERT INTO TITULACION
VALUES('1','Contabilidad');
UPDATE ASIGNATURA
SET idprofesor='1'
WHERE idasignatura='1';
UPDATE ASIGNATURA
SET idtitulacion='1'
WHERE idasignatura='1';

--APARTADO 3

CREATE TABLE ALUMNOS_MUYREPETIDORES(
	idasignatura VARCHAR2(6),
	idalumno VARCHAR2 (7),
	CONSTRAINT PK_ALUMNOS_MUYREPETIDORES PRIMARY KEY (idasignatura,idalumno),
	CONSTRAINT FK_ALUMNOS_MUYREPETIDORES FOREIGN KEY (idasignatura) REFERENCES ASIGNATURA(idasignatura),
	CONSTRAINT FK2_ALUMNOS_MUYREPETIDORES FOREIGN KEY (idalumno) REFERENCES ALUMNO(idalumno)
);
SELECT idasignatura, idalumno FROM ALUMNO_ASIGNATURA WHERE numeromatricula>=3;

INSERT INTO ALUMNOS_MUYREPETIDORES (idasignatura,idalumno) SELECT idasignatura ,idalumno FROM ALUMNO_ASIGNATURA
WHERE NUMEROMATRICULA>=3;

--APARTADO 4
ALTER TABLE ALUMNOS_MUYREPETIDORES ADD OBSERVACIONES VARCHAR2(20);
UPDATE ALUMNOS_MUYREPETIDORES
SET OBSERVACIONES ='Se	encuentra	en	seguimiento'
WHERE idalumno IN (SELECT idalumno FROM PERSONA p, ALUMNO a WHERE ciudad LIKE 'Sevilla' AND p.dni =a.dni);

--APARTADO 5
DELETE FROM ALUMNOS_MUYREPETIDORES 
WHERE idalumno IN (SELECT idalumno FROM PERSONA p, ALUMNO a WHERE fecha_nacimiento >= to_date('01/01/1971','DD/MM/YYYY'));

-- APARTADO 6
CREATE TABLE RESUMEN_TITULACIONES(
	idtitulacion VARCHAR2(6),
	nombre VARCHAR2(30),
	CONSTRAINT PK_RESUMEN_TITULACIONES PRIMARY KEY(idtitulacion),
	CONSTRAINT FK_RESUMEN_TITULACIONES FOREIGN KEY (idtitulacion) REFERENCES TITULACION (idtitulacion)
);
SELECT idtitulacion ,nombre FROM TITULACION ;
INSERT INTO RESUMEN_TITULACIONES (idtitulacion,nombre) SELECT idtitulacion,nombre FROM TITULACION;

--APARTADO 7
--7.1
--Si se podria ya que estas trabajando desde el mismo equipo de trabajo y con la misma base de datos.
--CREATE TABLE FACTURA(
--nombre VARCHAR2(10)
--);
--7.2
--CREATE TABLE CLIENTE(
--nombre VARCHAR2(10)
--);
--Si están los  datos sin el auto-commit , ya que estas trabajando en la misma base de datos.
--7.3
--
--7.4
--Un savepoint para que los datos queden guardados en la tabla.
--7.5
--No sería posible ya que has borrado todos los datos de la tabla , por lo que deberías volver a crear la tabla con los datos necesarios.
--7.6
--Consiste en un modo de salvaguarda dentro de la base de datos, el insert lo he utilizado cuando he tenido que insertar datos en algunas tablas y el savepoint cuando se quedan guardadas las tablas..



