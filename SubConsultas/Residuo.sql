/*1. Teniendo en cuenta los residuos generados por todas las empresas,
 *  mostrar el código del residuo que más
se ha generado por todas ellas.*/

SELECT *
FROM (SELECT COD_RESIDUO 
		FROM RESIDUO_EMPRESA re  
		ORDER BY CANTIDAD DESC) 
WHERE rownum=1;

/*2. Mostrar el nombre dela empresa transportista que sólo trabajó para la empresa con nif R-12356711-Q
*/

SELECT e2.NOMBRE_EMPTRANSPORTE 
FROM EMPRESATRANSPORTISTA e2 
WHERE e2.NIF_EMPTRANSPORTE IN (SELECT t.NIF_EMPRESA 
FROM TRASLADO t 
WHERE t.NIF_EMPRESA LIKE 'R-12356711-Q');
							
				
/*3 Mostrar el nombre de la empresa transportitas que realizó el primer transporte que está registrado en la base de datos.*/
	
		
SELECT e.NOMBRE_EMPTRANSPORTE 
FROM EMPRESATRANSPORTISTA e 
WHERE NIF_EMPTRANSPORTE = (SELECT *
						FROM (SELECT t.NIF_EMPTRANSPORTE
						FROM TRASLADO t 
						ORDER BY t.FECHA_ENVIO ASC)
						WHERE rownum=1
						);					

/*4 Mostrar todas las características de los traslados, para aquellos traslados cuyo coste sea superior 
 a la media de todos los traslados.*/
					

SELECT *
FROM TRASLADO t 
WHERE t.COSTE > ALL (SELECT AVG(t.COSTE) 
FROM TRASLADO t);



/*5 Obtener el nombre de las ciudades más cercanas entre las que se ha realizado un envío*/

/*SELECT d.NOMBRE_DESTINO 
FROM DESTINO d 
WHERE d.COD_DESTINO = ANY (SELECT t.COD_DESTINO
FROM TRASLADO t
ORDER BY t.KMS);*/

SELECT * FROM(SELECT D.CIUDAD_DESTINO

FROM TRASLADO t,DESTINO d

WHERE T.COD_DESTINO = D.COD_DESTINO

ORDER BY T.KMS ASC)

WHERE ROWNUM <= 3;


/*6 Obtener el nombre de las empresas que nunca han utilizado el Ferrocarril como medio de transporte.*/


SELECT ep.NOMBRE_EMPRESA, ep.NIF_EMPRESA
FROM EMPRESAPRODUCTORA ep
WHERE ep.NIF_EMPRESA NOT IN (
    SELECT DISTINCT t.NIF_EMPRESA
    FROM TRASLADO t
    WHERE t.TIPO_TRANSPORTE = 'Ferrocarril'
);


/*7 Obtener el nombre de la empresa que ha realizado más envíos a Madrid.*/

SELECT e.NOMBRE_EMPRESA 
FROM EMPRESAPRODUCTORA e 
WHERE e.NIF_EMPRESA = (SELECT *
						FROM 
						(SELECT t.NIF_EMPRESA 
						FROM TRASLADO t , DESTINO d 
						WHERE t.COD_DESTINO = d.COD_DESTINO 
						AND d.CIUDAD_DESTINO LIKE 'Madrid'
						ORDER BY t.CANTIDAD DESC )
						WHERE rownum=1)
;


/*8 Vamos a crear una nueva tabla llamada envios, que tendrá un campo llamdo Ciudad_destino, otro
llamado ciudad_origen, y otro cantidad_total, en la que guardaremos donde van los residuos. 
La primary key de la tabla debe ser ciudad_destino y ciudad_origen, así podremos evitar que 
metan dos registros con la misma ciudad destino y origen.
Cargar dicha tabla con los registros oportunos según nuestra base de datos, teniendo en cuenta 
que en cantidad total se debe guardar el total de las cantidades que se ha enviado desde ciudad_origen a ciudad_destino
*/

CREATE TABLE envio(
CIUDAD_DESTINO varchar2(50),
CIUDAD_ORIGEN varchar2(20),
CANTIDAD_TOTAL number(12),
CONSTRAINT PK_ENVIO PRIMARY KEY (CIUDAD_DESTINO, CIUDAD_ORIGEN));


INSERT INTO envio 
 SELECT e.CIUDAD_EMPRESA, d.CIUDAD_DESTINO , sum(t.CANTIDAD) 
FROM DESTINO d , EMPRESAPRODUCTORA e , TRASLADO t 
WHERE d.COD_DESTINO = t.COD_DESTINO AND t.NIF_EMPRESA = e.NIF_EMPRESA 
GROUP BY e.CIUDAD_EMPRESA , d.CIUDAD_DESTINO ;

/*9 Vamos a modificar la tabla residuo para añadir un nuevo campo llamado num_constituyentes.
 Una vez hayas añadido el nuevo campo crea la sentencia sql necesaria para que este campo 
 tomen los valores adecuados.*/

ALTER TABLE RESIDUO ADD NUM_CONSTITUYENTES NUMBER(10);
UPDATE RESIDUO SET NUM_CONSTITUYENTES = (SELECT COUNT(COD_CONSTITUYENTE)
FROM CONSTITUYENTE c );


/*10 Modifica la tabla empresaproductora añadiendo un campo nuevo llamado nif, que es
el nif de la empresa matriz, es decir, de la que depende, por lo que este nuevo campo 
será una fk sobre el campo nif_empresa. Mostrar un listado en donde salga el 
nombre de la empresa matriz y el nombre de la empresa de la que depende ordenado 
por empresa matriz. El nuevo campo llamado nif tomará valores nulos cuando se trate 
de una empresa que no depende de nadie. No es necesario hacer los cambios, sólo la consulta.*/



ALTER TABLE EMPRESAPRODUCTORA ADD NIF VARCHAR2(12);
ALTER TABLE EMPRESAPRODUCTORA ADD CONSTRAINT FK_NIF FOREIGN KEY (NIF) REFERENCES EMPRESAPRODUCTORA(NIF_EMPRESA);

SELECT E.NOMBRE_EMPRESA AS EMPRESA_MATRIZ, E2.NOMBRE_EMPRESA AS EMPRESA_SECUNDARIA
FROM EMPRESAPRODUCTORA e , EMPRESAPRODUCTORA e2 
WHERE E.NIF_EMPRESA = E2.NIF ;