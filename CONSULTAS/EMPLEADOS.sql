create table depart
(
dept_no integer(4),
dnombre varchar(30),
loc varchar(30),
constraint pk_depart primary key (dept_no)
);

create table emple
(
emp_no integer(4),
apellido varchar(30),
oficio varchar(30),
dir integer(4),
fecha_alt date,
salario integer(30),
comision integer(30),
dept_no integer(2),
constraint pk_emple primary key (emp_no),
constraint fk_dir foreign key (dir) references emple(emp_no),
constraint fk_dept_no foreign key (dept_no) references depart(dept_no)
);

insert into depart 
values (10, 'CONTABILIDAD', 'SEVILLA');

insert into depart 
values (20, 'INVESTIGACION', 'MADRID');

insert into depart 
values (30, 'VENTAS', 'BARCELONA');

insert into depart 
values (40, 'PRODUCCION', 'BILBAO');

INSERT INTO emple 
values (7839, 'REY', 'PRESIDENTE', NULL, STR_TO_DATE('1981/11/17', '%Y/%m/%d'), 650000, NULL, 10);

INSERT INTO emple 
values (7566, 'JIMENEZ', 'DIRECTOR', 7839, STR_TO_DATE('1981/04/02', '%Y/%m/%d'), 386750, NULL, 20);

INSERT INTO emple 
values (7788, 'GIL', 'ANALISTA', 7566, STR_TO_DATE('1981/11/09', '%Y/%m/%d'), 650000, NULL, 20);

INSERT INTO emple 
values (7698, 'NEGRO', 'DIRECTOR', 7839, STR_TO_DATE('1981/05/01','%Y/%m/%d'), 370500, NULL, 30);

INSERT INTO emple 
values (7902, 'FERNANDEZ', 'ANALISTA', 7566, STR_TO_DATE('1981/12/03','%Y/%m/%d'), 390000, NULL, 20);

INSERT INTO emple 
values (7369, 'SANCHEZ', 'EMPLEADO', 7902, STR_TO_DATE('1980/12/17', '%Y/%m/%d'), 104000, NULL, 20);

INSERT INTO emple 
values (7499, 'ARROYO', 'VENDEDOR', 7902, STR_TO_DATE('1980/02/20', '%Y/%m/%d'), 208000, 39000, 30);

INSERT INTO emple 
values (7521, 'SALA', 'VENDEDOR', 7698, STR_TO_DATE('1981/02/22', '%Y/%m/%d'), 162500, 162500, 30);

INSERT INTO emple 
values (7654, 'MARTIN', 'VENDEDOR', 7698, STR_TO_DATE('1981/09/29', '%Y/%m/%d'), 162500, 182000, 30);

INSERT INTO emple 
values (7844, 'TOVAR', 'VENDEDOR', 7698, STR_TO_DATE('1981/09/08', '%Y/%m/%d'), 195000, 0, 30);

INSERT INTO emple 
values (7876, 'ALONSO', 'EMPLEADO', 7788, STR_TO_DATE('1981/09/23', '%Y/%m/%d'), 143000, NULL, 20);

INSERT INTO emple 
values (7900, 'JIMENO', 'EMPLEADO', 7698, STR_TO_DATE('1981/12/03', '%Y/%m/%d'), 1235000, NULL, 30);

INSERT INTO emple 
values (7934, 'MUÑOZ', 'EMPLEADO', null, STR_TO_DATE('1982/01/23', '%Y/%m/%d'), 169000, null, 10);

/*1*/
SELECT e.apellido , e.oficio , e.dept_no 
FROM emple e;

/*2*/
SELECT *
FROM depart d;

/*3*/
SELECT *
FROM emple e;

/*4*/
SELECT *
from emple e 
order by e.apellido ;

/*5*/

SELECT *
FROM emple e 
order by dept_no DESC ;

/*6*/

