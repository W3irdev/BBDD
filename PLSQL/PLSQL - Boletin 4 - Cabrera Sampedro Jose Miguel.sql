/*5.6.1. Desarrolla el paquete ARITMETICA cuyo código fuente viene en este tema.
Crea un archivo para la especi(cación y otro para el cuerpo. Realiza varias pruebas
para comprobar que las llamadas a funciones y procedimiento funcionan
correctamente.*/

CREATE OR REPLACE
PACKAGE aritmetica IS
  version NUMBER := 1.0;

  PROCEDURE mostrar_info;
  FUNCTION suma       (a NUMBER, b NUMBER) RETURN NUMBER;
  FUNCTION resta      (a NUMBER, b NUMBER) RETURN NUMBER;
  FUNCTION multiplica (a NUMBER, b NUMBER) RETURN NUMBER;
  FUNCTION divide     (a NUMBER, b NUMBER) RETURN NUMBER;
END aritmetica;


CREATE OR REPLACE
PACKAGE BODY aritmetica IS

  PROCEDURE mostrar_info IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE
      ('Paquete de operaciones aritméticas. Versión ' || version);
  END mostrar_info;

  FUNCTION suma       (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a+b);
  END suma;

  FUNCTION resta      (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a-b);
  END resta;

  FUNCTION multiplica (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a*b);
  END multiplica;

  FUNCTION divide     (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a/b);
  END divide;
 
  FUNCTION resto (a NUMBER, b NUMBER) RETURN NUMBER IS
 BEGIN
	 RETURN MOD(a,b);
 END;

END aritmetica;

BEGIN
	ARITMETICA.MOSTRAR_INFO;
	
END;
	SELECT ARITMETICA.SUMA(2, 5) FROM dual;

/*5.6.2. Al paquete anterior añade una función llamada RESTO que reciba dos
parámetros, el dividendo y el divisor, y devuelva el resto de la división.*/

--Añadimos FUNCTION resto (a NUMBER, b NUMBER) RETURN NUMBER; a las declaraciones
 /*FUNCTION resto (a NUMBER, b NUMBER) RETURN NUMBER IS
 BEGIN
	 RETURN MOD(a,b);
 END;*/

SELECT ARITMETICA.RESTO(11, 4) FROM dual;


/*5.6.3. Al paquete anterior añade un procedimiento sin parámetros llamado AYUDA
que muestre un mensaje por pantalla de los procedimientos y funciones disponibles
en el paquete, su utilidad y forma de uso.*/

--   PROCEDURE ayuda; en declaracion 

/*  PROCEDURE ayuda IS
  BEGIN
	  DBMS_OUTPUT.PUT_LINE('ARITMETICA.MOSTRAR_INFO muestra la version del paquete');
	  DBMS_OUTPUT.PUT_LINE('ARITMETICA.SUMA(NUMERO1, NUMERO2), devuelve la suma');
	  DBMS_OUTPUT.PUT_LINE('ARITMETICA.RESTA(NUMERO1, NUMERO2), devuelve la RESTA');
	  DBMS_OUTPUT.PUT_LINE('ARITMETICA.MULTIPLICA(NUMERO1, NUMERO2), devuelve la multiplicacion');
	  DBMS_OUTPUT.PUT_LINE('ARITMETICA.DIVIDE(NUMERO1, NUMERO2), devuelve la division');
	  DBMS_OUTPUT.PUT_LINE('ARITMETICA.RESTO(NUMERO1, NUMERO2), devuelve el resto');
  END;*/

/*5.6.4. Desarrolla el paquete GESTION. En un principio tendremos los
procedimientos para gestionar los departamentos. Dado el archivo de
especi(cación mostrado más abajo crea el archivo para el cuerpo. Realiza varias
pruebas para comprobar que las llamadas a funciones y procedimientos funcionan
correctamente.*/

CREATE OR REPLACE PACKAGE GESTION AS 
 PROCEDURE CREAR_DEP (nombre VARCHAR2, presupuesto NUMBER);
 FUNCTION NUM_DEP (nombre VARCHAR2) RETURN NUMBER;
 PROCEDURE MOSTRAR_DEP (numero NUMBER);
 PROCEDURE BORRAR_DEP (numero NUMBER);
 PROCEDURE MODIFICAR_DEP (numero NUMBER, presupuesto NUMBER);
END;

CREATE OR REPLACE PACKAGE BODY GESTION
IS 

	CREATE OR REPLACE PROCEDURE CREAR_DEP (nombre VARCHAR2, presupuesto NUMBER)
	AS 
	BEGIN 
		INSERT INTO DEPARTAMENTOS d (d.PRESU, d.NOMDE) values(presupuesto, nombre);
	END;
	
	CREATE OR REPLACE FUNCTION num_dept (nombre varchar2) RETURN NUMBER AS 
		num_dept NUMBER;
	BEGIN 
		SELECT d.NUMDE INTO num_dept
		FROM DEPARTAMENTOS d 
		WHERE d.NOMDE = nombre;
	
		RETURN num_dept;
	END;
	
	CREATE OR REPLACE PROCEDURE MOSTRAR_DEP (numero NUMBER)
	AS 
		nomdept varchar2(50);
	BEGIN 
		SELECT d.NOMDE INTO nomdept
		FROM DEPARTAMENTOS d 
		WHERE d.NUMDE = numero;
	
		dbms_output.put_line(nomdept);
	END;
	
	CREATE OR REPLACE PROCEDURE BORRAR_DEP (numero NUMBER)
	AS 
	BEGIN 
		
		SAVEPOINT antes;
		
		DELETE FROM DEPARTAMENTOS d WHERE d.NUMDE = numero;
		IF SQL%rowcount=0 THEN
		ROLLBACK;
		END IF;
		
	END;

	CREATE OR REPLACE PROCEDURE MODIFICAR_DEP (numero NUMBER, presupuesto NUMBER)
	AS 
	BEGIN 
		SAVEPOINT antes;
		UPDATE DEPARTAMENTOS d SET d.PRESU = presupuesto WHERE d.NUMDE = numero;
		IF SQL%rowcount=0 THEN
		ROLLBACK;
		END IF;
		
	END;
	
END;
	

