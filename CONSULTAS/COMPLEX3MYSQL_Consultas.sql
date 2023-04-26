/*1. Visualizar el número de empleados de cada departamento*/

SELECT count(emp_no) as NUMERO_EMPLEADOS
FROM emple e 
group by dept_no  ;

/*2. Visualizar los departamentos con más de 5 empleados.*/

SELECT dept_no 
FROM emple e
group by dept_no 
having count(emp_no)>5;

/*3. Hallar la media de los salarios de cada departamento*/

SELECT AVG(salario)
from emple e 
group by (dept_no);

/*4. Visualizar el nombre de los empleados vendedores del departamento
ʻVENTASʼ */

SELECT apellido 
FROM emple e , depart d 
WHERE e.dept_no = d.dept_no 
AND e.oficio LIKE 'VENDEDOR'
and d.dnombre like 'VENTAS';

/*5. Visualizar el número de vendedores del departamento ʻVENTASʼ*/

SELECT count(apellido)
FROM emple e , depart d 
WHERE e.dept_no = d.dept_no 
AND e.oficio LIKE 'VENDEDOR'
and d.dnombre like 'VENTAS';

/*6. Visualizar los oficios de los empleados del departamento ʻVENTASʼ.*/

SELECT DISTINCT oficio , apellido 
FROM emple e , depart d 
WHERE e.dept_no = d.dept_no 
and d.dnombre like 'VENTAS';

/*7. A partir de la tabla EMPLE, visualizar el número de empleados de cada
departamento cuyo oficio sea ʻEMPLEADOʼ*/

SELECT count(apellido) as NUMERO_EMPLEADOS
FROM emple e
WHERE e.oficio LIKE 'EMPLEADO'
GROUP by dept_no ;

/*8. Visualizar el departamento con más empleados.*/

SELECT e.DEPT_NO, MAX(e.EMP_NO) AS NUM_EMPLEADOS
FROM emple e 
GROUP BY e.DEPT_NO 
ORDER BY NUM_EMPLEADOS DESC
LIMIT 1;


/*9. Mostrar los departamentos cuya suma de salarios sea mayor que la
media de salarios de todos los empleados.*/

SELECT d.DNOMBRE
FROM emple e, depart d 
WHERE e.dept_no = d.dept_no 
GROUP BY d.dnombre 
HAVING SUM(e.salario)>AVG(e.salario); 


/*10. Para cada oficio obtener la suma de salarios.*/

SELECT sum(salario), oficio 
FROM emple e 
group by oficio  ;

/*11. Visualizar la suma de salarios de cada oficio del departamento
ʻVENTASʼ.*/

SELECT sum(salario), oficio 
FROM emple e , depart d 
WHERE e.dept_no = d.dept_no 
and d.dnombre like 'VENTAS'
group by oficio;

/*12. Visualizar el número de departamento que tenga más empleados cuyo
oficio sea empleado.*/

SELECT e.DEPT_NO, COUNT(*) AS NUM_EMPLEADOS
FROM emple e
WHERE e.OFICIO = 'EMPLEADO'
GROUP BY e.DEPT_NO 
ORDER BY NUM_EMPLEADOS DESC
LIMIT 1;

/*13. Mostrar el número de oficios distintos de cada departamento.*/

SELECT DISTINCT count(oficio) , dept_no 
FROM emple e 
group by dept_no ;

/*14. Mostrar los departamentos que tengan más de dos personas
trabajando en la misma profesión.*/

SELECT DISTINCT count(oficio), e.dept_no 
FROM emple e 
group by dept_no 
HAVING COUNT(oficio)>2 ;


/*15. Dada la tabla HERRAMIENTAS, visualizar por cada estantería la suma
de las unidades.
Estantería SUMA
- 
 
 ---------------
1 25
2 7
3 17
4 10
5 15
6 15*/

SELECT sum(UNIDADES) as Estanteria_SUMA
FROM HERRAMIENTAS h 
group by ESTANTERIA  ;

/*16. Visualizar la estantería con más unidades de la tabla HERRAMIENTAS.
Estantería
-
1*/


SELECT Estanteria, SUM(UNIDADES) AS Total_Unidades
FROM HERRAMIENTAS
GROUP BY Estanteria
ORDER BY Total_Unidades DESC
LIMIT 1;


/*Tablas PERSONAS, MEDICOS, HOSPITALES.
17. Mostrar el número de médicos que pertenecen a cada hospital,
ordenado por número descendente de hospital.*/

SELECT count(m.DNI)
FROM MEDICOS m
group by m.COD_HOSPITAL
ORDER BY m.COD_HOSPITAL desc;

/*18. Realizar una consulta en la que se muestre por cada hospital el
nombre de las especialidades que tiene.*/

SELECT  m.ESPECIALIDAD,h.NOMBRE
FROM MEDICOS m , HOSPITALES h 
WHERE m.COD_HOSPITAL = h.COD_HOSPITAL 
GROUP BY h.NOMBRE, m.ESPECIALIDAD ;

/*19. Realizar una consulta en la que aparezca por cada hospital y en cada
especialidad el número de médicos*/

