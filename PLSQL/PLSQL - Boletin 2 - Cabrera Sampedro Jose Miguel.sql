/*1. Escribe un procedimiento que muestre el número de empleados y el salario
mínimo, máximo y medio del departamento de FINANZAS. Debe hacerse 
uso de cursores implícitos, es decir utilizar SELECT ... INTO*/

CREATE OR REPLACE PROCEDURE finanzas_info
AS 
	num_empleados NUMBER;
	salario_minimo NUMBER;
	salario_maximo NUMBER;
	salario_medio NUMBER;

BEGIN 
	SELECT count(e.NUMEM), MIN(e.SALAR), MAX(e.SALAR), AVG(e.SALAR) 
	INTO num_empleados, salario_minimo, salario_maximo, salario_medio
	FROM EMPLEADOS e , DEPARTAMENTOS d 
	WHERE e.NUMDE = d.NUMDE
	AND d.NOMDE LIKE 'FINANZAS';

	DBMS_OUTPUT.PUT_LINE (num_empleados);
	DBMS_OUTPUT.PUT_LINE (salario_minimo);
	DBMS_OUTPUT.PUT_LINE (salario_maximo);
	DBMS_OUTPUT.PUT_LINE (salario_medio);
	
END;

BEGIN
	finanzas_info;
END;


/*2. Escribe un procedimiento que suba un 10% el salario a los EMPLEADOS 
con más de 2 hijos y que ganen menos de 2000 €. Para cada empleado se 
mostrar por pantalla el código de empleado, nombre, salario anterior y final. 
Utiliza un cursor explícito. La transacción no puede quedarse a medias. Si 
por cualquier razón no es posible actualizar todos estos salarios, debe 
deshacerse el trabajo a la situación inicial.*/

CREATE OR REPLACE PROCEDURE SUBIR_SALARIO
AS 
	CURSOR requisitos IS 
	SELECT NUMEM , NOMEM , SALAR 
	FROM EMPLEADOS e 
	WHERE e.NUMEM >2 AND e.SALAR < 2000;
	antiguo NUMBER;
	
BEGIN 
	
	FOR i IN requisitos LOOP
		antiguo := i.SALAR;
		DBMS_OUTPUT.PUT_LINE ('Codigo: ' || i.NUMEM);
		DBMS_OUTPUT.PUT_LINE ('Nombre: ' || i.NOMEM);
		DBMS_OUTPUT.PUT_LINE ('Salario anterior: ' || antiguo);
		DBMS_OUTPUT.PUT_LINE ('Salario nuevo: ' || antiguo*1.10);
		UPDATE EMPLEADOS SET SALAR = SALAR * 1.10 WHERE NUMEM = i.NUMEM;
		DBMS_OUTPUT.PUT_LINE (' ');
	
	
	END LOOP;
	

END;

BEGIN SUBIR_SALARIO;
END;

CREATE OR REPLACE
PROCEDURE Subir_salarios is
  CURSOR c IS
    SELECT NUMEM, NOMEM, SALAR
    FROM EMPLEADOS WHERE NUMHI > 2 AND SALAR < 2000;
 
   sal_nuevo NUMBER;
BEGIN
  FOR registro IN c LOOP
    sal_nuevo := registro.SALAR*1.10;
  
    UPDATE EMPLEADOS SET SALAR = sal_nuevo
    WHERE NUMEM = registro.NUMEM;

    IF SQL%NOTFOUND THEN
      DBMS_OUTPUT.PUT_LINE('Actualización no completada');
    END IF;
DBMS_OUTPUT.PUT_LINE(registro.NUMEM || ' ' || registro.NOMEM
      || ' : ' || registro.SALAR || ' --> ' || sal_nuevo);
  END LOOP;
  COMMIT;
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
END subir_salarios;

BEGIN Subir_salarios;
END;
     
/*3. Escribe un procedimiento que reciba dos parámetros (número de
departamento, hijos). Deber. crearse un cursor explícito al que se le pasarán 
estos parámetros y que mostrar. los datos de los empleados que pertenezcan 
al departamento y con el número de hijos indicados. Al final se indicar. el 
número de empleados obtenidos*/

CREATE OR REPLACE PROCEDURE NUM_EMPLEADOS(NUM_DEPARTAMENTO NUMBER, NUM_HIJOS NUMBER)
AS 
	CURSOR EMPLEADOS_FILTRO 
	IS 
	SELECT *
	FROM EMPLEADOS e 
	WHERE e.NUMDE = NUM_DEPARTAMENTO AND e.NUMHI = NUM_HIJOS;
	
	NUM_EMPLEADOS NUMBER :=0;

