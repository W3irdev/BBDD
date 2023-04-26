/*1.Mostrar el identificador de los alumnos matriculados en cualquier asignatura excepto la '150212' y la '130113'.*/

select distinct(idalumno)
from alumno_asignatura
where idalumno not in(select idalumno from alumno_asignatura
					where idasignatura like '150212' or idasignatura like '130113');

/*2.Mostrar el nombre de las asignaturas que tienen más créditos que "Seguridad Vial". */

SELECT a.NOMBRE
FROM ASIGNATURA a 
WHERE a.CREDITOS > (SELECT a2.CREDITOS 
FROM ASIGNATURA a2 
WHERE a2.NOMBRE LIKE 'Seguridad Vial');

/*3.Obtener el Id de los alumnos matriculados en las asignaturas "150212" y "130113" a la vez. */

select distinct(idalumno)
from alumno_asignatura
where idalumno in (select idalumno from alumno_asignatura where idasignatura=150212)
And idalumno in (select idalumno from alumno_asignatura where idasignatura=130113);

/*4.Mostrar el Id de los alumnos matriculados en las asignatura "150212" ó "130113", en una o en otra pero no en ambas a la vez. */

select distinct(idalumno)
from alumno_asignatura
where (idasignatura = 130113 and idalumno not in
(select idalumno from alumno_asignatura where idasignatura=150212))
Or
(idasignatura = 150212 and idalumno not in
(select idalumno from alumno_asignatura where idasignatura=130113));

SELECT IDALUMNO 
FROM ALUMNO_ASIGNATURA aa2 
WHERE IDASIGNATURA LIKE '130113' AND IDALUMNO NOT IN (SELECT IDALUMNO 
												FROM ALUMNO_ASIGNATURA aa 
												WHERE IDASIGNATURA LIKE '150212')
OR IDASIGNATURA LIKE '150212' AND IDALUMNO NOT IN (SELECT IDALUMNO 
												FROM ALUMNO_ASIGNATURA aa 
												WHERE IDASIGNATURA LIKE '130113');

/*5.Mostrar el nombre de las asignaturas de la titulación "130110" cuyos costes básicos sobrepasen el coste básico promedio por asignatura en esa titulación.*/


SELECT nombre
FROM asignatura a 
WHERE idtitulacion LIKE '130110'
AND costebasico >
	(SELECT avg(nvl(a2.costebasico,0))
	FROM asignatura a2);

select nombre
from asignatura a
where costebasico>=(select avg(NVL(a.costebasico,0)) from asignatura a
				where idtitulacion='130110')
and idtitulacion='130110';

/*6.Mostrar el identificador de los alumnos matriculados en cualquier asignatura excepto la "150212" y la "130113”*/



SELECT distinct(idalumno)
from alumno_asignatura
where  idalumno not in(SELECT idalumno
						from alumno_asignatura
						where  idasignatura in('150212','130113'));

/*7.Mostrar el Id de los alumnos matriculados en la asignatura "150212" pero no en la "130113". */

select idalumno
from alumno_asignatura
where idasignatura = '150212'
	and idalumno not in(SELECT idalumno
						from alumno_asignatura
						where  idasignatura = '130113');

/*8.Mostrar el nombre de las asignaturas que tienen más créditos que "Seguridad Vial". */

select distinct(nombre)
from asignatura
where creditos>(select creditos
			from asignatura
			where ltrim(lower(nombre))='seguridad vial');
		
		
/*9.Mostrar las personas que no son ni profesores ni alumnos.*/

SELECT nombre,apellido
FROM persona
WHERE dni NOT IN 
		(SELECT dni 
		FROM profesor p)
AND dni NOT IN
		(SELECT dni
		FROM alumno a);

/*10Mostrar el nombre de las asignaturas que tengan más créditos. */

select  nombre
from asignatura
where creditos = (select max(creditos)
                from asignatura);

/*11Lista de asignaturas en las que no se ha matriculado nadie. */

select nombre
from asignatura a
where idasignatura not  in(select idasignatura
			  from alumno_asignatura);
			 
			 
/*12Ciudades en las que vive algún profesor y también algún alumno. */

SELECT p.CIUDAD 
FROM PERSONA p , PROFESOR p2 , ALUMNO a 
WHERE p.DNI = p2.DNI 
AND p.DNI = a.DNI;

select distinct(p.ciudad)
from persona p, persona p1
where  p.dni in(select dni from alumno)
or p1.dni in(select dni from profesor)
and p.ciudad=p1.ciudad;
