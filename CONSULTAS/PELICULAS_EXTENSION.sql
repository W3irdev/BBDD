/*1 Obtener el título de la película, la fecha y el nombre del 
 * director de las películas en las que su director haya trabajado
 *  alguna vez como también como actor o actriz principal o secundaria .*/

SELECT p.TITULO_P , p2.FECHA_ESTRENO , t.NOMBRE_PERSONA 
FROM PELICULA p , PROYECCION p2 , TRABAJO t 
WHERE p.CIP = p2.CIP AND p.CIP = t.CIP 
AND (t.NOMBRE_PERSONA LIKE 'Director' AND t.NOMBRE_PERSONA LIKE 'Act%');


/*2 Mostrar todos los datos de las películas que el total de su
 *  recaudación sea superior a 700 veces el número de espectadores 
 * que han visto la película*/


SELECT *
FROM PELICULA p , PROYECCION p2 
WHERE p.CIP = p2.CIP 
AND p2.RECAUDACION > (p2.ESPECTADORES *700);


/*3 Crear una sentencia SQL para obtener todas las salas (nombre del cine y de la sala) que han estrenado 
 películas escocesas (nacionalidad Escocia) en el periodo comprendido 
 entre dos meses antes del 7 de diciembre del año 1996.*/

SELECT p.CINE , p.SALA 
FROM PROYECCION p , PELICULA p2 
WHERE p.CIP = p2.CIP 
AND p2.NACIONALIDAD LIKE 'Escocia' AND p.FECHA_ESTRENO BETWEEN to_date('07/10/1996', 'DD/MM/YYYY') AND to_date('07/12/1996', 'DD/MM/YYYY');