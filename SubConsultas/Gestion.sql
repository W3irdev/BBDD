--1. Número de clientes que tienen alguna factura con IVA 16%.
SELECT COUNT(C.CODCLI)
FROM CLIENTES c ,FACTURAS f2 
WHERE C.CODCLI = F2.CODCLI 
AND F2.IVA IN (SELECT IVA 
FROM FACTURAS f
WHERE F.IVA=16);
--2. Número de clientes que no tienen ninguna factura con un 16% de IVA.
SELECT COUNT(C.CODCLI)
FROM CLIENTES c ,FACTURAS f2 
WHERE C.CODCLI = F2.CODCLI 
AND F2.IVA NOT IN (SELECT IVA 
FROM FACTURAS f
WHERE F.IVA=16);
--3. Número de clientes que en todas sus facturas tienen un 16% de IVA (los clientes deben tener al menos una factura).
SELECT COUNT(C.CODCLI)
FROM CLIENTES c ,FACTURAS f2 
WHERE C.CODCLI = F2.CODCLI 
AND F2.IVA = ALL (SELECT IVA 
FROM FACTURAS f
WHERE F.IVA=16);
--4. Fecha de la factura con mayor importe (sin tener en cuenta descuentos ni impuestos).
SELECT F2.FECHA 
FROM FACTURAS f2,LINEAS_FAC lf2 
WHERE LF2.CODFAC =F2.CODFAC 
AND LF2.PRECIO =(SELECT MAX(LF.PRECIO)
FROM FACTURAS f ,LINEAS_FAC lf 
WHERE F.CODFAC = LF.CODFAC);
--5. Número de pueblos en los que no tenemos clientes.
SELECT COUNT(C2.CODPUE)
FROM CLIENTES c2 
WHERE C2.CODPUE =
(SELECT COUNT(C.CODCLI)
FROM CLIENTES c 
WHERE C.CODPUE IS NULL);
--6. Número de artículos cuyo stock supera las 20 unidades, con precio superior a 15 euros y de los que no hay ninguna factura en el último trimestre del año pasado.

SELECT COUNT(A.DESCRIP) 
FROM ARTICULOS a, LINEAS_FAC lf 
WHERE A.CODART =LF.CODART
AND A.STOCK>20
AND A.PRECIO>15
AND LF.CODFAC NOT IN (SELECT F2.CODFAC  
						FROM FACTURAS f2
						WHERE EXTRACT(MONTH FROM F2.FECHA) BETWEEN 10 AND 12
						AND EXTRACT(YEAR FROM F2.FECHA)=EXTRACT(YEAR FROM SYSDATE)-1);

--7. Obtener el número de clientes que en todas las facturas del año pasado no han pagado IVA (no se ha pagado IVA si es cero o nulo).

SELECT COUNT(CODCLI)
FROM FACTURAS
WHERE CODFAC NOT IN (SELECT CODFAC
	 FROM FACTURAS
WHERE IVA IS NULL
OR IVA = 0)
AND EXTRACT (YEAR FROM FECHA)= EXTRACT (YEAR FROM SYSDATE)-1;

SELECT COUNT(F.CODCLI) CLIENTES
FROM FACTURAS f 
WHERE F.CODFAC IN (SELECT F2.CODFAC 
					FROM FACTURAS f2
					WHERE (F2.IVA=0 OR F2.IVA IS NULL)
					AND EXTRACT(YEAR FROM F2.FECHA)=EXTRACT(YEAR FROM SYSDATE)-1);

					
					
--8. Clientes (código y nombre) que fueron preferentes durante el mes de noviembre del año pasado y que en diciembre de ese mismo año 
--no tienen ninguna factura. Son clientes preferentes de un mes aquellos que han solicitado más de 60,50 euros en facturas durante ese mes, 
--sin tener en cuenta descuentos ni impuestos.




SELECT f.CODCLI , c.NOMBRE 
FROM LINEAS_FAC lf , FACTURAS f , CLIENTES c 
WHERE lf.CODFAC = f.CODFAC AND f.CODFAC = c.NOMBRE 
AND (lf.PRECIO * lf.CANT) > 60.5
AND EXTRACT (YEAR FROM f.FECHA) = EXTRACT (YEAR FROM sysdate )-1 
AND EXTRACT (MONTH FROM f.FECHA ) = 11
AND f.CODFAC NOT in
					(SELECT f.CODFAC 
					FROM LINEAS_FAC lf , FACTURAS f 
					WHERE lf.CODFAC = f.CODFAC 
					AND EXTRACT (YEAR FROM f.FECHA) = EXTRACT (YEAR FROM sysdate )-1 
					AND EXTRACT (MONTH FROM f.FECHA ) = 12);

