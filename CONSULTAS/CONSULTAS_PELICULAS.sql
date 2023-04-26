/*1. Obtén las diferentes ciudades donde hay cines*/

SELECT DISTINCT CIUDAD_CINE 
FROM CINE c ;

/*2. Obtener las películas con un presupuesto mayor de 2000 o cuya duración sea superior a 100.*/

SELECT TITULO_P 
FROM PELICULA p 
WHERE PRESUPUESTO > 2000 OR duracion >100;

/*3. Obtener las películas cuyo título (da igual el original o el español) contenga la cadena la sin
importar que esté en mayúsculas o minúsculas.*/

SELECT p.TITULO_P 
FROM PELICULA p 
WHERE upper(p.TITULO_P) LIKE '%LA%' ;

/*4. Obtener el nombre y la nacionalidad de los personajes que sean hombres ordenado por
nacionalidad y nombre.*/

SELECT p.NOMBRE_PERSONA , p.NACIONALIDAD_PERSONA 
FROM PERSONAJE p 
WHERE SEXO_PERSONA = 'H'
ORDER BY NACIONALIDAD_PERSONA , p.NOMBRE_PERSONA ;

/*5. Obtener las películas estrenadas en el mes de septiembre.*/

SELECT DISTINCT p.TITULO_P 
FROM PELICULA p , PROYECCION p2 
WHERE p.CIP = p2.CIP 
AND EXTRACT(MONTH FROM p2.FECHA_ESTRENO)='09' ;

/*6. Obtener las diferentes tareas que ha desempeñado alguna persona alguna vez.*/

SELECT DISTINCT TAREA 
FROM TRABAJO t ;

/*7. Obtener el numero de sala y el aforo de todas las salas de los cines que terminen en vocal.*/

SELECT SALA , AFORO 
FROM SALA s 
WHERE REGEXP_LIKE(upper(CINE),'[A,E,I,O,U]$') ;

/*8. Obtener las distintas ciudades que tienen cines con alguna sala con aforo superior a 100
ordenadas por el nombre de la ciudad de la z a la a.*/

SELECT DISTINCT c.CIUDAD_CINE 
FROM sala s, CINE c 
WHERE c.CINE = s.CINE 
AND s.AFORO > 100
ORDER BY c.CIUDAD_CINE DESC;

/*9. Obtener los títulos (ambos) y la nacionalidad de las películas que hayan obtenido una
recaudación en alguna sala 10000 mayor que su presupuesto ordenadas de mayor a menor
beneficio.*/

SELECT p.TITULO_P, p.TITULO_S, p.NACIONALIDAD, p2.RECAUDACION , p.PRESUPUESTO 
FROM PELICULA p, PROYECCION p2
WHERE p.CIP = p2.CIP
AND p2.RECAUDACION > p.PRESUPUESTO
ORDER BY (p2.RECAUDACION - p.PRESUPUESTO) DESC;


/*10. Obtener el nombre de los actores hombres que participen en la película Viaje al centro de la
tierra.*/

SELECT t.NOMBRE_PERSONA 
FROM PELICULA p , TRABAJO t 
WHERE p.CIP = t.CIP 
AND p.TITULO_P LIKE 'Viaje al centro de la tierra'
AND t.TAREA LIKE '%Actor%';

/*11. Obtener el nombre del cine y el número de películas diferentes estrenadas por cada cine
ordenadas por el número de películas ordenadas de mayor a menor.*/

SELECT COUNT(p.CIP) AS Num_Pelis, p.CINE
FROM PROYECCION p
GROUP BY p.CINE
ORDER BY COUNT(p.CIP) DESC;

/*12. Obtener el nombre y nacionalidad de las personas que hayan trabajado en alguna película de
diferente nacionalidad a la suya.*/

SELECT p.NOMBRE_PERSONA , p.NACIONALIDAD_PERSONA 
FROM PERSONAJE p , TRABAJO t , PELICULA p2 
WHERE p.NOMBRE_PERSONA = t.NOMBRE_PERSONA AND t.CIP = p2.CIP 
AND p.NACIONALIDAD_PERSONA NOT IN (p2.NACIONALIDAD);

/*13. Obtener por cada cine, el nombre, las salas y el nombre de la película*/

SELECT p2.CINE, COUNT(p2.SALA) AS SALAS, p.TITULO_P
FROM PELICULA p, PROYECCION p2 
where p.CIP = p2.CIP
GROUP BY p2.CINE, p.TITULO_P;


/*14. Obtener la recaudación total de cada cine ordenada de mayor a menor recaudación total.*/

SELECT SUM(p.RECAUDACION) AS RECAUDACION_TOTAL, p.CINE
FROM PROYECCION p
GROUP BY p.CINE
ORDER BY RECAUDACION_TOTAL DESC;


/*15. Obtener aquellas personas que hayan realizado una tarea cuyo sexo sea diferente al suyo,
teniendo en cuenta que para productor y director no hay un sexo definido.*/

SELECT DISTINCT p.NOMBRE_PERSONA 
FROM TRABAJO t , TAREA t2 , PERSONAJE p 
WHERE p.NOMBRE_PERSONA = t.NOMBRE_PERSONA AND t.TAREA = t2.TAREA 
AND t2.SEXO_TAREA != p.SEXO_PERSONA ;

/*16. Obtener el título, al año de producción, el presupuesto y la recaudación total de las películas
que han sido proyectadas en algún cine de la ciudad de Córdoba.*/

SELECT DISTINCT p.TITULO_P , p.ANO_PRODUCCION , p.PRESUPUESTO , p2.RECAUDACION 
FROM PELICULA p , PROYECCION p2 , SALA s , CINE c 
WHERE c.CINE = s.CINE AND s.CINE = p2.CINE AND s.SALA = p2.SALA  AND p2.CIP = p.CIP
AND c.CIUDAD_CINE LIKE 'Cordoba';

/*17. Obtener el título de las películas cuya recaudación por espectador (con 2 decimales) sea
mayor de 700.*/

SELECT DISTINCT p.TITULO_P 
FROM PELICULA p , PROYECCION p2 
WHERE p.CIP = p2.CIP 
AND ROUND((p2.RECAUDACION / p2.ESPECTADORES),2) >700; 

/*18. Obtener el nombre de los actores que han participado en más de 2 películas.*/

SELECT p.NOMBRE_PERSONA 
FROM PERSONAJE p , TRABAJO t 
WHERE p.NOMBRE_PERSONA = t.NOMBRE_PERSONA 
GROUP BY p.NOMBRE_PERSONA 
HAVING count(t.CIP)>2;
