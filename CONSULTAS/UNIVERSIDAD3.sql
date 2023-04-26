/*1 Cuantos costes básicos hay.*/

SELECT count(a.COSTEBASICO) AS Costes_Basicos
FROM ASIGNATURA a;

/*2 Para cada titulación mostrar el número de asignaturas que 
 * hay junto con el nombre de la titulación.*/

SELECT count(a.IDASIGNATURA) AS Numero_Asignaturas, t.NOMBRE 
FROM ASIGNATURA a , TITULACION t 
WHERE t.IDTITULACION = a.IDTITULACION 
GROUP BY t.NOMBRE ;

/*3 Para cada titulación mostrar el nombre de la titulación 
 * 
 junto con el precio total de todas sus asignaturas.*/

SELECT t.NOMBRE , sum(a.COSTEBASICO*a.CREDITOS) AS Precio_Total
FROM TITULACION t , ASIGNATURA a 
WHERE t.IDTITULACION = a.IDTITULACION 
GROUP BY t.NOMBRE ;

/*4 Cual sería el coste global de cursar la titulación de Matemáticas
 * si el coste de cada asignatura fuera incrementado en un 7%. */

SELECT  sum(a.CREDITOS*(a.COSTEBASICO*1.07)) AS Coste_Global_Matematicas 
FROM ASIGNATURA a , TITULACION t 
WHERE t.IDTITULACION = a.IDTITULACION 
AND t.NOMBRE LIKE 'Matematicas';

/*5 Cuantos alumnos hay matriculados en cada asignatura, junto al id de la asignatura. 
*/

SELECT count(aa.IDALUMNO) AS Numero_Alumnos, aa.IDASIGNATURA 
FROM ALUMNO_ASIGNATURA aa 
GROUP BY aa.IDASIGNATURA  ;

/*6 Igual que el anterior pero mostrando el nombre de la asignatura.*/


SELECT count(aa.IDALUMNO) AS Numero_Alumnos, aa.IDASIGNATURA , a.NOMBRE AS Nombre_Asignatura
FROM ALUMNO_ASIGNATURA aa , ASIGNATURA a 
WHERE aa.IDASIGNATURA = a.IDASIGNATURA 
GROUP BY aa.IDASIGNATURA, a.NOMBRE  ;

/*7 Mostrar para cada alumno, el nombre del alumno junto con lo que tendría que pagar
 *  por el total de todas las asignaturas en las que está matriculada. 
 * Recuerda que el precio de la matrícula tiene un incremento 
 * de un 10% por cada año en el que esté matriculado. */

/*SELECT p.NOMBRE , (sum((a2.COSTEBASICO)*(0.10*(aa.NUMEROMATRICULA))+a2.COSTEBASICO))*a2.CREDITOS  AS Precio_Total
FROM PERSONA p , ALUMNO a , ALUMNO_ASIGNATURA aa , ASIGNATURA a2 
WHERE p.DNI = a.DNI AND a.IDALUMNO = aa.IDALUMNO AND aa.IDASIGNATURA = a2.IDASIGNATURA 
GROUP BY p.NOMBRE, a2.CREDITOS  ;*/

SELECT  P.NOMBRE ,SUM(decode(numeromatricula,1,costebasico,costebasico +(costebasico*(NUMEROMATRICULA*0.10)))) PRECIOTOTAL 
    FROM alumno_asignatura aa,ASIGNATURA a,alumno al,PERSONA P
    WHERE aa.idasignatura=a.IDASIGNATURA
    AND AA.IDALUMNO= AL.IDALUMNO
    AND AL.DNI = P.DNI
    GROUP BY P.NOMBRE;

/*8 Coste medio de las asignaturas de cada titulación, para aquellas titulaciones 
 * en el que el coste total de la 1ª matrícula sea mayor que 60 euros. */

SELECT AVG(A.COSTEBASICO)
FROM TITULACION t ,ASIGNATURA a ,ALUMNO_ASIGNATURA aa 
WHERE T.IDTITULACION = A.IDTITULACION 
AND A.IDASIGNATURA = AA.IDASIGNATURA
AND AA.NUMEROMATRICULA =1
GROUP BY T.NOMBRE 
HAVING SUM(A.COSTEBASICO)>60;

/*9 Nombre de las titulaciones  que tengan más de tres alumnos.*/

SELECT a.NOMBRE 
FROM ALUMNO_ASIGNATURA aa , ASIGNATURA a , TITULACION t 
WHERE aa.IDASIGNATURA = a.IDASIGNATURA 
AND t.IDTITULACION = a.IDTITULACION 
GROUP BY a.NOMBRE 
HAVING count(aa.IDALUMNO)>3;

/*10 Nombre de cada ciudad junto con el número de personas que viven en ella.*/

SELECT p.CIUDAD , count(p.DNI) AS Viven
FROM PERSONA p 
GROUP BY p.CIUDAD  ;

/*11 Nombre de cada profesor junto con el número de asignaturas que imparte.*/

SELECT p.NOMBRE , count(a.IDASIGNATURA) AS Nº_ASIGNATURAS
FROM PERSONA p , PROFESOR pro, ASIGNATURA a 
WHERE p.DNI = pro.DNI AND pro.IDPROFESOR = a.IDPROFESOR 
GROUP BY p.NOMBRE  ;


