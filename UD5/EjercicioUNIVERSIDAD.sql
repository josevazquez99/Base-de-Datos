--1 Mostrar los nombres y los créditos de cada una de las asignaturas.
SELECT NOMBRE,CREDITOS FROM ASIGNATURA;
--2 Obtener los posibles distintos créditos de las asignaturas que hay en la base de datos.
SELECT DISTINCT CREDITOS FROM ASIGNATURA;
--3 Mostrar todos los datos de todas de las personas
SELECT *FROM PERSONA;
--4 Mostrar el nombre y créditos de las asignaturas del primer cuatrimestre.
SELECT NOMBRE,CREDITOS FROM ASIGNATURA WHERE CUATRIMESTRE =1;
--5 Mostrar el nombre y el apellido de las personas nacidas antes del 1 de enero de 1975.
SELECT NOMBRE,APELLIDO FROM PERSONA WHERE FECHA_NACIMIENTO < TO_DATE('01/01/1975','DD/MM/YYYY') ;
--6 Mostrar el nombre y el coste básico de las asignaturas de más de 4,5 créditos.
SELECT NOMBRE,COSTEBASICO FROM ASIGNATURA WHERE CREDITOS >4.5;
--7 Mostrar el nombre de las asignaturas cuyo coste básico está entre 25 y 35 euros.
SELECT NOMBRE FROM ASIGNATURA WHERE COSTEBASICO BETWEEN 25  AND 35;
--8 Mostrar el identificador de los alumnos matriculados en la asignatura '150212' o en la '130113' o en ambas.
SELECT DISTINCT IDALUMNO FROM ALUMNO_ASIGNATURA WHERE IDASIGNATURA IN('150212') OR IDASIGNATURA IN ('130113')OR IDASIGNATURA IN ('150212','130113');
--9 Obtener el nombre de las asignaturas del 2º cuatrimestre que no sean de 6 créditos.
SELECT NOMBRE FROM ASIGNATURA WHERE CUATRIMESTRE = 2 AND CREDITOS !=6;
--10 Mostrar el nombre y el apellido de las personas cuyo apellido comience por 'G'.
SELECT NOMBRE,APELLIDO FROM PERSONA WHERE APELlIDO LIKE 'G%';
--11 Obtener el nombre de las asignaturas que no tienen dato para el IdTitulacion.
SELECT NOMBRE FROM ASIGNATURA WHERE IDTITULACION IS NULL;
--12 Obtener el nombre de las asignaturas que tienen dato para el IdTitulacion.
SELECT NOMBRE FROM ASIGNATURA WHERE IDTITULACION IS NOT NULL;
--13 Mostrar el nombre de las asignaturas cuyo coste por cada crédito sea mayor de 8 euros.
SELECT NOMBRE FROM ASIGNATURA WHERE (COSTEBASICO / CREDITOS) >8;
--14 Mostrar el nombre y el número de horas de las asignaturas de la base de datos. (1cred.=10 horas).
--DUDA --
SELECT NOMBRE,CREDITOS *10 AS NUM_HORAS FROM ASIGNATURA;
--15 Mostrar todos los datos de las asignaturas del 2º cuatrimestre ordenados por el identificador de asignatura.
SELECT * FROM ASIGNATURA WHERE CUATRIMESTRE=2 ORDER BY IDASIGNATURA;
--16 Mostrar el nombre de todas las mujeres que viven en “Madrid�?.
SELECT * FROM PERSONA WHERE CIUDAD = 'Madrid' AND VARON =0;
--17 Mostrar el nombre y los teléfonos de aquellas personas cuyo teléfono empieza por 91
SELECT NOMBRE,TELEFONO FROM PERSONA WHERE TELEFONO LIKE '91%';
--18 Mostrar el nombre de las asignaturas que contengan la sílaba “pro�?
SELECT NOMBRE FROM ASIGNATURA WHERE LOWER(NOMBRE) LIKE ('%pro%');
--19 Mostrar el nombre de la asignatura de primero y que lo imparta el profesor que tiene código P101
SELECT NOMBRE FROM ASIGNATURA WHERE CURSO = 1 AND IDPROFESOR LIKE '%101%';
--20 Mostrar el código de alumno que se ha matriculado tres o más veces de una asignatura, mostrando también el código de la asignatura correspondiente.
SELECT IDALUMNO,IDASIGNATURA FROM ALUMNO_ASIGNATURA WHERE NUMEROMATRICULA >=3;
--21 El coste de cada asignatura va subiendo a medida que se repite la asignatura. 
--Para saber cuál sería el precio de las distintas asignaturas en las repeticiones (y así animar a nuestros alumnos a que estudien) 
--se quiere mostrar un listado en donde esté el nombre de la asignatura, el precio básico, el precio de la primera repetición 
--(un 10 por ciento más que el coste básico),  el precio de la segunda repetición (un 30 por ciento más que el coste básico) y 
--el precio de la tercer repetición (un 60 por ciento más que el coste básico).
SELECT NOMBRE,COSTEBASICO +COSTEBASICO*0.10 AS PRECIO_PRIMERAREPETICION FROM ASIGNATURA;
SELECT NOMBRE,COSTEBASICO +COSTEBASICO*0.30 AS PRECIO_SEGUNDAREPETICION FROM ASIGNATURA;
SELECT NOMBRE,COSTEBASICO +COSTEBASICO*0.60 AS PRECIO_TERCERAREPETICION FROM ASIGNATURA;
--22. Mostrar todos los datos de las personas que tenemos en la base de datos que han nacido antes de la década de los 70.
SELECT * FROM PERSONA WHERE FECHA_NACIMIENTO < TO_DATE ('1970','YYYY');
--23. Mostrar el identificador de las personas que trabajan como profesor, sin que salgan valores repetidos.
SELECT DISTINCT IDTITULACION FROM TITULACION WHERE NOMBRE IS NOT NULL ;
--24 Mostrar el identificador de los alumnos que se encuentran matriculados en la asignatura con código 130122.
SELECT IDALUMNO FROM ALUMNO_ASIGNATURA WHERE IDASIGNATURA =130122;
--25 Mostrar los códigos de las asignaturas en las que se encuentra matriculado algún alumno, sin que salgan códigos repetidos.
SELECT DISTINCT IDASIGNATURA FROM ALUMNO_ASIGNATURA WHERE IDALUMNO IS NOT NULL;
--26 Mostrar el nombre de las asignaturas que tienen más de 4 créditos, y además, o se imparten en el primer cuatrimestre o son del primer curso.
SELECT NOMBRE FROM ASIGNATURA WHERE CREDITOS >4 AND CUATRIMESTRE =1 OR CURSO=1;
--27 Mostrar los distintos c�digos de las titulaciones en las que hay alguna asignatura en nuestra base de datos.
SELECT DISTINCT IDTITULACION FROM TITULACION ;
--28 Mostrar el dni de las personas cuyo apellido contiene la letra g en may�sculas o min�sculas.
SELECT DNI FROM PERSONA WHERE UPPER(APELLIDO) LIKE '%G' OR LOWER(APELLIDO) LIKE '%g%';
--29 Mostrar las personas varones que tenemos en la base de datos que han nacido con posterioridad a 1970 y que vivan en una ciudad que empieza por M.
SELECT * FROM PERSONA WHERE FECHA_NACIMIENTO > TO_DATE('1970','YYYY') AND CIUDAD LIKE 'M%';









