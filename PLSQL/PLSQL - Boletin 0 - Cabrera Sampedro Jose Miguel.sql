-- Salida esperada -> Cierto

BEGIN
 IF 10 > 5 THEN
 DBMS_OUTPUT.PUT_LINE ('Cierto');
 ELSE
 DBMS_OUTPUT.PUT_LINE ('Falso');
 END IF;
END;

-- Salida mostrada -> Cierto

--2. Ejecuta el siguiente bloque. Indica cuál es la salida.

-- Salida esperada -> Cierto

BEGIN
IF 10 > 5 AND 5 > 1 THEN
 DBMS_OUTPUT.PUT_LINE ('Cierto');
ELSE
 DBMS_OUTPUT.PUT_LINE ('Falso');
END IF;
END;

-- Salida mostrada -> Cierto

-- 3. Ejecuta el siguiente bloque. Indica cuál es la salida.

-- Salida esperada -> Falso

BEGIN
IF 10 > 5 AND 5 > 50 THEN
 DBMS_OUTPUT.PUT_LINE ('Cierto');
ELSE
 DBMS_OUTPUT.PUT_LINE ('Falso');
END IF;
END;

-- Salida mostrada -> Falso

--4. Ejecuta el siguiente bloque. Indica cuál es la salida.

-- Salida esperada -> Falso
BEGIN
CASE
 WHEN 10 > 5 AND 5 > 50 THEN
 DBMS_OUTPUT.PUT_LINE ('Cierto');
 ELSE
 DBMS_OUTPUT.PUT_LINE ('Falso');
END CASE;
END;
-- Salida mostrada -> Falso

-- 5. Ejecuta el siguiente bloque. Indica cuál es la salida.
/* Salida esperada -> 
 * 1
 * 2
 * 3
 * 4
 * 5
 * 6
 * 7
 * 8
 * 9
 * 10
 */

BEGIN
 FOR i IN 1..10 LOOP
 DBMS_OUTPUT.PUT_LINE (i);
 END LOOP;
END;

/* Salida mostrada -> 
 * 1
 * 2
 * 3
 * 4
 * 5
 * 6
 * 7
 * 8
 * 9
 * 10
 */

--6. Ejecuta el siguiente bloque. Indica cuál es la salida.

/* Salida esperada -> 
 * 10
 * 9
 * 8
 * 7
 * 6
 * 5
 * 4
 * 3
 * 2
 * 1
 */
BEGIN
 FOR i IN REVERSE 1..10 LOOP
 DBMS_OUTPUT.PUT_LINE (i);
 END LOOP;
END;

/* Salida mostrada -> 
 * 10
 * 9
 * 8
 * 7
 * 6
 * 5
 * 4
 * 3
 * 2
 * 1
 */

--7. Ejecuta el siguiente bloque. Indica cuál es la salida.
/* Salida esperada ->
 * 0
 * 2
 * 4
 * 6
 * 8
 * 10
 * 12... hasta 100
 */
DECLARE
 num NUMBER(3) := 0;
BEGIN
 WHILE num<=100 LOOP
 DBMS_OUTPUT.PUT_LINE (num);
 num:= num+2;
 END LOOP;
END;


--8. Ejecuta el siguiente bloque. Indica cuál es la salida.
/* Salida esperada -> 
 * 0
 * 2
 * 4
 * 6
 * 8-- hasta 100
 */
DECLARE
 num NUMBER(3) := 0;
BEGIN
 LOOP
 DBMS_OUTPUT.PUT_LINE (num);
 IF num > 100 THEN EXIT; END IF;
 num:= num+2;
 END LOOP;
END;

/*Salida mostrada -> 
 * 0
 * 2
 * 4
 * 6
 * 8-- hasta 102*/

--9. Ejecuta el siguiente bloque. Indica cuál es la salida.
/* Salida esperada -> 
 * 0
 * 2
 * 4
 * 6
 * 8.. hasta 102
 */
DECLARE
 num NUMBER(3) := 0;
BEGIN
 LOOP
 DBMS_OUTPUT.PUT_LINE (num);
 EXIT WHEN num > 100;
 num:= num+2;
 END LOOP;
END;

/* Salida mostrada -> 
 * 0
 * 2
 * 4
 * 6
 * 8.. hasta 102
 */

/*1 1. Crea un procedimiento llamado ESCRIBE para mostrar por pantalla el
mensaje HOLA MUNDO.*/

CREATE OR REPLACE PROCEDURE ESCRIBE
AS 
BEGIN 
	dbms_output.put_line('HOLA MUNDO');
END;

BEGIN ESCRIBE; 

END;

/*2. Crea un procedimiento llamado ESCRIBE_MENSAJE que tenga un
parámetro de tipo VARCHAR2 que recibe un texto y lo muestre por pantalla.
La forma del procedimiento ser. la siguiente:
ESCRIBE_MENSAJE (mensaje VARCHAR2)*/

CREATE OR REPLACE PROCEDURE ESCRIBE_MENSAJE (texto varchar2)
AS 
BEGIN 
	dbms_output.put_line(texto);
END;

BEGIN ESCRIBE_MENSAJE('HOLA MUNDO2'); 

END;

/*3. Crea un procedimiento llamado SERIE que muestre por pantalla una serie de
números desde un mínimo hasta un máximo con un determinado paso. La
forma del procedimiento ser. la siguiente:
SERIE (minimo NUMBER, maximo NUMBER, paso NUMBER)*/

CREATE OR REPLACE PROCEDURE SERIE(minimo NUMBER, maximo NUMBER, paso number)
AS 
BEGIN
	
	
	FOR i IN minimo..maximo LOOP 
		IF MOD(i, paso)=0 THEN 
	
		dbms_output.put_line(i);
	END IF;	
	END LOOP;

END;

BEGIN
	SERIE(1, 20, 3);
END;

/*4. Crea una función AZAR que reciba dos parámetros y genere un número al
azar entre un mínimo y máximo indicado. La forma de la función será la
siguiente:
AZAR (minimo NUMBER, maximo NUMBER) RETURN NUMBER*/

CREATE OR REPLACE FUNCTION  AZAR(minimo NUMBER, maximo NUMBER) RETURN NUMBER 
is
BEGIN
	RETURN TRUNC(dbms_random.VALUE(minimo,maximo)) ;
	

END AZAR;




	SELECT AZAR(5, 20) FROM DUAL ;


/*5. Crea una función NOTA que reciba un parámetro que será una nota numérica
entre 0 y 10 y devuelva una cadena de texto con la calificación (Suficiente,
Bien, Notable, ...). La forma de la función será la siguiente:
NOTA (nota NUMBER) RETURN VARCHAR2*/

CREATE OR REPLACE FUNCTION NOTA(nota NUMBER) RETURN VARCHAR2
AS
    mensaje VARCHAR2(20);
BEGIN 
    IF nota >= 0 AND nota <= 10 THEN 
        IF nota = 10 THEN 
            mensaje := 'Sobresaliente';
        ELSIF nota >= 8 AND nota <= 9 THEN 
            mensaje := 'Notable';
        ELSIF nota >= 6 AND nota <= 7 THEN 
            mensaje := 'BIEN';
        ELSIF nota >= 5 THEN 
            mensaje := 'Suficiente';
        ELSE 
            mensaje := 'Insuficiente';
        END IF;
    ELSE 
        mensaje := 'Nota invalida';
    END IF;
    RETURN mensaje;
END NOTA;

SELECT NOTA(5) FROM dual;