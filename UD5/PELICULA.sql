--1. Obtener las diferentes nacionalidades de películas que existen en la base de
--datos
SELECT DISTINCT NACIONALIDAD
FROM PELICULA;
--2. Mostrar el código de la película, la fecha de estreno y la recaudación de las
--películas ordenadas por su recaudación de mayor a menor estrenadas antes del 22
--de septiembre de 1997.
SELECT DISTINCT CIP,FECHA_ESTRENO,RECAUDACION
FROM PROYECCION
WHERE FECHA_ESTRENO < TO_DATE('22/09/1997','DD/MM/YYYY')
ORDER BY RECAUDACION DESC;
--3. Mostrar el código de las películas, la recaudación y el número de espectadores
--cuyo número de espectadores sea mayor que 3000 o cuya recaudación sea mayor o
--igual que 2000000, ordenadas de mayor a menor número de espectadores.
SELECT CIP,RECAUDACION,ESPECTADORES
FROM PROYECCION 
WHERE ESPECTADORES>3000
AND RECAUDACION >=2000000
ORDER BY ESPECTADORES DESC;
--4. Obtener el nombre de los cines que contengan la cadena "ar" en mayúsculas o
--minúsculas en su dirección.
SELECT CINE
FROM CINE 
WHERE UPPER(CINE) LIKE'%AR%';
--5. Mostrar los cines y su aforo total cuyo aforo total sea mayor que 600 ordenados
--por su aforo total de forma descendente.
SELECT CINE,COUNT(AFORO)
FROM SALA 
GROUP BY CINE,AFORO
HAVING SUM(AFORO)>600
ORDER BY AFORO  ASC;
--6. Obtener el título de las películas estrenadas en la primera quincena de cualquier
--mes.
SELECT DISTINCT TITULO_P 
FROM PELICULA P,PROYECCION PR
WHERE EXTRACT(DAY FROM PR.FECHA_ESTRENO) >0 
AND EXTRACT(DAY FROM PR.FECHA_ESTRENO)<15;

--7. Muestra la nacionalidad de las películas junto con la media del presupuesto por
--cada nacionalidad teniendo en cuenta los valores nulos y teniendo en cuenta sólo
--aquellas películas cuyo presupuesto es mayor que 500;
SELECT NACIONALIDAD , AVG(NVL(PRESUPUESTO,0)) AS MEDIAPRESUPUESTO
FROM PELICULA
WHERE PRESUPUESTO>500
GROUP BY NACIONALIDAD;
--8. Obtener el nombre y el sexo de todos los personajes cuyo nombre termine en 'n',
--'s' o 'e' y no tengan sexo asignado.
SELECT DISTINCT NOMBRE_PERSONA,SEXO_PERSONA 
FROM PERSONAJE
WHERE (UPPER(NOMBRE_PERSONA) LIKE '%N'
OR UPPER(NOMBRE_PERSONA) LIKE '%S'
OR UPPER(NOMBRE_PERSONA) LIKE '%E')
AND SEXO_PERSONA IS  NULL;
--9. Mostrar el nombre de las películas que el número total de días que se han
--estrenado sea mayor de 50.
SELECT P.TITULO_P,COUNT(PR.DIAS_ESTRENO)
FROM PELICULA P ,PROYECCION PR
WHERE P.CIP=PR.CIP
GROUP BY P.TITULO_P,PR.DIAS_ESTRENO
HAVING SUM(PR.DIAS_ESTRENO)>50;

--10. Mostrar el nombre del cine, junto con su dirección y la ciudad en la que está,
--junto con la sala y el aforo de la sala, y el nombre 
--de las películas que se han proyectado en esa sala.Los datos deben salir ordenados 
--por el nombre del cine, la sala del cine y por último el nombre 
--de la película (puedes usar el nombre en versión original o en español como quieras).
SELECT DISTINCT  C.CINE,C.DIRECCION_CINE,C.CIUDAD_CINE,S.SALA,S.AFORO,TITULO_P
FROM CINE C , SALA S , PROYECCION PR,PELICULA P
WHERE C.CINE=S.CINE
AND S.CINE=PR.CINE
AND PR.CIP=P.CIP
ORDER BY C.CINE DESC,S.SALA,TITULO_P;