--9. Código, descripción y precio de los diez artículos más caros.
SELECT *
FROM (SELECT a.CODART , a.DESCRIP, a.PRECIO
FROM ARTICULOS a
ORDER BY a.PRECIO DESC)
WHERE ROWNUM <=10;


--10. Nombre de la provincia con mayor número de clientes.
SELECT *
FROM (SELECT pc.NOMBRE, COUNT(c.CODCLI) 
FROM CLIENTES c , PUEBLOS p, PROVINCIAS pc
WHERE c.CODPUE = p.CODPUE
AND p.CODPRO = pc.CODPRO
GROUP BY pc.NOMBRE
ORDER BY COUNT(c.CODCLI) DESC) 
WHERE ROWNUM=1;
--11. Código y descripción de los artículos cuyo precio es mayor de 90,15 euros y se han vendido menos de 10 unidades (o ninguna) durante el año pasado.
SELECT ARTICULOS.CODART, ARTICULOS.DESCRIP
FROM ARTICULOS, LINEAS_FAC, FACTURAS
WHERE ARTICULOS.CODART = LINEAS_FAC.CODART 
AND LINEAS_FAC.CODFAC = FACTURAS.CODFAC
AND ARTICULOS.PRECIO > 90.15
AND EXTRACT(YEAR FROM FECHA) = (EXTRACT(YEAR FROM SYSDATE)-1)
AND ARTICULOS.CODART IN(SELECT CODART
FROM LINEAS_FAC
GROUP BY CODART
HAVING SUM(NVL(CANT,0)) < 10);

SELECT a.codart, a.descrip
FROM articulos a, lineas_fac lf, facturas f
WHERE a.codart = lf.codart
AND lf.codfac = f.codfac
AND a.precio > 90.15
AND a.codart IN (SELECT a.codart
				 FROM lineas_fac lf, facturas f, articulos a 
				 WHERE lf.codfac=f.codfac AND a.codart=lf.codart and (EXTRACT(YEAR FROM f.fecha))=EXTRACT(YEAR FROM sysdate)-1 
				 GROUP BY a.codart
				 HAVING sum(nvl(cant,0))<10);


--12. Código y descripción de los artículos cuyo precio es más de tres mil veces mayor que el precio mínimo de cualquier artículo.
SELECT A.CODART ,A.DESCRIP 
FROM ARTICULOS a 
WHERE A.PRECIO >= ANY (SELECT A2.PRECIO*3000 
						FROM ARTICULOS a2);

--13. Nombre del cliente con mayor facturación.
					
					
SELECT*FROM(SELECT C.NOMBRE, (LF.LINEA * LF.CANT )*LF.PRECIO AS FACTURACION 
			FROM LINEAS_FAC lf,FACTURAS f,CLIENTES c
			WHERE C.CODCLI =F.CODCLI AND F.CODFAC = LF.CODFAC )
WHERE ROWNUM=1;


--14. Código y descripción de aquellos artículos con un precio superior a la media y que hayan sido comprados por más de 5 clientes.
SELECT A2.CODART,A2.DESCRIP 
FROM LINEAS_FAC lf, ARTICULOS a2,FACTURAS f,CLIENTES c 
WHERE LF.CODART = A2.CODART AND LF.CODFAC = F.CODFAC 
AND C.CODCLI = F.CODCLI AND A2.PRECIO > (SELECT AVG(A.PRECIO)
FROM ARTICULOS a)
GROUP BY A2.CODART,A2.DESCRIP
HAVING COUNT(C.CODCLI) > 5;

SELECT a.CODART, a.DESCRIP
FROM ARTICULOS a
WHERE a.PRECIO > (SELECT AVG(nvl(lf.precio,0)) FROM LINEAS_FAC lf)
AND a.CODART IN 
               (SELECT lf.CODARt
               FROM LINEAS_FAC lf, FACTURAS f
               WHERE f.codfac=lf.codfac
               GROUP BY lf.CODART
               HAVING COUNT(DISTINCT f.CODCLI)>5);