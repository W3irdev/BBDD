/*1. Realiza un procedimiento que reciba un número de departamento 
 * y muestre por pantalla su
nombre y localidad. */

CREATE OR REPLACE PROCEDURE info_dept(departamento NUMBER)
AS 
	nombre_dept varchar2(30);
	localidad_dept varchar2(30);
	no_existe_departamento EXCEPTION;
BEGIN 
	
	SELECT d.DNAME INTO nombre_dept
	FROM DEPT d 
	WHERE d.DEPTNO = departamento;

	SELECT d.LOC INTO localidad_dept
	FROM DEPT d 
	WHERE d.DEPTNO = departamento;

	IF SQL%notfound THEN
		raise no_existe_departamento;
	WHEN no_existe_departamento THEN
		dbms_output.put_line('No existen datos');
	WHEN OTHERS THEN
		dbms_output.put_line('Error inesperado');*/

	DBMS_OUTPUT.PUT_LINE(nombre_dept || ', ' || localidad_dept);

	/*EXCEPTION
		WHEN NO_data_found THEN
		dbms_output.put_line('No existen datos');
		WHEN OTHERS THEN
			dbms_output.put_line('Error inesperado');*/
	
END;


BEGIN
	info_dept(10);
END;

/*2. Realiza una función devolver_sal que reciba un nombre de departamento y devuelva la suma
de sus salarios. */

CREATE OR REPLACE FUNCTION total_salario(nom_dept varchar2) RETURN NUMBER 
AS 
	total_salario NUMBER;
BEGIN
	SELECT sum(e.SAL) INTO total_salario
	FROM DEPT d, EMP e 
	WHERE d.DEPTNO = e.DEPTNO 
	AND d.DNAME LIKE nom_dept;
	
	RETURN total_salario;	
	
END;

SELECT total_salario('ACCOUNTING') FROM dual;

/*3. Realiza un procedimiento MostrarAbreviaturas que muestre las tres primeras letras del
nombre de cada empleado.*/

CREATE OR REPLACE PROCEDURE MostrarAbreviaturas
AS 
	CURSOR empleados IS
		SELECT e.ENAME 
		FROM EMP e;
	abreviatura varchar2(3);
BEGIN
	FOR empleado IN empleados LOOP
		abreviatura := substr(empleado.ENAME, 0, 3);
		DBMS_OUTPUT.PUT_LINE(abreviatura);
	END LOOP;
END;


BEGIN
	 MostrarAbreviaturas;
END;

/*4. Realiza un procedimiento que reciba un número de departamento y muestre una lista de sus
empleados.*/

CREATE OR REPLACE PROCEDURE list_empleados(num_dept NUMBER)
AS 
	CURSOR empleados is
	SELECT e.*
	FROM DEPT d , EMP e 
	WHERE d.DEPTNO = e.DEPTNO 
	AND e.DEPTNO = num_dept;

BEGIN 
	FOR empleado IN empleados LOOP
		DBMS_OUTPUT.PUT_LINE (empleado.EMPNO || ', ' || empleado.ENAME || ', ' || empleado.JOB);
	END LOOP;
	
END;

BEGIN
	list_empleados(10);
END;


/*5. Realiza un procedimiento MostrarJefes que reciba el nombre de un departamento y muestre
los nombres de los empleados de ese departamento que son jefes de otros empleados.Trata las
excepciones que consideres necesarias.*/

CREATE OR REPLACE PROCEDURE EMPLEADOS.MostrarJefes (nom_dept dept.DNAME%type)
AS 
	CURSOR jefe (c_nom_dept dept.DNAME%type) IS 
		SELECT DISTINCT e.ENAME
		FROM DEPT d , EMP e , EMP e2 
		WHERE d.DEPTNO = e.DEPTNO AND e2.MGR = e.EMPNO 
		AND d.DNAME LIKE c_nom_dept;
	noData EXCEPTION;
	nombre varchar2(40);
	resultado NUMBER;
	
BEGIN 
	
	SELECT d.DNAME INTO nombre
	FROM DEPT d 
	WHERE d.DNAME LIKE nom_dept;

	SELECT count(e.MGR) INTO resultado
	FROM EMP e, EMP e2 , DEPT d 
	WHERE e.EMPNO = e2.MGR AND d.DEPTNO = e.DEPTNO AND d.DNAME LIKE nom_dept;

IF SQL%NOTFOUND OR SQL%rowcount < 1 OR resultado =0 THEN
	raise noData;
END IF;

	FOR i IN jefe(nom_dept) LOOP
		IF i.ENAME IS NULL OR SQL%notfound THEN
			raise noData;
		ELSE 
			DBMS_OUTPUT.PUT_LINE (i.ENAME);
		END IF;
		
		
	END LOOP;

	EXCEPTION
		WHEN noData OR NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE ('No existe jefe');
	