--11. Realizar una consulta que muestre por cada uno de los posibles trabajos(tareas)
--que se pueden realizar en nuestra base de datos, el número de personas que han
--realizado dicho trabajo.
--Ten en cuenta que si una persona ha realizado dos veces el mismo trabajo sólo
--deberá salir una vez.
SELECT DISTINCT COUNT(CIP),TAREA
FROM TRABAJO
GROUP BY TAREA;
--12. Mostrar todos los datos de las películas estrenadas entre el 20 de septiembre de
--1995 y el 15 de diciembre de 1995. Si la película se ha estrenado dos o más veces
--en esas fechas sólo debe salir una vez.
SELECT DISTINCT  * FROM PELICULA P ,PROYECCION PR
WHERE PR.CIP=P.CIP
AND PR.FECHA_ESTRENO BETWEEN TO_DATE('20/09/1995','DD/MM/YYYY') 
AND TO_DATE('15/12/1995','DD/MM/YYYY');

--13. Mostrar el nombre de los cines y la ciudad en la que se han proyectado 22 o
--más películas distintas en todas sus salas.
SELECT DISTINCT C.CINE,C.CIUDAD_CINE
FROM PROYECCION PR ,CINE C,SALA S
WHERE C.CINE=S.CINE
AND S.CINE=PR.CINE
GROUP BY C.CINE,C.CIUDAD_CINE
HAVING COUNT(PR.SALA)>=22;
--14. Obtener el nombre de la película y el presupuesto de todas las películas
--americanas estrenadas en un cine de Córdoba, sabiendo que Córdoba está escrito
--sin tilde en la base de datos y puede estar en mayúsculas o minúsculas.
SELECT DISTINCT TITULO_P ,PRESUPUESTO
FROM PELICULA P ,PROYECCION PR,SALA S , CINE C
WHERE P.CIP=PR.CIP
AND PR.CINE=S.CINE
AND S.CINE=C.CINE
AND UPPER(P.NACIONALIDAD) ='EE.UU'
AND UPPER(C.CIUDAD_CINE)='CORDOBA';
--15. Obtener el título y la recaudación total obtenida por películas que contengan en
--su TITULO_P la cadena 'vi' en minúsculas o el número 7.
SELECT P.TITULO_P,COUNT(PR.RECAUDACION)
FROM PELICULA P,PROYECCION PR
WHERE P.CIP=PR.CIP
AND LOWER(P.TITULO_P) LIKE '%vi%'
OR P.TITULO_P LIKE'%7'
GROUP BY PR.RECAUDACION,P.TITULO_P;

--16. Obtener el presupuesto máximo y el presupuesto mínimo para las películas.
--Deberás utilizar los alias necesarios.
SELECT MAX(PRESUPUESTO),MIN(PRESUPUESTO)
FROM PELICULA;

--17. Explica en qué consiste el OUTER JOIN e indica un ejemplo justificándolo e
--incluyendo la sentencia correspondiente.
--CONSISTE EN LA SEPARACIÓN DE 2 TABLAS , LO CONTRARIO AL EQUIJOIN, SE PONE UN(+) EN 
--LA TABLA DONDE TENGA VALORES NULOS
--SELECT NOMBRE_PERSONA,CINE
--FROM PERSONAJE,CINE
--WHERE NOMBRE_PERSONA(+)=CINE;

--18. Se desea obtener un listado de todas las proyecciones, adicionalmente deberá
--aparecer en el listado otra columna que se llame fecha_estimada y cuyos valores a
--mostrar sean la fecha de estreno con un incremento de 2 meses.
SELECT CINE , FECHA_ESTRENO AS FECHA_ESTIMADA
FROM PROYECCION
WHERE EXTRACT(MONTH FROM FECHA_ESTRENO);
--19. Mostrar todos los datos de películas junto con los datos de sus proyecciones. En
--este listado deben aparecer tanto las películas que tienes proyecciones como las
--que no tienen proyección.
SELECT DISTINCT * FROM PELICULA,PROYECCION;
--20. Muestra el número de personajes que trabajan por cada película junto a su título
--principal ordenados por nombre de película (titulo_p) de forma ascendente.
SELECT DISTINCT COUNT(TR.NOMBRE_PERSONA), P.TITULO_P
FROM TRABAJO TR, PELICULA P
WHERE TR.CIP=P.CIP
GROUP BY TR.NOMBRE_PERSONA,P.TITULO_P
ORDER BY P.TITULO_P DESC;