SELECT *
FROM emple e 
order by dept_no desc, e.apellido;

/*8*/

SELECT *
FROM emple e 
WHERE salario > 2000000;

/*9*/

SELECT *
FROM emple e 
WHERE e.oficio like 'ANALISTA';

/*10*/

SELECT e.apellido , e.oficio 
FROM emple e 
WHERE e.dept_no = 20;

/*11*/

SELECT *
FROM emple e order by e.apellido ;

/*12*/

SELECT *
FROM emple e 
WHERE e.oficio like 'VENDEDOR' order by e.apellido ;

/*13*/

SELECT *
FROM emple e 
WHERE e.dept_no = 10 and e.oficio like 'ANALISTA'
order by e.apellido ;

/*14*/

SELECT *
FROM  emple e 
WHERE e.salario > 200000 or dept_no = 20;

/*15*/

SELECT *
FROM emple e order by e.oficio , e.apellido ;

/*16*/

SELECT *
FROM emple e 
WHERE e.apellido like 'A%'

/*17*/

SELECT *
FROM emple e 
WHERE e.apellido like '%Z';

/*18*/

SELECT *
from emple e 
WHERE e.apellido like 'A%' and e.oficio like '%E%';

/*19*/

SELECT *
FROM emple e 
WHERE e.salario BETWEEN 100000 and 200000;

/*20*/

SELECT *
FROM emple e 
WHERE e.oficio like 'VENDEDOR' and e.comision > 100000;

/*21*/

SELECT *
FROM emple e
order by e.dept_no, e.apellido ;

/*22*/

SELECT e.emp_no , e.apellido 
FROM emple e 
WHERE e.apellido like '%Z' and e.salario > 300000;

/*23*/

SELECT * 
FROM depart d 
WHERE d.loc like 'B%';

/*24*/

SELECT *
FROM emple e 
WHERE e.oficio like 'EMPLEADO' and e.salario > 100000
and e.dept_no = 10;

/*25*/

SELECT e.apellido 
FROM emple e 
WHERE e.comision is null or e.comision = 0;

/*26*/

SELECT e.apellido 
FROM emple e 
WHERE (e.comision is null or e.comision = 0)
and e.apellido like 'J%';

/*27*/

SELECT e.apellido 
FROM emple e 
WHERE e.oficio in ('VENDEDOR', 'ANALISTA', 'EMPLEADO');

/*28*/

SELECT e.apellido 
FROM emple e 
WHERE e.oficio != 'ANALISTA' or e.oficio != 'EMPLEADO' and e.salario > 200000;

/*29*/

SELECT *
FROM emple e 
WHERE e.salario BETWEEN 2000000 and 3000000;

/*30*/

SELECT e.apellido , e.salario , e.dept_no 
FROM emple e 
WHERE e.salario >200000 and e.dept_no=10 or e.dept_no=30;

/*31*/

SELECT e.apellido , e.emp_no 
FROM emple e 
WHERE e.salario not BETWEEN 100000 and 200000;

/*32*/

SELECT lower(e.apellido)
FROM emple e;

/*33*/

SELECT e.apellido ||' Se dedica a '|| e.oficio 
FROM emple e;

/*34*/

SELECT e.apellido , LENGTH (e.apellido)
FROM emple e 
order by LENGTH(e.apellido)  ;

/*35*/

SELECT  year(e.fecha_alt)
FROM emple e;

/*36*/

SELECT *
FROM emple e 
WHERE year(e.fecha_alt)=1992 ;

/*37*/

SELECT *
FROM emple e 
WHERE MONTHNAME(e.fecha_alt)='February' ;

/*38*/

SELECT 
FROM emple e 
WHERE ;

/*39*/

SELECT *
FROM emple e 
WHERE e.apellido like 'A%' and year(e.fecha_alt)=1990;

/*40*/

SELECT *
FROM emple e 
WHERE e.comision is null or e.comision = 0;



















































































































