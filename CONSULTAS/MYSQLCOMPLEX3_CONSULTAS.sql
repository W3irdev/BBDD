/*1 Averigua el DNI de todos los clientes.*/

SELECT c.DNI FROM CLIENTE c ;

/*2 Consulta todos los datos de todos los programas.*/

SELECT * from PROGRAMA p ;

/*3 Obtén un listado con los nombres de todos los programas.*/

SELECT nombre from PROGRAMA p ;

/*4 Genera una lista con todos los comercios.*/

SELECT * from COMERCIO c ;

/*5 Genera una lista de las ciudades con establecimientos donde se venden
programas, sin que aparezcan valores duplicados (utiliza DISTINCT).*/

SELECT DISTINCT c.CIUDAD  
from COMERCIO c , DISTRIBUYE d ;

/*6 Obtén una lista con los nombres de programas, sin que aparezcan valores
duplicados (utiliza DISTINCT).*/

SELECT DISTINCT p.NOMBRE from PROGRAMA p ;

/*7 Obtén el DNI más 4 de todos los clientes.*/

SELECT c.DNI from CLIENTE c WHERE dni+4;

/*8 Haz un listado con los códigos de los programas multiplicados por 7*/

SELECT p.CODIGO*7 from PROGRAMA p ;

/*9 ¿Cuáles son los programas cuyo código es inferior o igual a 10?*/

SELECT p.NOMBRE from PROGRAMA p WHERE CODIGO <=10;

/*10 ¿Cuál es el programa cuyo código es 11?*/

SELECT p.NOMBRE from PROGRAMA p where p.CODIGO like '11';

/*11 ¿Qué fabricantes son de Estados Unidos?*/

SELECT f.NOMBRE from FABRICANTE f where PAIS like 'ESTADOS UNIDOS';

/*12 ¿Cuáles son los fabricantes no españoles? Utilizar el operador IN.*/

SELECT NOMBRE FROM FABRICANTE WHERE PAIS NOT IN ('ESPAÑA');

/*13 Obtén un listado con los códigos de las distintas versiones de Windows.*/

SELECT p.CODIGO 
FROM PROGRAMA p 
WHERE NOMBRE LIKE 'WINDOWS';


/*14 ¿En qué ciudades comercializa programas El Corte Inglés?*/

SELECT c.CIUDAD FROM COMERCIO c WHERE c.NOMBRE LIKE 'EL CORTE INGLES';

/*15 ¿Qué otros comercios hay, además de El Corte Inglés? Utilizar el operador
IN.*/

SELECT c.NOMBRE  FROM COMERCIO c WHERE c.NOMBRE NOT IN ('EL CORTE INGLES');

/*16 Genera una lista con los códigos de las distintas versiones de Windows y
Access. Utilizar el operador IN.*/

SELECT p.CODIGO 
FROM PROGRAMA p 
WHERE NOMBRE IN ('WINDOWS','ACCESS');

/*17 Obtén un listado que incluya los nombres de los clientes de edades
comprendidas entre 10 y 25 y de los mayores de 50 años. Da una solución con
BETWEEN y otra sin BETWEEN.*/

SELECT NOMBRE FROM CLIENTE WHERE (EDAD BETWEEN 10 AND 25) OR EDAD>50;
SELECT NOMBRE FROM CLIENTE WHERE (EDAD>=10 AND EDAD<=25) OR EDAD>50;

/*18 Saca un listado con los comercios de Sevilla y Madrid. No se admiten
valores duplicados.*/

SELECT DISTINCT NOMBRE FROM COMERCIO WHERE CIUDAD IN ('SEVILLA','NADRID');

/*19 ¿Qué clientes terminan su nombre en la letra “o”?*/

SELECT NOMBRE FROM CLIENTE WHERE NOMBRE LIKE '%O';

/*20 ¿Qué clientes terminan su nombre en la letra “o” y, además, son mayores de
30 años?*/

SELECT NOMBRE FROM CLIENTE WHERE NOMBRE LIKE '%O' AND EDAD>30;

/*21 Obtén un listado en el que aparezcan los programas cuya versión finalice
por una letra i, o cuyo nombre comience por una A o por una W.*/

SELECT DISTINCT  NOMBRE FROM PROGRAMA p WHERE p.VERSION LIKE '%I' OR NOMBRE like 'A%' or NOMBRE like 'W%';

/*22 Obtén un listado en el que aparezcan los programas cuya versión finalice
por una letra i, o cuyo nombre comience por una A y termine por una S.*/

SELECT NOMBRE FROM PROGRAMA p WHERE p.VERSION LIKE '%I' OR NOMBRE LIKE 'A%S';

/*23 Obtén un listado en el que aparezcan los programas cuya versión finalice
por una letra i, y cuyo nombre no comience por una A.*/

SELECT NOMBRE FROM PROGRAMA p WHERE p.VERSION LIKE '%I' AND NOMBRE NOT LIKE 'A%';

/*24 Obtén una lista de empresas por orden alfabético ascendente.*/

SELECT NOMBRE FROM FABRICANTE  ORDER BY NOMBRE;

/*25 Genera un listado de empresas por orden alfabético descendente.*/

SELECT NOMBRE FROM FABRICANTE  ORDER BY NOMBRE DESC;


































