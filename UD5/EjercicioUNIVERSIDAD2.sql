--1.Para cada titulación ordenar por coste mostrando primero las asignaturas más caras y para las asignaturas del mismo coste 
--mostrar por orden alfabético de nombre de asignatura. 
SELECT DISTINCT * FROM ASIGNATURA  ORDER BY COSTEBASICO DESC ,NOMBRE ASC;
--2.Mostrar el nombre y los apellidos de los profesores. 
SELECT PER.NOMBRE,PER.APELLIDO FROM PERSONA PER,PROFESOR PRO WHERE PER.DNI=PRO.DNI;
--3.Mostrar el nombre de las asignaturas impartidas por profesores de Sevilla.
SELECT DISTINCT A.NOMBRE FROM ASIGNATURA A,PROFESOR PRO,PERSONA PER WHERE UPPER(CIUDAD)='SEVILLA';
--4.Mostrar el nombre y los apellidos de los alumnos.
SELECT DISTINCT PER.NOMBRE,PER.APELLIDO FROM PERSONA PER ,ALUMNO A;
--5.Mostrar el DNI, nombre y apellidos de los alumnos que viven en Sevilla.
SELECT DISTINCT PER.DNI,PER.NOMBRE,PER.APELLIDO FROM PERSONA PER, ALUMNO A WHERE UPPER(CIUDAD)='SEVILLA';
--6.Mostrar el DNI, nombre y apellidos de los alumnos matriculados en la asignatura "Seguridad Vial".
SELECT DISTINCT PER.DNI,PER.NOMBRE,PER.APELLIDO FROM PERSONA PER,ALUMNO A,ASIGNATURA AA,ALUMNO_ASIGNATURA ASIG 
WHERE ASIG.IDASIGNATURA =AA.IDASIGNATURA AND A.IDALUMNO =ASIG.IDALUMNO AND PER.DNI=A.DNI
AND UPPER(AA.NOMBRE)='SEGURIDAD VIAL';
--7.Mostrar el Id de las titulaciones en las que está matriculado el alumno con DNI 20202020A. Un alumno está matriculado en una titulación
-- si está matriculado en una asignatura de la titulación.
SELECT DISTINCT TI.IDTITULACION FROM TITULACION TI,ASIGNATURA AA,ALUMNO_ASIGNATURA ASIG,ALUMNO A 
WHERE TI.IDTITULACION=AA.IDTITULACION AND AA.IDASIGNATURA=ASIG.IDASIGNATURA  AND ASIG.IDALUMNO=A.IDALUMNO AND UPPER(A.DNI)='20202020A';
--8.Obtener el nombre de las asignaturas en las que está matriculada Rosa Garcia.
SELECT DISTINCT AA.NOMBRE FROM ASIGNATURA AA,ALUMNO_ASIGNATURA ASIG,ALUMNO A ,PERSONA P
WHERE ASIG.IDASIGNATURA=AA.IDASIGNATURA AND A.IDALUMNO=ASIG.IDALUMNO AND P.DNI=A.DNI AND  UPPER(P.NOMBRE)='ROSA';
--9.Obtener el DNI de los alumnos a los que le imparte clase el profesor Jorge Saenz. 
SELECT A.DNI FROM ALUMNO A, PERSONA P WHERE UPPER(P.NOMBRE)='JORGE';

--10.Obtener el DNI, nombre y apellido de los alumnos a los que imparte clase el profesor Jorge Sáenz. 
SELECT P.DNI,P.NOMBRE,P.APELLIDO FROM PERSONA P,PROFESOR PRO,ASIGNATURA A WHERE P.DNI=PRO.DNI AND PRO.IDPROFESOR=A.IDPROFESOR AND UPPER(P.NOMBRE)='JORGE';
--11.Mostrar el nombre de las titulaciones que tengan al menos una asignatura de 4 créditos. 
SELECT DISTINCT TI.NOMBRE FROM TITULACION TI,ASIGNATURA AA WHERE CREDITOS>=4;
--12.Mostrar el nombre y los créditos de las asignaturas del primer cuatrimestre junto con el nombre de la titulación a la que pertenecen. 
SELECT DISTINCT AA.NOMBRE,AA.CREDITOS,TI.NOMBRE FROM ASIGNATURA AA,TITULACION TI WHERE CUATRIMESTRE=1; 
--13.Mostrar el nombre y el coste básico de las asignaturas de más de 4,5 créditos junto con el nombre de las personas matriculadas
SELECT DISTINCT AA.NOMBRE,AA.CREDITOS,P.NOMBRE FROM ASIGNATURA AA,PERSONA P WHERE CREDITOS>4.5;
--14.Mostrar el nombre de los profesores que imparten asignaturas con coste entre 25 y 35 euros, ambos incluidos
SELECT DISTINCT P.NOMBRE FROM PERSONA P,ASIGNATURA AA,PROFESOR PRO WHERE P.DNI=PRO.DNI AND COSTEBASICO>=25 AND COSTEBASICO<=35;
--15.Mostrar el nombre de los alumnos matriculados en la asignatura '150212' ó en la '130113' ó en ambas.
SELECT DISTINCT P.NOMBRE FROM PERSONA P,ALUMNO_ASIGNATURA ASIG,ALUMNO AA 
WHERE ASIG.IDALUMNO=AA.IDALUMNO AND AA.DNI=P.DNI AND IDASIGNATURA='150212' OR IDASIGNATURA='130113' OR IDASIGNATURA='150212' AND IDASIGNATURA='130113';
--16.Mostrar el nombre de las asignaturas del 2º cuatrimestre que no sean de 6 créditos, junto con el nombre de la titulación a la que pertenece.
SELECT DISTINCT AA.NOMBRE,TI.NOMBRE FROM ASIGNATURA AA,TITULACION TI WHERE CUATRIMESTRE=2 AND CREDITOS!=6 ;
--17.Mostrar el nombre y el número de horas de todas las asignaturas. (1cred.=10 horas) junto con el dni de los alumnos que están matriculados.
SELECT DISTINCT  AA.NOMBRE,AA.CREDITOS *10 AS NUM_HORAS,A.DNI FROM ASIGNATURA AA,ALUMNO A,ALUMNO_ASIGNATURA ASIG WHERE A.IDALUMNO=ASIG.IDALUMNO;
--18.Mostrar el nombre de todas las mujeres que viven en “Sevilla” y que estén matriculados de alguna asignatura
SELECT DISTINCT P.NOMBRE FROM PERSONA P,ALUMNO A,ALUMNO_ASIGNATURA ASIG WHERE P.DNI=A.DNI AND A.IDALUMNO=ASIG.IDALUMNO AND  UPPER(CIUDAD)='SEVILLA' AND ASIG.NUMEROMATRICULA IS NOT NULL;
--19.Mostrar el nombre de la asignatura de primero y que lo imparta el profesor con identificador p101.
SELECT DISTINCT AA.NOMBRE FROM ASIGNATURA AA,PROFESOR PRO WHERE AA.IDPROFESOR=PRO.IDPROFESOR AND AA.CURSO=1 AND UPPER(PRO.IDPROFESOR)='P101';
--20.Mostrar el nombre de los alumnos que se ha matriculado tres o más veces en alguna asignatura.
SELECT DISTINCT P.NOMBRE FROM PERSONA P,ALUMNO_ASIGNATURA ASIG,ALUMNO AA WHERE ASIG.IDALUMNO=AA.IDALUMNO AND AA.DNI=P.DNI AND ASIG.NUMEROMATRICULA>=3;