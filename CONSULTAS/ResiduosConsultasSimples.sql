/*1 Muestra el nombre de las empresas productoras de Huelva o Málaga ordenadas 
 por el nombre en orden alfabético inverso.*/

SELECT NOMBRE_EMPRESA 
FROM EMPRESAPRODUCTORA e 
WHERE CIUDAD_EMPRESA IN ('Huelva','Malaga');

/*2 Mostrar los nombres de los destinos cuya ciudad contenga 
 una b mayúscula o minúscula.*/

SELECT D.NOMBRE_DESTINO 
FROM DESTINO d 
WHERE lower(D.CIUDAD_DESTINO)  LIKE '%b%';

/*3 Obtener el código de los residuos con una cantidad 
superior a 4 del constituyente 116.*/

SELECT RC.COD_RESIDUO 
FROM RESIDUO_CONSTITUYENTE rc 
WHERE RC.CANTIDAD > 4 AND RC.COD_CONSTITUYENTE LIKE '116';

/*4 Muestra el tipo de transporte, los kilómetros y el coste de 
los traslados realizados en diciembre de 1994.*/

SELECT T.TIPO_TRANSPORTE, T.KMS , T.COSTE  
FROM TRASLADO t 
WHERE EXTRACT(MONTH FROM T.FECHA_ENVIO )=12 AND EXTRACT(YEAR FROM T.FECHA_ENVIO)=1994;

/*5 Mostrar el código del residuo y el número de constituyentes de cada residuo.*/

SELECT R.COD_RESIDUO , R.NUM_CONSTITUYENTES 
FROM RESIDUO r ;

/*6 Mostrar la cantidad media de residuo vertida por las empresas durante el año 1994.*/

SELECT NVL(AVG(RE.CANTIDAD),0)
FROM RESIDUO_EMPRESA re 
WHERE EXTRACT (YEAR FROM RE.FECHA )=1994;

/*7 Mostrar el mayor número de kilómetros de un traslado realizado el mes de marzo.*/

SELECT MAX(T.KMS)
FROM TRASLADO t 
WHERE EXTRACT (MONTH FROM T.FECHA_ENVIO )='03';

/*8 Mostrar el número de constituyentes distintos que genera cada empresa, 
 * mostrando también el nif de la empresa, para aquellas empresas que generen 
 * más de 4 constituyentes.*/

SELECT COUNT(DISTINCT RC.COD_CONSTITUYENTE) , RE.NIF_EMPRESA 
FROM RESIDUO_EMPRESA re , RESIDUO r , RESIDUO_CONSTITUYENTE rc 
WHERE RE.COD_RESIDUO = R.COD_RESIDUO AND R.COD_RESIDUO = RC.COD_RESIDUO 
AND RE.CANTIDAD >4
GROUP BY RE.NIF_EMPRESA ;

/*9 Mostrar el nombre de las diferentes empresas que han enviado residuos 
 * que contenga la palabra metales en su descripción.*/

SELECT DISTINCT E.NOMBRE_EMPRESA 
FROM EMPRESAPRODUCTORA e , RESIDUO r , RESIDUO_EMPRESA re 
WHERE E.NIF_EMPRESA = RE.NIF_EMPRESA AND RE.COD_RESIDUO = R.COD_RESIDUO 
AND R.OD_RESIDUO LIKE '%metales%';

/*10 Mostrar el número de envíos que se han realizado entre cada ciudad, 
 * indicando también la ciudad origen y la ciudad destino.*/

SELECT count(t.FECHA_ENVIO), e.NOMBRE_EMPTRANSPORTE AS Origen, d.NOMBRE_DESTINO AS Destino
FROM EMPRESATRANSPORTISTA e , TRASLADO t , DESTINO d 
WHERE e.NIF_EMPTRANSPORTE = t.NIF_EMPTRANSPORTE AND t.COD_DESTINO = d.COD_DESTINO 
GROUP BY e.NOMBRE_EMPTRANSPORTE , d.NOMBRE_DESTINO ;

/*11 Mostrar el nombre de la empresa transportista que ha transportado para una empresa que 
 esté en Málaga o en Huelva un residuo que contenga Bario o Lantano. Mostrar también la fecha 
 del transporte.*/

SELECT DISTINCT e.NOMBRE_EMPTRANSPORTE , t.FECHA_ENVIO 
FROM EMPRESATRANSPORTISTA e , EMPRESAPRODUCTORA e2 , TRASLADO t , RESIDUO_EMPRESA re , RESIDUO r , RESIDUO_CONSTITUYENTE rc , CONSTITUYENTE c 
WHERE e.NIF_EMPTRANSPORTE = t.NIF_EMPTRANSPORTE AND t.NIF_EMPRESA = e2.NIF_EMPRESA AND e2.NIF_EMPRESA = re.NIF_EMPRESA AND re.COD_RESIDUO = r.COD_RESIDUO
AND r.COD_RESIDUO = rc.COD_RESIDUO  AND rc.COD_CONSTITUYENTE = c.COD_CONSTITUYENTE 
AND e2.CIUDAD_EMPRESA IN ('Malaga', 'Huelva') AND c.NOMBRE_CONSTITUYENTE  IN ('Bario','Lantano');

/*12 Mostrar el coste por kilómetro del total de traslados encargados por la 
 * empresa productora Carbonsur.*/

SELECT t.COSTE / t.KMS AS Euros_Kilometro
FROM TRASLADO t , EMPRESAPRODUCTORA e 
WHERE t.NIF_EMPRESA = e.NIF_EMPRESA 
AND e.NOMBRE_EMPRESA LIKE 'Carbonsur';

/*13 Mostrar el número de constituyentes de cada residuo.*/

SELECT count(COD_CONSTITUYENTE), COD_RESIDUO 
FROM RESIDUO_CONSTITUYENTE rc
GROUP BY COD_RESIDUO ;

/*14 Mostrar la descripción de los residuos y la fecha que se generó el residuo, para aquellos 
 * residuos que se han generado en los últimos 30 días por una empresa cuyo nombre tenga una c. 
 * La consulta debe ser válida para cualquier fecha y el listado debe aparecer ordenado por la
 *  descripción del residuo y la fecha.*/

SELECT r.OD_RESIDUO , re.FECHA 
FROM RESIDUO_EMPRESA re , EMPRESAPRODUCTORA e , RESIDUO r 
WHERE r.COD_RESIDUO = re.COD_RESIDUO AND re.NIF_EMPRESA = e.NIF_EMPRESA 
AND e.NOMBRE_EMPRESA LIKE '%c%' AND re.FECHA > (SYSDATE-30);


