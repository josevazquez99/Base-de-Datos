--1.	C?digo, fecha y doble del descuento de las facturas con iva cero.
SELECT CODFAC,FECHA,NVL((DTO*2),0),IVA FROM FACTURAS WHERE IVA=0;
--2.	C?digo de las facturas con iva nulo.
SELECT CODFAC,IVA FROMFACTURAS WHERE IVA IS NULL;
--3.	C?digo y fecha de las facturas sin iva (iva cero o nulo).
SELECT CODFAC,FECHA FROM FACTURAS WHERE IVA=0 OR IVA IS NULL;
--4.	C?digo de factura y de art?culo de las l?neas de factura en las que la cantidad solicitada es menor de 5 unidades y adem?s se ha aplicado un descuento del 25% o mayor.
SELECT CODFAC,CODART FROM LINEAS_FAC WHERE CANT<5 AND DTO>=25;
--5.	Obtener la descripci?n de los art?culos cuyo stock est? por debajo del stock m?nimo, dado tambi?n la cantidad en unidades necesaria para alcanzar dicho m?nimo.
SELECT DESCRIP,STOCK_MIN-STOCK FROM ARTICULOS WHERE STOCK < STOCK_MIN ;
--6.	Ivas distintos aplicados a las facturas.
SELECT DISTINCT IVA FROM FACTURAS;
--7.	C?digo, descripci?n y stock m?nimo de los art?culos de los que se desconoce la cantidad de stock. Cuando se desconoce la cantidad de stock de un art?culo, el stock es nulo.
SELECT CODART , DESCRIP,STOCK_MIN FROM ARTICULOS WHERE STOCK IS NULL;
--8.	Obtener la descripci?n de los art?culos cuyo stock es m?s de tres veces su stock m?nimo y cuyo precio supera los 6 euros.
SELECT DESCRIP FROM ARTICULOS WHERE STOCK >3 * STOCK_MIN AND PRECIO>6;
--9.	C?digo de los art?culos (sin que salgan repetidos) comprados en aquellas facturas cuyo c?digo est? entre 8 y 10.
SELECT DISTINCT  CODART FROM LINEAS_FAC WHERE CODFAC BETWEEN 8 AND 10;
--10.	Mostrar el nombre y la direcci?n de todos los clientes.
SELECT NOMBRE,DIRECCION FROM CLIENTES;
--11.	Mostrar los distintos c?digos de pueblos en donde tenemos clientes
SELECT DISTINCT CODPUE FROM PUEBLOS;
--12.	Obtener los c?digos de los pueblos en donde hay clientes con c?digo de cliente menor que el c?digo 25. No deben salir c?digos repetidos.
SELECT DISTINCT CODPUE FROM CLIENTES WHERE CODCLI <25;
--13.	Nombre de las provincias cuya segunda letra es una 'O' (bien may?scula o min?scula).
SELECT DISTINCT NOMBRE
FROM PROVINCIAS 
WHERE UPPER(SUBSTR(NOMBRE,2,1))='O'
--14.	C?digo y fecha de las facturas del a?o pasado para aquellos clientes cuyo c?digo se encuentra entre 50 y 100.
SELECT CODFAC , FECHA FROM FACTURAS WHERE CODCLI BETWEEN 50 AND 100  AND  TO_NUMBER(TO_CHAR(FECHA,'YYYY'))=TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-1;
--15.	Nombre y direcci?n de aquellos clientes cuyo c?digo postal empieza por ?12?. 
SELECT NOMBRE,DIRECCION FROM CLIENTES WHERE CODPOSTAL LIKE('12%');
--16.	Mostrar las distintas fechas, sin que salgan repetidas, de las factura existentes de clientes cuyos c?digos son menores que 50.
SELECT DISTINCT FECHA FROM FACTURAS WHERE CODCLI<50;
--17.	C?digo y fecha de las facturas que se han realizado durante el mes de junio del a?o 2004
-DUDA
--18.	C?digo y fecha de las facturas que se han realizado durante el mes de junio del a?o 2004 para aquellos clientes cuyo c?digo se encuentra entre 100 y 250.
-DUDA
--19.	C?digo y fecha de las facturas para los clientes cuyos c?digos est?n entre 90 y 100 y no tienen iva. NOTA: una factura no tiene iva cuando ?ste es cero o nulo.
SELECT CODFAC,FECHA FROM FACTURAS WHERE (CODCLI BETWEEN 90 AND 100) AND IVA IS NULL OR IVA=0;
--20.	Nombre de las provincias que terminan con la letra 's' (bien may?scula o min?scula).
SELECT NOMBRE FROM PROVINCIAS WHERE UPPER(NOMBRE) LIKE('%S') OR LOWER(NOMBRE) LIKE ('%S');
--21.	Nombre de los clientes cuyo c?digo postal empieza por ?02?, ?11? ? ?21?.
SELECT NOMBRE FROM CLIENTES WHERE CODPOSTAL LIKE('02%') OR CODPOSTAL LIKE('11%') OR CODPOSTAL  LIKE('21%');
--22.	Art?culos (todas las columnas) cuyo stock sea mayor que el stock m?nimo  y no haya en stock m?s de 5 unidades del stock_min.
SELECT * FROM ARTICULOS WHERE STOCK>STOCK_MIN AND (STOCK-STOCK_MIN)<5;
--23.	Nombre de las provincias que contienen el texto ?MA? (bien may?sculas o min?sculas).
SELECT NOMBRE FROM PROVINCIAS WHERE UPPER(NOMBRE) LIKE('%MA%') OR LOWER(NOMBRE) LIKE('%MA%') ;
--24.	Se desea promocionar los art?culos de los que se posee un stock grande. Si el art?culo es de m?s de 6000 ? y el stock supera los 60000 ?, se har? un descuento del 10%. Mostrar un listado de los art?culos que van a entrar en la promoci?n, con su c?digo de art?culo, nombre del articulo, precio actual y su precio en la promoci?n.
--DUDA PRECIO PROMOCION
SELECT L.CODART ,A.DESCRIP,A.PRECIO FROM ARTICULOS A ,LINEAS_FAC L WHERE A.PRECIO>6000 AND A.STOCK>6000 AND L.DTO =10 ;