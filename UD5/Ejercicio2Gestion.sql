--1.	Mostrar el nombre de los clientes junto al nombre de su pueblo.
SELECT DISTINCT C.NOMBRE,A.DESCRIP  
FROM CLIENTES C,ARTICULOS A,FACTURAS F, LINEAS_FAC L
WHERE C.CODCLI=F.CODCLI 
AND F.CODFAC=L.CODFAC 
AND L.CODART=A.CODART;
--2.	Mostrar el nombre de los pueblos junto con el nombre de la provincia correspondiente.
SELECT DISTINCT PU.NOMBRE,PRO.NOMBRE 
FROM PUEBLOS PU ,PROVINCIAS PRO 
WHERE PRO.CODPRO=PU.CODPRO;
--3.	Mostrar el nombre de los clientes junto al nombre de su pueblo y el de su provincia.
SELECT DISTINCT C.NOMBRE,PU.NOMBRE,PRO.NOMBRE 
FROM CLIENTES C , PUEBLOS PU,PROVINCIAS PRO 
WHERE PRO.CODPRO=PU.CODPRO 
AND PU.CODPUE=C.CODPUE;
--4.	Nombre de las provincias donde residen clientes sin que salgan valores repetidos.
SELECT DISTINCT PRO.NOMBRE 
FROM CLIENTES C , PUEBLOS PU,PROVINCIAS PRO
WHERE PRO.CODPRO=PU.CODPRO 
AND PU.CODPUE=C.CODPUE;
--5.	Mostrar la descripción de los artículos que se han vendido en una cantidad superior a 10 unidades. 
--Si un artículo se ha vendido más de una vez en una cantidad superior a 10 sólo debe salir una vez.
SELECT DISTINCT A.DESCRIP
FROM ARTICULOS A ,LINEAS_FAC L  
WHERE A.CODART=L.CODART 
AND L.CANT>10;
--6.	Mostrar la fecha de factura junto con el código del artículo y la cantidad vendida por cada artículo 
--vendido en alguna factura. Los datos deben salir ordenado por fecha, primero las más reciente,
-- luego por el código del artículos, y si el mismo artículo se ha vendido varias veces en la misma fecha los más vendidos primero.
SELECT DISTINCT F.FECHA ,A.CODART,L.CANT 
FROM ARTICULOS A,LINEAS_FAC L,FACTURAS F 
WHERE A.CODART=L.CODART 
AND L.CODFAC=F.CODFAC
ORDER BY F.FECHA DESC,A.CODART,L.CANT ASC;
--7.	Mostrar el código de factura y la fecha de las mismas de las facturas que se han facturado a un cliente que tenga en su código postal un 7.
SELECT F.CODFAC,F.FECHA FROM FACTURAS F , CLIENTES C
WHERE F.CODCLI=C.CODCLI
AND  CODPOSTAL LIKE('%7%');
--8.	Mostrar el código de factura, la fecha y el nombre del cliente de todas las facturas existentes en la base de datos.
SELECT DISTINCT  F.CODFAC,F.FECHA,C.NOMBRE 
FROM FACTURAS F ,CLIENTES C 
WHERE F.CODCLI=C.CODCLI;
--9.	Mostrar un listado con el código de la factura, la fecha, el iva, el dto y el nombre del cliente
-- para aquellas facturas que o bien no se le ha cobrado iva (no se ha cobrado iva si el iva es nulo o cero), o bien el descuento es nulo.
SELECT DISTINCT F.CODFAC,F.FECHA,F.IVA,F.DTO,C.NOMBRE
FROM FACTURAS F, CLIENTES C WHERE F.CODCLI=C.CODCLI 
AND  (IVA IS NULL OR IVA=0) OR DTO IS NULL;
--10.	Se quiere saber que artículos se han vendido más baratos que el precio que actualmente tenemos almacenados en la tabla de artículos, 
--para ello se necesita mostrar la descripción de los artículos junto con el precio actual. 
--Además deberá aparecer el precio en que se vendió si este precio es inferior al precio original.
SELECT DISTINCT A.DESCRIP ,A.PRECIO,L.PRECIO,L.PRECIO
FROM ARTICULOS A,LINEAS_FAC L 
WHERE L.CODART=A.CODART
AND L.PRECIO<A.PRECIO;
--11.	Mostrar el código de las facturas, junto a la fecha, iva y descuento. 
--También debe aparecer la descripción de los artículos vendido junto al precio de venta, la cantidad y el descuento de ese artículo,
-- para todos los artículos que se han vendido.
SELECT DISTINCT F.CODFAC,F.FECHA,F.IVA,F.DTO,A.DESCRIP,L.PRECIO,L.CANT,L.DTO
FROM FACTURAS F ,LINEAS_FAC L , ARTICULOS A 
WHERE F.CODFAC=L.CODFAC
AND L.CODART=A.CODART;
--12.	Igual que el anterior, pero mostrando también el nombre del cliente al que se le ha vendido el artículo.
SELECT F.CODFAC,F.FECHA,F.IVA,F.DTO,A.DESCRIP,L.PRECIO,L.CANT,L.DTO,C.NOMBRE
FROM FACTURAS F ,LINEAS_FAC L , ARTICULOS A ,CLIENTES C
WHERE C.CODCLI=F.CODCLI
AND F.CODFAC=L.CODFAC
AND L.CODART=A.CODART;
--13.	Mostrar los nombres de los clientes que viven en una provincia que contenga la letra ma.
SELECT C.NOMBRE 
FROM CLIENTES C,PUEBLOS PU,PROVINCIAS PRO 
WHERE C.CODPUE=PU.CODPUE
AND PU.CODPRO=PRO.CODPRO
AND UPPER(PRO.NOMBRE) LIKE ('%MA%');
--14.	Mostrar el código del cliente al que se le ha vendido un artículo que tienen un stock menor al stock mínimo.
SELECT F.CODCLI 
FROM FACTURAS F,LINEAS_FAC L,ARTICULOS A 
WHERE  F.CODFAC=L.CODFAC
AND L.CODART=A.CODART
AND L.CANT>0
AND A.STOCK<A.STOCK_MIN;
--NO SALE NADA 
--15.	Mostrar el nombre de todos los artículos que se han vendido alguna vez. (no deben salir valores repetidos)
SELECT DISTINCT A.DESCRIP
FROM ARTICULOS A,LINEAS_FAC L
WHERE A.CODART=L.CODART
AND L.CANT>1;
--16.	Se quiere saber el precio real al que se ha vendido cada vez los artículos. Para ello es necesario mostrar el nombre del artículo,
-- junto con el precio de venta (no el que está almacenado en la tabla de artículos) menos el descuento aplicado en la línea de descuento.
SELECT DISTINCT A.DESCRIP,L.PRECIO-A.PRECIO
FROM ARTICULOS A ,LINEAS_FAC L
WHERE L.CODART=A.CODART;
--17.	Mostrar el nombre de los artículos que se han vendido a clientes que vivan en una provincia cuyo nombre termina  por a.
SELECT DISTINCT A.DESCRIP
FROM ARTICULOS A,LINEAS_FAC L,FACTURAS F, CLIENTES C ,PUEBLOS PU,PROVINCIAS PRO 
WHERE A.CODART=L.CODART
AND L.CODFAC=F.CODFAC
AND F.CODCLI=C.CODCLI
AND C.CODPUE=PU.CODPUE
AND PU.CODPRO=PRO.CODPRO
AND UPPER(PRO.NOMBRE) LIKE('%A');
--18.	Mostrar el nombre de los clientes sin que salgan repetidos a los que se les ha hecho un descuento superior al 10% en alguna de sus facturas.
SELECT DISTINCT  C.NOMBRE FROM CLIENTES C , FACTURAS F WHERE C.CODCLI=F.CODCLI AND  F.DTO>10; 
--19.	Mostrar el nombre de los clientes sin que salgan repetidos a los que se les ha hecho un descuento superior al 10% en alguna 
--de sus facturas o en alguna de las líneas que componen la factura o en ambas.
SELECT DISTINCT C.NOMBRE
FROM CLIENTES C,FACTURAS F,LINEAS_FAC L  
WHERE C.CODCLI=F.CODCLI 
AND F.CODFAC=L.CODFAC 
AND(F.DTO>10  OR L.DTO>10)
OR (F.DTO>10 AND L.DTO>10);
--20.	Mostrar la descripción, la cantidad y el precio de venta de los artículos vendidos al cliente con nombre MARIA MERCEDES
SELECT A.DESCRIP ,L.CANT,A.PRECIO FROM ARTICULOS A,LINEAS_FAC L,FACTURAS F,CLIENTES C
WHERE A.CODART=L.CODART 
AND L.CODFAC=F.CODFAC 
AND F.CODCLI=C.CODCLI 
AND UPPER(C.NOMBRE) LIKE ('%MARIA MERCEDES%');