SELECT count(m.DNI) as MEDICOS, ESPECIALIDAD , COD_HOSPITAL 
FROM MEDICOS m 
group by m.COD_HOSPITAL, m.ESPECIALIDAD  ;

/*20. Obtener por cada hospital el número de empleados.*/

SELECT count(FUNCION) as Num_EMPLEADOS
FROM PERSONAS p 
group by p.COD_HOSPITAL  ;

/*21. Obtener por cada especialidad el número de trabajadores.*/

SELECT count(dni)
FROM MEDICOS m 
group by m.ESPECIALIDAD ;

/*22. Visualizar la especialidad que tenga más médicos.*/

/*MYSQL*/
SELECT count(dni), ESPECIALIDAD 
FROM MEDICOS m 
group by m.ESPECIALIDAD 
order by count(dni) DESC 
limit 1;

/*ORACLE*/
SELECT * from (SELECT count(dni), ESPECIALIDAD 
FROM MEDICOS m 
group by m.ESPECIALIDAD 
order by count(dni) DESC) as alias
WHERE rownum=1;

/*23. ¿Cuál es el nombre del hospital que tiene mayor número de plazas?*/

/*MYSQL*/
SELECT NOMBRE 
FROM HOSPITALES h
order by NUM_PLAZAS DESC 
limit 1;

/*ORACLE*/
SELECT * from (SELECT NOMBRE 
FROM HOSPITALES h
order by NUM_PLAZAS DESC)
where rownum=1;

/*24. Visualizar las diferentes estanterías de la tabla HERRAMIENTAS
ordenados descendentemente por estantería.*/

SELECT DISTINCT ESTANTERIA 
FROM HERRAMIENTAS h 
order by ESTANTERIA desc;

/*25. Averiguar cuántas unidades tiene cada estantería*/

SELECT sum(UNIDADES) as UNIDADES_POR_ESTANTERIA
FROM HERRAMIENTAS h 
group by estanteria;

/*26. Visualizar las estanterías que tengan más de 15 unidades*/

SELECT sum(UNIDADES) as UNIDADES_POR_ESTANTERIA
FROM HERRAMIENTAS h 
group by estanteria
having sum(UNIDADES)>15;

/*27. ¿Cuál es la estantería que tiene más unidades?*/

SELECT sum(UNIDADES) as UNIDADES_POR_ESTANTERIA, h.ESTANTERIA 
FROM HERRAMIENTAS h 
group by estanteria
order by sum(UNIDADES) desc
limit 1;


/*28. A partir de las tablas EMPLE y DEPART mostrar los datos del
departamento que no tiene ningún empleado.*/

SELECT d.*
FROM depart d , emple e 
WHERE d.dept_no = e.dept_no(+) 
and e.emp_no is null;

SELECT d.*
FROM emple e , depart d 
WHERE  d.dept_no = e.dept_no (+)
AND e.emp_no IS NULL;

SELECT *
FROM depart
WHERE dept_no NOT IN (SELECT DISTINCT dept_no FROM emple);


/*29. Mostrar el número de empleados de cada departamento. En la salida
se debe mostrar también los departamentos que no tienen ningún
empleado.*/

SELECT COUNT(e.emp_no), e.dept_no ,(SELECT dept_no 
FROM depart
WHERE dept_no NOT IN (SELECT DISTINCT dept_no FROM emple)) as Departamento_SIN_EMPLEADOS  
FROM emple e 
group by e.dept_no  ;

/*30. Obtener la suma de salarios de cada departamento, mostrando las
columnas DEPT_NO, SUMA DE SALARIOS y DNOMBRE. En el resultado
también se deben mostrar los departamentos que no tienen asignados
empleados.*/

SELECT sum(salario) as SUMA_SALARIO, e.dept_no , d.dnombre 
FROM emple e , depart d 
WHERE e.dept_no = d.dept_no 
group by e.dept_no ;

SELECT sum(salario) as SUMA_SALARIO, e.dept_no , d.dnombre 
FROM emple e , depart d 
WHERE e.dept_no = d.dept_no 
group by e.dept_no 
UNION 
SELECT d.salario, e.dept_no, d.dnombre
FROM EMPLEADOS e ,DEPARTAMENTO d 
WHERE  d.DEPT_NO= E.DEPT_NO (+)
AND e.EMP_NO IS NULL;

/*31. Utilizar la función IFNULL en la consulta anterior para que en el caso
de que un departamento no tenga empleados, aparezca como suma de
salarios el valor 0.*/

SELECT d.dept_no, d.dnombre, (
    SELECT IFNULL(SUM(e.salario), 0)
    FROM emple e
    WHERE e.dept_no = d.dept_no;
) AS suma_salarios
FROM depart d;


/*32. Obtener el número de médicos que pertenecen a cada hospital,
mostrando las columnas COD_HOSPITAL, NOMBRE y NÚMERO DE
MÉDICOS. En el resultado deben aparecer también los datos de los
hospitales que no tienen médicos.*/

SELECT count(m.dni) AS num_medicos, m.COD_HOSPITAL, h.NOMBRE 
FROM HOSPITALES h  , MEDICOS m 
WHERE m.COD_HOSPITAL(+) = h.COD_HOSPITAL
GROUP BY h.NOMBRE ,m.COD_HOSPITAL ;

