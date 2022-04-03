--1. Descuento medio aplicado en las facturas.
SELECT AVG(f.DTO)
FROM FACTURAS f;

--2. Descuento medio aplicado en las facturas sin considerar los valores nulos.
SELECT AVG(f.DTO)
FROM FACTURAS f
WHERE f.DTO IS NOT NULL;

--3. Descuento medio aplicado en las facturas considerando los valores nulos como cero.
SELECT AVG(NVL(f.DTO,0))
FROM FACTURAS f;

--4. Número de facturas.
SELECT COUNT(f.CODFAC)
FROM FACTURAS f;

--5. Número de pueblos de la Comunidad de Valencia.
SELECT COUNT(p.CODPUE)
FROM PUEBLOS p 
WHERE p.CODPRO IN (03,12,46);

--6.Importe total de los artículos que tenemos en el almacén. 
--Este importe se calcula sumando el producto de las unidades en stock por el precio de cada unidad
SELECT SUM(a.STOCK * a.PRECIO) AS IMPORTE_TOTAL
FROM ARTICULOS a;

--7. Número de pueblos en los que residen clientes cuyo código postal empieza por ‘12’.
SELECT COUNT(c.CODPUE)
FROM CLIENTES c
WHERE c.CODPOSTAL LIKE '12%';

--8. Valores máximo y mínimo del stock de los artículos cuyo precio oscila entre 9 y 12 € y diferencia entre ambos valores
SELECT MAX(a.STOCK), MIN(a.STOCK), MAX(a.STOCK) - MIN(a.STOCK) AS DIFERENCIA
FROM ARTICULOS a 
WHERE a.PRECIO BETWEEN 9 AND 12;

--9. Precio medio de los artículos cuyo stock supera las 10 unidades.
SELECT AVG(a.PRECIO)
FROM ARTICULOS a 
WHERE a.STOCK > 10;

--10. Fecha de la primera y la última factura del cliente con código 210.
SELECT MAX(f.FECHA), MIN(f.FECHA) 
FROM FACTURAS f
WHERE f.CODCLI = 210;

--11. Número de artículos cuyo stock es nulo.
SELECT COUNT(a.CODART)
FROM ARTICULOS a 
WHERE a.STOCK IS NULL;

--12. Número de líneas cuyo descuento es nulo (con un decimal)
SELECT ROUND(COUNT(f.DTO),0)
FROM FACTURAS f 
WHERE f.DTO IS NULL;

--13. Obtener cuántas facturas tiene cada cliente.
SELECT COUNT(f.CODFAC), f.CODCLI 
FROM FACTURAS f
GROUP BY f.CODCLI;

--14. Obtener cuántas facturas tiene cada cliente, pero sólo si tiene dos o más facturas.
SELECT COUNT(f.CODFAC), f.CODCLI 
FROM FACTURAS f
GROUP BY f.CODCLI
HAVING COUNT(f.CODFAC) >= 2;

--15. Importe de la facturación (suma del producto de la cantidad por el precio de las líneas de factura) de los artículos.
SELECT SUM(lf.CANT * lf.PRECIO)
FROM LINEAS_FAC lf;

--16. Importe de la facturación (suma del producto de la cantidad por el precio de las líneas de factura)
--de aquellos artículos cuyo código contiene la letra “A” (bien mayúscula o minúscula).
SELECT SUM(lf.CANT * lf.PRECIO)
FROM LINEAS_FAC lf
WHERE lf.CODART LIKE '%A%'
OR lf.CODART LIKE '%a%';

--17. Número de facturas para cada fecha, junto con la fecha
SELECT f.FECHA, COUNT(f.CODFAC)
FROM FACTURAS f
GROUP BY f.FECHA;

--18. Obtener el número de clientes del pueblo junto con el nombre del pueblo mostrando primero los pueblos que más clientes tengan.
SELECT COUNT(c.CODCLI), p.NOMBRE 
FROM PUEBLOS p, CLIENTES c
WHERE p.CODPUE = c.CODPUE
GROUP BY p.NOMBRE
ORDER BY COUNT(c.CODCLI) DESC;

--19. Obtener el número de clientes del pueblo junto con el nombre del pueblo mostrando 
--primero los pueblos que más clientes tengan, siempre y cuando tengan más de dos clientes.
SELECT COUNT(c.CODCLI), p.NOMBRE 
FROM PUEBLOS p, CLIENTES c
WHERE p.CODPUE = c.CODPUE
GROUP BY p.NOMBRE
HAVING COUNT(c.CODCLI) > 2
ORDER BY COUNT(c.CODCLI) DESC;

--20. Cantidades totales vendidas para cada artículo cuyo código empieza por “P", mostrando también la descripción de dicho artículo
SELECT COUNT(a.CODART), a.DESCRIP 
FROM ARTICULOS a
WHERE a.CODART LIKE 'P%'
GROUP BY a.DESCRIP;

--21. Precio máximo y precio mínimo de venta (en líneas de facturas) para cada artículo cuyo código empieza por “c”.
SELECT MAX(lf.PRECIO), MIN(lf.PRECIO) 
FROM LINEAS_FAC lf 
WHERE lf.CODART LIKE 'c%';

--22. Igual que el anterior pero mostrando también la diferencia entre el precio máximo y mínimo.
SELECT MAX(lf.PRECIO), MIN(lf.PRECIO), MAX(lf.PRECIO) - MIN(lf.PRECIO) AS DIFERENCIA
FROM LINEAS_FAC lf 
WHERE lf.CODART LIKE 'c%';

--23. Nombre de aquellos artículos de los que se ha facturado más de 10000 euros.
SELECT a.DESCRIP 
FROM LINEAS_FAC lf, ARTICULOS a 
WHERE lf.CODART = a.CODART AND lf.PRECIO > 10000;

--24. Número de facturas de cada uno de los clientes cuyo código está entre 150 y 300 (se debe mostrar este código), con cada IVA distinto que se les ha aplicado.
SELECT DISTINCT f.IVA, COUNT(f.CODFAC)
FROM FACTURAS f 
WHERE f.CODCLI BETWEEN 150 AND 300
GROUP BY f.IVA;

--25. Media del importe de las facturas, sin tener en cuenta impuestos ni descuentos.
SELECT AVG(lf.PRECIO)
FROM LINEAS_FAC lf; 


