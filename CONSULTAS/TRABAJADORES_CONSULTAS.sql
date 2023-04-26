/*1. Nombre de los trabajadores cuya tarifa este entre 10 y 12 euros*/

SELECT t.NOMBRE 
FROM TRABAJADOR t 
WHERE t.TARIFA BETWEEN 10 AND 12;

/*2. ¿Cuáles son los oficios de los trabajadores asignados al edificio 435?*/

SELECT t.OFICIO 
FROM TRABAJADOR t , ASIGNACION a , EDIFICIO e 
WHERE t.ID_T = a.ID_T AND a.ID_E = e.ID_E 
AND e.ID_E LIKE '435';

/*3. Indicar el nombre del trabajador y el de su supervisor.*/

SELECT t1.NOMBRE AS TRABAJADOR, t2.NOMBRE AS SUPERVISOR
FROM TRABAJADOR t1, TRABAJADOR t2
WHERE t1.ID_SUPV = t2.ID_T;


/*4. Nombre de los trabajadores asignados a oficinas./
 */

SELECT DISTINCT t.NOMBRE 
FROM TRABAJADOR t , ASIGNACION a 
WHERE t.ID_T = a.ID_T ;


/*5. ¿Qué trabajadores reciben una tarifa por hora mayor que la de su supervisor?*/

SELECT t1.NOMBRE AS TRABAJADOR
FROM TRABAJADOR t1, TRABAJADOR t2
WHERE t1.ID_SUPV = t2.ID_T
AND t2.TARIFA < t1.TARIFA ;

/*6. ¿Cuál es el número total de días que se han dedicado a fontanería en el edificio 312?*/

SELECT sum(a.NUM_DIAS)
FROM ASIGNACION a 
WHERE a.ID_E LIKE '312';

/*7. ¿Cuántos tipos de oficios diferentes hay?/
 */

SELECT DISTINCT count(OFICIO)
FROM TRABAJADOR t ;

/*8. Para cada supervisor, ¿Cuál es la tarifa por hora más alta que se paga a un trabajador
que informa a esesupervisor?*/

SELECT max(TARIFA)
FROM TRABAJADOR t 
GROUP BY ID_SUPV ;

/*9. Para cada supervisor que supervisa a más de un trabajador, ¿cuál es la tarifa más alta
que se para a un trabajador que informa a ese supervisor?*/

SELECT max(TARIFA)
FROM TRABAJADOR t 
GROUP BY ID_SUPV 
HAVING count(ID_T )>1;

/*10. Para cada tipo de edificio, ¿Cuál es el nivel de calidad medio de los edificios con
categoría 1? Considérense sólo aquellos tipos de edificios que tienen un nivel de calidad
máximo no mayor que 3.*/

SELECT avg(e.NIVEL_CALIDAD)
FROM EDIFICIO e 
GROUP BY e.TIPO ;

/*11. ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio?*/

SELECT NOMBRE
FROM TRABAJADOR
WHERE TARIFA < (SELECT AVG(TARIFA) FROM TRABAJADOR);


/*12. ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio de los
trabajadores que tienen su mismo oficio?*/

SELECT t.NOMBRE
FROM TRABAJADOR t
WHERE t.TARIFA < (SELECT AVG(TARIFA) FROM TRABAJADOR WHERE OFICIO = t.OFICIO);



/*13. ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio de los
trabajadores que dependen del mismo supervisor que él?*/



/*14. Seleccione el nombre de los electricistas asignados al edificio 435 y la fecha en la que
empezaron a trabajar enél.*/

/*15. ¿Qué supervisores tienen trabajadores que tienen una tarifa por hora por encima de
los 12 euros?*/