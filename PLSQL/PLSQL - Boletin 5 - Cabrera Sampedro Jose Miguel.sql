/*1. Crear un procedimiento que en la tabla emp incremente el 
salario el 10% a los empleados que
tengan una comisión superior al 5% del salario. */

CREATE OR REPLACE PROCEDURE incrementar_salario
AS 
	CURSOR requisitos IS 
		SELECT e.EMPNO , e.SAL 
		FROM EMP e 
		WHERE e.COMM > (e.SAL*0.05);

	noData EXCEPTION;
BEGIN 
	
	FOR c_requisito IN requisitos LOOP
		UPDATE EMP e SET e.sal = e.SAL * 1.10 WHERE e.empno = c_requisito.empno;
	END LOOP;
	
	
END;

BEGIN incrementar_salario;
	
END;


/*2. Realiza un procedimiento MostrarMejoresVendedores que muestre los nombres de los dos
vendedores/as con más comisiones.*/

CREATE OR REPLACE PROCEDURE MostrarMejoresVendedores
AS 
	CURSOR c_ordenados IS 
		SELECT e.ENAME , NVL(e.COMM, 0) 
		FROM EMP e 
		ORDER BY NVL(e.COMM, 0) desc ;
	contador NUMBER :=0;

BEGIN 
	FOR i IN c_ordenados LOOP
		IF contador<2 THEN
			dbms_output.put_line(i.ename);
			contador:=contador+1;
		END IF;
		
	END LOOP;
	
END;
	
BEGIN
	MostrarMejoresVendedores;
END;

/*3. Realiza un procedimiento MostrarsodaelpmE que reciba el nombre de un departamento al
revés y muestre los nombres de los empleados de ese departamento.*/

/*
 * CREATE OR REPLACE PROCEDURE MostrarsodaelpmE(DEPARTAMENTO_AL_REVES VARCHAR2) IS
NOMBRE_BIEN VARCHAR2(50);
DEPART_NO_EXISTE EXCEPTION;

	CURSOR C_EJ3 IS
	SELECT E.ENAME
	FROM DEPT d ,EMP e 
	WHERE D.DEPTNO = E.DEPTNO
	AND D.DNAME = REVERSE(DEPARTAMENTO_AL_REVES);

v_deptno dept.deptno%TYPE;
BEGIN
	--Comprobando que existe el departamento pasado por parámetro
	SELECT d.DEPTNO INTO v_deptno from dept d WHERE D.DNAME = REVERSE(DEPARTAMENTO_AL_REVES);
	
	FOR empleados IN C_EJ3
	LOOP
		DBMS_OUTPUT.PUT
DBMS_OUTPUT.PUT_LINE('EMPLEADO: ' || empleados.ENAME);
	END LOOP;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('No existe el departamento');
END;
 * */

CREATE OR REPLACE PROCEDURE MostrarsodaelpmE(deptNom DEPT.DNAME%type)
AS 
	CURSOR c_empleados(departamento dept.DNAME%type) IS 
		SELECT e.ENAME 
		FROM EMP e , DEPT d 
		WHERE d.DEPTNO = e.DEPTNO 
		AND d.DNAME LIKE REVERSE(departamento);
	noData EXCEPTION;
	nombreDepartamento number;
BEGIN 
	SELECT count(d.DNAME) INTO nombreDepartamento
	FROM DEPT d 
	WHERE d.DNAME LIKE REVERSE(deptNom) ;
	
	IF nombreDepartamento = 0 THEN
		raise noData;
	END IF;

	FOR empleado IN c_empleados(deptNom) LOOP
		dbms_output.put_line('Nombre: ' || empleado.ENAME || ' del departamento ' || deptNom);
	END LOOP;
	
	EXCEPTION
		WHEN noData THEN
			dbms_output.put_line('No existe ese departamento');
	
END;

BEGIN
	MostrarsodaelpmE('SALES');
END;



/*4. Realiza un procedimiento RecortarSueldos que recorte el sueldo un 20% a los empleados
cuyo nombre empiece por la letra que recibe como parámetro. Trata las excepciones que
consideres necesarias.*/

CREATE OR REPLACE PROCEDURE RecortarSueldos(inicial varchar2)
AS 
	CURSOR c_emple(ini EMP.ENAME%type) IS 
		SELECT ENAME 
		FROM EMP e 
		WHERE e.ENAME LIKE UPPER(ini)||'%';
BEGIN 
	SAVEPOINT antes;
	
	FOR emple IN c_emple(inicial) LOOP
		UPDATE EMP SET SAL = SAL - (SAL*0.2) WHERE emp.ENAME LIKE emple.ENAME;
	END LOOP;
	
	
	IF SQL%ROWCOUNT=0 THEN
	ROLLBACK;
		
	END IF;
	
END;

BEGIN
	RecortarSueldos('M');
END;


/*5. Realiza un procedimiento BorrarBecarios que borre a los dos empleados más nuevos de cada
departamento.*/

Create or replace procedure BorrarBecarios
is
    cursor c_dept
    is
    select deptno
    from dept;
begin
    for v_dept in c_dept loop
        BorrarDosMasNuevos(v_dept.deptno);
    end loop;
end;

create or replace procedure BorrarDosMasNuevos(p_deptno dept.deptno%type)
is
    cursor c_emp
    is
    select empno
    from emp
    where deptno= p_deptno
    order by hiredate desc;
    v_emp c_emp%rowtype;
begin
    open c_emp;
    fetch c_emp into v_emp;
    while c_emp%found and c_emp%rowcount<=2 loop
        delete emp
        where empno=v_emp.empno;
        fetch c_emp into v_emp;
    end loop;
    close c_emp;
end;