END;


BEGIN
	MostrarJefes('OPERATIONS');
END;


/*6. Hacer un procedimiento que muestre el nombre y 
 * el salario del empleado cuyo código es
7082*/

CREATE OR REPLACE PROCEDURE MOSTRAR_INFO
AS 
nombre EMP.ENAME%TYPE;
salario EMP.SAL%TYPE;
noData EXCEPTION;

BEGIN 
	SELECT e.ENAME , e.SAL INTO nombre, salario
	FROM EMP e 
	WHERE e.EMPNO = 7082;

	DBMS_OUTPUT.PUT_LINE (nombre || ' ' || salario);

	EXCEPTION
		WHEN noData OR NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE ('No existe');
		
		
END;

BEGIN
	MOSTRAR_INFO;
END;


/*7. Realiza un procedimiento llamado HallarNumEmp 
 * que recibiendo un nombre de departamento, muestre 
 * en pantalla el número de empleados de dicho 
 * departamento
Si el departamento no tiene empleados deberá mostrar 
un mensaje informando de ello. Si el
departamento no existe se tratará la excepción 
correspondiente.*/

CREATE OR REPLACE PROCEDURE HallarNumEmp(dept varchar2)
AS 
numEmp NUMBER;
noData EXCEPTION;
BEGIN 
	SELECT count(e.EMPNO) INTO numEmp
	FROM DEPT d , EMP e 
	WHERE d.DEPTNO = e.DEPTNO 
	AND d.DNAME  LIKE dept;
	
	IF numEmp=0 THEN
		raise noData;
	ELSE
		DBMS_OUTPUT.PUT_LINE(numEmp);
	END IF;

	
	EXCEPTION
		WHEN noData THEN
			DBMS_OUTPUT.PUT_LINE ('No tiene empleados');
	

	
	
END;

BEGIN
	HallarNumEmp('SALES');
END;


/*8. Hacer un procedimiento que reciba como parámetro 
 * un código de empleado y devuelva su
nombre.*/

CREATE OR REPLACE
PROCEDURE nombre_emp(COD NUMBER)
AS
NOMBRE EMP.ENAME%TYPE;

NODATA EXCEPTION;
BEGIN
	SELECT
	E.ENAME
INTO
	NOMBRE
FROM
	EMP e
WHERE
	E.EMPNO = COD;

IF COD IS NULL
OR COD LIKE '' THEN
RAISE NODATA;
ELSE
DBMS_OUTPUT.PUT_LINE(NOMBRE);
END IF;

EXCEPTION
	WHEN NODATA OR NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('No se encuentra ese empleado');
END;
BEGIN
	NOMBRE_EMP(7369);
END;

/*9. Codificar un procedimiento que reciba una cadena y la visualice al revés. */

CREATE OR REPLACE PROCEDURE rever(CADENA VARCHAR2)
AS 
    CADENA2 VARCHAR2(100);
BEGIN
    FOR CARACTER IN REVERSE 1..LENGTH(CADENA)
    LOOP
        CADENA2 := CADENA2||SUBSTR(CADENA,CARACTER,1);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(CADENA2);
END;

CREATE OR REPLACE FUNCTION  reverseFun(CADENA VARCHAR2)
RETURN varchar2
AS 
    CADENA2 VARCHAR2(100);
BEGIN
    FOR CARACTER IN REVERSE 1..LENGTH(CADENA)
    LOOP
        CADENA2 := CADENA2||SUBSTR(CADENA,CARACTER,1);
    END LOOP;
    RETURN CADENA2;
END;

BEGIN
	dbms_output.put_line(reverseFun('HOLA'));
    
END;

/*10. Escribir un procedimiento que reciba una fecha y escriba el año, 
 * en número, correspondiente a esa fecha. */

CREATE OR REPLACE PROCEDURE recibiryear(fecha date)
AS 
BEGIN 
	dbms_output.put_line(EXTRACT(YEAR FROM fecha));
END;

BEGIN
	RECIBIRYEAR(TO_DATE('20/07/1992', 'DD/MM/YYYY'));
END;

/*11. Realiza una función llamada CalcularCosteSalarial que reciba un nombre
 *  de departamento y devuelva la suma de los salarios y comisiones de los 
 * empleados de dicho departamento.*/

CREATE OR REPLACE FUNCTION CalcularCosteSalarial(depart varchar2) RETURN NUMBER 
AS 
	total NUMBER;
	departamentos NUMBER;
	noDepart EXCEPTION;