BEGIN 
	FOR empleado IN EMPLEADOS_FILTRO LOOP
		DBMS_OUTPUT.PUT_LINE ('Codigo: ' || empleado.NUMEM);
		DBMS_OUTPUT.PUT_LINE ('Extension: ' || empleado.EXTEL);
		DBMS_OUTPUT.PUT_LINE ('Fecha Nacimiento: ' || empleado.FECNA);
		DBMS_OUTPUT.PUT_LINE ('Fecha Incorporacion: ' || empleado.FECIN);
		DBMS_OUTPUT.PUT_LINE ('Salario: ' || empleado.SALAR);
		DBMS_OUTPUT.PUT_LINE ('Comision: ' || empleado.COMIS);
		DBMS_OUTPUT.PUT_LINE ('Cantidad Hijos: ' || empleado.NUMHI);
		DBMS_OUTPUT.PUT_LINE ('Nombre: ' || empleado.NOMEM);
		DBMS_OUTPUT.PUT_LINE ('Departamento: ' || empleado.NUMDE);
		DBMS_OUTPUT.PUT_LINE (' ');
	
		NUM_EMPLEADOS := NUM_EMPLEADOS + 1;
	
		
	END LOOP;
	DBMS_OUTPUT.PUT_LINE ('Total encontrados: ' || NUM_EMPLEADOS);
	
	
	
END;

BEGIN 
	NUM_EMPLEADOS(100, 2);
END;

/
CREATE OR REPLACE
PROCEDURE Dpto_Empleados_Hijos (numero EMPLEADOS.NUMDE%TYPE,hijos  EMPLEADOS.NUMHI%TYPE )
AS
  CURSOR c(c_numero EMPLEADOS.NUMDE%TYPE, c_hijos EMPLEADOS.NUMHI%TYPE) IS
    SELECT NUMEM, NOMEM, NUMHI, NUMDE
    FROM EMPLEADOS WHERE NUMDE = c_numero AND NUMHI = c_hijos;
   
  contador NUMBER;

BEGIN
  contador := 0;
  FOR registro IN c (numero, hijos) LOOP
    DBMS_OUTPUT.PUT_LINE(registro.NUMEM || ' ' || registro.NOMEM
      || ' ' || registro.NUMHI || ' ' || registro.NUMDE);
contador := contador + 1;
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE(contador || ' Empleados obtenidos');
END Dpto_Empleados_Hijos;

  

/*4. Escribe un procedimiento con un parámetro para el nombre de empleado,
que nos muestre la edad de dicho empleado en años, meses y días*/

CREATE OR REPLACE PROCEDURE MOSTRAR_EDAD(NOMBRE EMPLEADOS.NOMEM%TYPE)
AS 
	CURSOR empleado IS 
		SELECT e.FECNA 
		FROM EMPLEADOS e 
		WHERE e.NOMEM = NOMBRE;
	
	fecha_nacimiento DATE;
	edad_anios NUMBER;
	edad_meses NUMBER;
	edad_dias NUMBER;
BEGIN 
	FOR e IN empleado LOOP
		fecha_nacimiento := e.FECNA;
		edad_anios := TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_nacimiento) / 12);
		edad_meses := TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, fecha_nacimiento), 12));
		edad_dias := TRUNC(MOD(SYSDATE - fecha_nacimiento, 1));
		
		DBMS_OUTPUT.PUT_LINE('La edad de ' || NOMBRE || ' es: ' || edad_anios || ' años, ' || edad_meses || ' meses y ' || edad_dias || ' días');
	END LOOP;
END;

BEGIN MOSTRAR_EDAD('MARIO');
END;

CREATE OR REPLACE
PROCEDURE Edad_Empleado (nombre EMPLEADOS.NOMEM%TYPE) AS
  -- Utilizamos un cursor explícito por si existiese más de un empleado
  -- con el mismo nombre.
  CURSOR c(nom EMPLEADOS.NOMEM%TYPE) IS
    SELECT NOMEM, FECNA
    FROM EMPLEADOS WHERE NOMEM = nom;

  meses NUMBER;
  a     NUMBER;
  m     NUMBER;
  d     NUMBER;

BEGIN
  DBMS_OUTPUT.PUT_LINE('EMPLEADO: AÑOS MESES DÍAS');
  FOR registro IN c(nombre) LOOP
    meses := MONTHS_BETWEEN (SYSDATE, registro.FECNA);
    a := mes
	a := meses/12;
    m := MOD (meses, 12);
    d := (m - TRUNC (m))*30;-- parte decimal de m multiplicada por 30

    DBMS_OUTPUT.PUT_LINE(registro.NOMEM || ':  '
      || TRUNC(a)  || ' ' || TRUNC(m)  || ' ' || TRUNC(d) );
  END LOOP;

END Edad_Empleado;
/