/*12 Nombre de cada profesor junto con el número de alumnos que tiene, para aquellos profesores que tengan dos o más de 2 alumnos.*/

SELECT p.NOMBRE , count(aa.IDALUMNO) AS Nº_ALUMNOS
FROM PERSONA p , PROFESOR pro, ASIGNATURA a , ALUMNO_ASIGNATURA aa 
WHERE p.DNI = pro.DNI AND pro.IDPROFESOR = a.IDPROFESOR AND a.IDASIGNATURA = aa.IDASIGNATURA 
GROUP BY p.NOMBRE 
HAVING count(aa.IDALUMNO)>=2;


/*13 Obtener el máximo de las sumas de los costesbásicos de cada cuatrimestre*/

SELECT max(sum(a.COSTEBASICO)) AS MAXIMO_COSTE
FROM ASIGNATURA a 
GROUP BY a.CUATRIMESTRE  ;

/*14 Suma del coste de las asignaturas*/

SELECT sum(COSTEBASICO*CREDITOS) AS COSTE_ASIGNATURA
FROM ASIGNATURA a ;

/*15 ¿Cuántas asignaturas hay?*/

SELECT count(IDASIGNATURA) AS Nº_ASIGNATURAS
FROM ASIGNATURA a  ;

/*16 Coste de la asignatura más cara y de la más barata*/

SELECT max(sum(COSTEBASICO*CREDITOS)) AS COSTE_ASIGNATURA_CARA,
min(sum(COSTEBASICO*CREDITOS)) AS COSTE_ASIGNATURA_BARATA
FROM ASIGNATURA a 
GROUP BY a.IDASIGNATURA ;

/*17 ¿Cuántas posibilidades de créditos de asignatura hay?*/

SELECT count(DISTINCT CREDITOS) AS CONJUNTO_CREDITOS
FROM ASIGNATURA a ;

/*18 ¿Cuántos cursos hay?*/

SELECT count(CURSO) AS CURSOS
FROM ASIGNATURA a  ;

/*19 ¿Cuántas ciudades hau?*/

SELECT count(CIUDAD) AS CIUDADES
FROM PERSONA p ;

/*20 Nombre y número de horas de todas las asignaturas.*/

SELECT NOMBRE, a.CREDITOS*10
FROM ASIGNATURA a ;

/*21 Mostrar las asignaturas que no pertenecen a ninguna titulación.*/

SELECT a.NOMBRE 
FROM ASIGNATURA a 
WHERE a.IDTITULACION IS NULL OR a.IDTITULACION LIKE '';

/*22 Listado del nombre completo de las personas, sus teléfonos y sus direcciones, llamando a la columna del nombre "NombreCompleto" y a la de direcciones "Direccion".*/

SELECT p.NOMBRE||' '||p.APELLIDO  AS NOMBRE_COMPLETO, p.TELEFONO , (p.DIRECCIONCALLE||', '|| p.DIRECCIONNUM ) AS DIRECCION
FROM PERSONA p ;

/*23 Cual es el día siguiente al día en que nacieron las personas de la B.D.*/

SELECT EXTRACT (DAY FROM p.FECHA_NACIMIENTO +1)
FROM PERSONA p  ;

/*24 Años de las personas de la Base de Datos, esta consulta tiene que valor para cualquier momento*/

SELECT EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM p.FECHA_NACIMIENTO ) AS YEARS
FROM PERSONA p ;

/*25 Listado de personas mayores de 25 años ordenadas por apellidos y nombre, esta consulta tiene que valor para cualquier momento*/

SELECT p.NOMBRE 
FROM PERSONA p 
WHERE EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM p.FECHA_NACIMIENTO )>25;

/*26 Nombres completos de los profesores que además son alumnos*/

SELECT p.NOMBRE , p.APELLIDO 
FROM PERSONA p , PROFESOR pro, ALUMNO a 
WHERE p.DNI = pro.DNI AND pro.DNI = a.DNI ;

/*27 Suma de los créditos de las asignaturas de la titulación de Matemáticas*/

SELECT sum(CREDITOS)
FROM ASIGNATURA a , TITULACION t 
WHERE a.IDTITULACION = t.IDTITULACION AND t.NOMBRE LIKE 'Matematicas' ;

/*28 Número de asignaturas de la titulación de Matemáticas*/

SELECT count(a.IDASIGNATURA) AS Nº_ASIGNATURAS
FROM ASIGNATURA a , TITULACION t 
WHERE a.IDTITULACION = t.IDTITULACION AND t.NOMBRE LIKE 'Matematicas';

/*29 ¿Cuánto paga cada alumno por su matrícula?*/

SELECT sum(a.COSTEBASICO*a.CREDITOS), alu.IDALUMNO 
FROM ASIGNATURA a , ALUMNO_ASIGNATURA aa , ALUMNO alu
WHERE aa.IDALUMNO = alu.IDALUMNO
GROUP BY alu.IDALUMNO ;

/*30 ¿Cuántos alumnos hay matriculados en cada asignatura?*/

SELECT count(aa.IDALUMNO), aa.IDASIGNATURA 
FROM ALUMNO_ASIGNATURA aa 
GROUP BY aa.IDASIGNATURA ;












