BEGIN 
	
	SELECT count(d.DNAME) int departamentos
	FROM DEPT d 
	WHERE d.DNAME LIKE depart;

	IF departamentos = 0 THEN
		raise noDepart;
	END IF;
	
	SELECT sum(e.sal+e.COMM) INTO total
	FROM DEPT d , EMP e 
	WHERE d.DEPTNO = e.DEPTNO 
	AND d.DNAME like depart;
	RETURN total;

	EXCEPTION
		WHEN noDepart THEN
			dbms_OUToput.put_line('No existe departamento');
			RETURN -1;
END;

CREATE OR REPLACE FUNCTION EMPLEADOS.CalcularCosteSalarial2(depart varchar2) RETURN NUMBER 
AS 
	total NUMBER;
	departamentos NUMBER;
	noDepart EXCEPTION;

BEGIN 
	
	SELECT count(d.DNAME) into departamentos
	FROM DEPT d 
	WHERE d.DNAME LIKE depart;

	IF departamentos = 0 THEN
		raise_application_error(-20001, 'No existe ese departamento');
		RETURN -1;
	END IF;
	
	SELECT sum(e.sal+e.COMM) INTO total
	FROM DEPT d , EMP e 
	WHERE d.DEPTNO = e.DEPTNO 
	AND d.DNAME like depart;
	RETURN total;


END;


BEGIN
	dbms_output.put_line(CalcularCosteSalarial2('SALES'));
END;


/*12. Codificar un procedimiento que permita borrar un empleado cuyo número 
 * se pasará en la llamada. Si no existiera dar el correspondiente mensaje 
 * de error.*/

CREATE OR REPLACE PROCEDURE borrarEmp(empno NUMBER)
AS 
	noData EXCEPTION;
	aborrar NUMBER := empno;
	demasiados EXCEPTION;
BEGIN
		DELETE FROM emp e
		WHERE e.EMPNO  = aborrar;

	IF SQL%NOTFOUND THEN
		raise noData;
	ELSIF SQL%rowcount>1 THEN
		raise demasiados;
	END IF;
	
	
	EXCEPTION
		WHEN noData OR no_data_found THEN 
			DBMS_OUTPUT.PUT_LINE('No se encuentra ese empleado');
		WHEN demasiados THEN 
			DBMS_OUTPUT.PUT_LINE('Ha eliminado mas de la cuenta');
END;

BEGIN
	borrarEmp(1111);
END;

	
/*13. Realiza un procedimiento MostrarCostesSalariales que muestre los
 *  nombres de todos los departamentos y el coste salarial de cada uno 
 * de ellos*/

CREATE OR REPLACE PROCEDURE MostrarCostesSalariales
AS 
	CURSOR costes IS 
		SELECT d.DNAME AS nombre, sum(e.SAL+NVL(e.COMM,0)) AS suma
		FROM DEPT d , EMP e 
		WHERE d.DEPTNO = e.DEPTNO
		GROUP BY d.DNAME  ;
BEGIN 
	
	FOR coste IN costes LOOP
		dbms_output.put_line(coste.nombre||': '||coste.suma);
	END LOOP;
	

END;

BEGIN
	MostrarCostesSalariales;
END;

/*14. Escribir un procedimiento que modifique la localidad de un 
 * departamento. El procedimiento recibirá como parámetros el número
 *  del departamento y la localidad nueva. */

CREATE OR REPLACE PROCEDURE modLocalidad(deptn NUMBER, localidad varchar2)
AS 
	noData EXCEPTION ;
BEGIN 
	UPDATE DEPT SET LOC = localidad WHERE DEPTNO = deptn;

	IF SQL%ROWCOUNT=0 THEN
		raise noData;
	ELSE
		dbms_output.put_line('Se ha actualizado con exito');
	END IF;

	EXCEPTION
		WHEN noData OR NO_DATA_FOUND THEN 
			dbms_output.put_line('No existe ese departamento');
	
END;

BEGIN
	modLocalidad(10, 'NEW YORK');
END;


/*15. Realiza un procedimiento MostrarMasAntiguos que muestre el nombre del empleado más
antiguo de cada departamento junto con el nombre del departamento. Trata las excepciones
que consideres necesarias.*/

CREATE OR REPLACE PROCEDURE MostrarMasAntiguos
AS 
	noData EXCEPTION;
	CURSOR veteranos IS
			SELECT DISTINCT d.DNAME AS departamento, e.ENAME AS nombre
			FROM EMP e, DEPT d  
			WHERE e.DEPTNO = d.DEPTNO AND e.HIREDATE IN (SELECT min(e.HIREDATE)
								FROM EMP e , DEPT d 
								WHERE e.DEPTNO = d.DEPTNO 
								GROUP BY d.DNAME );

BEGIN 


	FOR veterano IN veteranos LOOP
	dbms_output.put_line('Departamento: '||veterano.departamento||' Nombre: '||veterano.nombre);
	END LOOP;

	
END;

BEGIN
	MostrarMasAntiguos;
END;








