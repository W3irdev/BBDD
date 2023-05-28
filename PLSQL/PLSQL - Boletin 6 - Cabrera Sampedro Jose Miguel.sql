/*1	Realizar un procedure que se llame insertar_alumno, que recibirá como parámetro el nombre y 
 * apellido de una persona, e inserte de forma automática esa persona como alumno
 */
CREATE OR REPLACE PROCEDURE insertar_alumno(nombreB varchar2 , apellidoB varchar2)
AS 
dni_persona varchar2(50);
existe NUMBER;
noData EXCEPTION;
esta EXCEPTION;
ID_ALUMNO VARCHAR2(40);
BEGIN 
	SELECT p.DNI INTO dni_persona
	FROM PERSONA p
	WHERE p.NOMBRE LIKE nombreB AND p.APELLIDO LIKE apellidoB;

	SELECT count(*) INTO existe
	FROM ALUMNO a 
	WHERE a.DNI = dni_persona;

	IF existe > 0 THEN
		raise esta;
	END IF;

	SELECT TO_CHAR(MAX(TO_NUMBER(SUBSTR(A.IDALUMNO,2))+1)) INTO ID_ALUMNO

	FROM ALUMNO a;

	INSERT INTO ALUMNO VALUES('A'||ID_ALUMNO,dni_persona); 
	IF SQL%rowcount=0 THEN
		ROLLBACK;
	ELSE
		COMMIT;
	END IF;

	EXCEPTION
		WHEN noData THEN 
			dbms_output.put_line('Algo mal');
		WHEN esta THEN
			dbms_output.put_line('Algo mal2');
END;

INSERT INTO PERSONA p values('47349821C', 'Josemi', 'Cabrera', 'Sevilla', '', 1, 650939828, sysdate, 1);

BEGIN
	insertar_alumno('Josemi', 'Cabrera');
END;

/*2 Realizar una función que reciba como parámetro el nombre y el apellido de 
 una persona, también debe recibir un parámetro que podrá ser un 1 
 (en ese caso debe insertarlo como un alumno) o un 2 (debe insertarlo como profesor), 
 y un parámetro de entrada salida en el que deberá devolver el código del profesor o 
 alumno insertado. La función deberá devolver un 1 si se ha podido realizar la 
 inserción, y un cero si ha ocurrido algún error.*/

CREATE OR REPLACE function UNIVERSIDAD.insertarPersona(nombre varchar2 , apellido varchar2, opcion NUMBER, codigo IN OUT varchar2) RETURN number
AS 
dni_persona varchar2(50);
existe NUMBER;
noData EXCEPTION;
esta EXCEPTION;
codigo VARCHAR2(40);
BEGIN 
	SELECT p.DNI INTO dni_persona
	FROM PERSONA p
	WHERE p.NOMBRE LIKE nombre AND p.APELLIDO LIKE apellido;

	SELECT count(*) INTO existe
	FROM PROFESOR p  
	WHERE p.DNI = dni_persona;

	SELECT count(*) INTO existe
	FROM ALUMNO a  
	WHERE a.DNI = dni_persona;

	IF existe > 0 THEN
		raise esta;
	END IF;

	
	IF opcion = 1 THEN
		SELECT TO_CHAR(MAX(TO_NUMBER(SUBSTR(a.IDALUMNO ,2))+1)) INTO codigo FROM ALUMNO a ;
		codigo:='A'||codigo,dni_persona;
		INSERT INTO ALUMNO a VALUES('A'||codigo,dni_persona); 
		
	ELSIF opcion = 2 THEN
		SELECT TO_CHAR(MAX(TO_NUMBER(SUBSTR(P.IDPROFESOR,2))+1)) INTO codigo FROM PROFESOR p ;
		codigo:='P'||codigo,dni_persona;
		INSERT INTO PROFESOR VALUES('P'||codigo,dni_persona); 
	END IF;
	
	IF SQL%rowcount=0 THEN
		ROLLBACK;
		RETURN -1;
	ELSE
		COMMIT;
		RETURN 1;
	END IF;

	EXCEPTION
		WHEN noData THEN 
			dbms_output.put_line('Algo mal');
		WHEN esta THEN
			dbms_output.put_line('Algo mal2');
END;

CREATE OR REPLACE FUNCTION insertar_persona(
  nombre_introducido IN VARCHAR2,
  apellido_introducido IN VARCHAR2,
  tipo IN NUMBER,
  codigo IN OUT VARCHAR2
) RETURN NUMBER AS
  dni VARCHAR2(11);
BEGIN
  -- Generar un DNI aleatorio para la persona
  dni := LPAD(TRUNC(DBMS_RANDOM.VALUE(10000000, 99999999)), 11, '0');

  -- Insertar la persona en la tabla
  INSERT INTO persona (dni, nombre, apellido)
  VALUES (dni, nombre_introducido, apellido_introducido);


IF tipo = 1 THEN
    -- Insertar como alumno
    INSERT INTO alumno (idalumno, dni)
    VALUES (LPAD(TRUNC(DBMS_RANDOM.VALUE(1000000, 9999999)), 7, '0'), dni);
    codigo := 'ALUMNO_' || dni;  -- Asignar el código del alumno
  ELSIF tipo = 2 THEN
    -- Insertar como profesor
    INSERT INTO profesor (idprofesor, dni)
    VALUES (LPAD(TRUNC(DBMS_RANDOM.VALUE(1000, 9999)), 4, '0'), dni);
    codigo := 'PROFESOR_' || dni;  -- Asignar el código del profesor
  ELSE
    -- Tipo no válido
    codigo := '';
    RETURN 0;
  END IF;

  COMMIT;
  RETURN 1;  -- Inserción exitosa
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    codigo := '';
    RETURN 0;  -- Error al insertar
END;


/*3 Crear un procedure para que se llame tres o más veces a la función anterior, mostrando el mensaje “El alumno XXXX ha sido insertado”, o 
 * “El alumno XXXX no ha sido insertado, y lo mismo con profesores donde XXXX será el dato concreto.*/



/*4 Realizar una función que devuelva un uno o un cero, si el alumno con dni que se le pasa como argumento está matriculado en la asignatura cuyo nombre se le
  pasa también como argumento. La función también deberá tener un parámetro de entrada salida en donde se devuelva el nombre y apellido del profesor que le da 
  clase en esa asignatura, si el alumno está matriculado. Procedure o bloque anónimo para comprobar que funciona.*/

CREATE OR REPLACE FUNCTION estaMatriculado(dni_v varchar2, asignatura_v varchar2, nombreApellidoProf IN OUT varchar2) RETURN NUMBER 
AS 
id_alu varchar2(7);
id_asignatura varchar2(6);
estaMatriculado NUMBER;
BEGIN 
	
	SELECT a.IDALUMNO INTO id_alu
	FROM ALUMNO a
	WHERE a.DNI = dni_v;

	SELECT a.IDASIGNATURA INTO id_asignatura
	FROM ASIGNATURA a 
	WHERE a.NOMBRE LIKE asignatura_v;
	
	SELECT count(*) INTO estaMatriculado
	FROM ALUMNO_ASIGNATURA aa 
	WHERE aa.IDALUMNO LIKE id_alu AND aa.IDASIGNATURA LIKE id_asignatura;
	
	IF estaMatriculado>0 THEN
	
	SELECT p.NOMBRE || ' ' || p.APELLIDO INTO nombreApellidoProf
	FROM PERSONA p , PROFESOR p2 , ASIGNATURA a 
	WHERE p.DNI = p2.DNI AND p2.IDPROFESOR = a.IDASIGNATURA ;
	
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;


END;

DECLARE
	nombreApellidoProf varchar2(20);
	resultado NUMBER;
BEGIN
	resultado:=estaMatriculado('24242424A','Quimica Fisica', nombreApellidoProf);

	dbms_output.put_line(resultado);
dbms_output.put_line(nombreApellidoProf);
END;

/*5 Realizar una función que devuelva un 1 si el nombre y apellido de la persona que se le pasa por parámetro es un alumno, 
 * un dos si es un profesor y un 0 si no está en la base de datos.
  */

CREATE OR REPLACE FUNCTION EXISTE(NOMBRE_V VARCHAR2, APELLIDO_V VARCHAR2)
RETURN NUMBER
IS 
    estaAlu NUMBER;
    estaPro NUMBER;
    NUM NUMBER :=0;
BEGIN 

    SELECT COUNT(P2.DNI) INTO estaPro
    FROM PERSONA p, PROFESOR p2 
    WHERE P.DNI = P2.DNI
    AND P.NOMBRE LIKE NOMBRE_V
    AND P.APELLIDO LIKE APELLIDO_V;

    SELECT COUNT(a.DNI) INTO estaAlu
    FROM PERSONA p, ALUMNO a 
    WHERE P.DNI = A.DNI
    AND P.NOMBRE LIKE NOMBRE_V
    AND P.APELLIDO LIKE APELLIDO_V;

    IF estaAlu > 0 AND estaPro = 0 THEN
        NUM := 1;
    ELSIF estaPro > 0 THEN
        NUM := 2;
    END IF;

    RETURN NUM;
END;

SELECT existe('Juan','Sanchez') FROM dual;

/*6 */

CREATE OR REPLACE PROCEDURE ADD_ASIGNATURA (titulo_V VARCHAR2, asignatura_V VARCHAR2, profesor_V VARCHAR2, profesor_Apellido VARCHAR2)
IS 
	EXISTE_TITULACION NUMBER;
	EXISTE_PERSONA NUMBER;
	PERSONA_ES_PROFESOR NUMBER;
	EXISTE_ASIG NUMBER;
	COD_ASIGNATURA VARCHAR2(50);
	ID_PROFESOR VARCHAR2(50);
	ID_TITU VARCHAR2(50);
BEGIN 
	
	SELECT COUNT(P.DNI) INTO EXISTE_PERSONA
	FROM PERSONA p
	WHERE P.NOMBRE LIKE profesor_V
	AND P.APELLIDO LIKE profesor_Apellido;

	SELECT COUNT(T.IDTITULACION) INTO EXISTE_TITULACION
	FROM TITULACION t 
	WHERE T.NOMBRE LIKE titulo_V;

	SELECT COUNT(P.DNI) INTO PERSONA_ES_PROFESOR
	FROM PERSONA p, PROFESOR p2 
	WHERE P.DNI = P2.DNI 
	AND P.NOMBRE LIKE profesor_V
	AND P.APELLIDO LIKE profesor_Apellido;

	SELECT COUNT(A.IDASIGNATURA) INTO EXISTE_ASIG
	FROM ASIGNATURA a 
	WHERE A.NOMBRE LIKE asignatura_V;

	IF EXISTE_PERSONA = 0 THEN
		RAISE_APPLICATION_ERROR(-20001, 'No existe persona');
	ELSIF EXISTE_TITULACION = 0 THEN 
		RAISE_APPLICATION_ERROR(-20002, 'No existe titulacion');
	ELSIF PERSONA_ES_PROFESOR = 0 THEN 
		RAISE_APPLICATION_ERROR(-20003, 'Esa persona no es profesor');	
	ELSIF EXISTE_ASIG > 0 THEN 
		RAISE_APPLICATION_ERROR(-20004, 'Esa asignatura ya existe en la base de datos');
	ELSE
		SELECT TO_CHAR(MIN(TO_NUMBER(A.IDASIGNATURA)+1)) INTO COD_ASIGNATURA
		FROM ASIGNATURA a;
		
		SELECT P2.IDPROFESOR INTO ID_PROFESOR
		FROM PERSONA p, PROFESOR p2 
		WHERE P.DNI = P2.DNI 
		AND P.NOMBRE LIKE profesor_V
		AND P.APELLIDO LIKE profesor_Apellido;
	
		SELECT T.IDTITULACION INTO ID_TITU
		FROM TITULACION t 
		WHERE T.NOMBRE LIKE titulo_V;
		
		INSERT INTO ASIGNATURA VALUES (COD_ASIGNATURA,asignatura_V,null,null,null,ID_PROFESOR,ID_TITU,null);
	END IF;
END;

SELECT *
FROM ASIGNATURA a;

BEGIN
	ADD_ASIGNATURA('Matematicas', 'Seguridad Via', 'Carlos', 'Campo');
END;

/*7 Realizar una función que reciba un nombre de titulación y un porcentaje, y que realice la
 *  subida del precio en el porcentaje indicado de las asignaturas de esa titulación. La función 
 * también recibirá un parámetro de entrada salida en la que debe devolver la cantidad total que se 
 * ha subido en todas las asignaturas. La función debe devolver el número de asignatura que hay en esa 
 * titulación o un -1 si no hay ninguna.*/


CREATE OR REPLACE FUNCTION UNIVERSIDAD.subida_precio(titulacion_V varchar2, porcentaje NUMBER, subidaTotal IN OUT number) RETURN NUMBER 
AS 
CURSOR asignaturas(nom_titulacion varchar2)
is
SELECT a.COSTEBASICO AS coste
FROM ASIGNATURA a , TITULACION t 
WHERE t.NOMBRE = nom_titulacion AND t.IDTITULACION = a.IDASIGNATURA ;
contador number:=-1;
BEGIN 
	
	FOR asig IN asignaturas(titulacion_v) LOOP
		subidaTotal:=subidaTotal+(asig.coste*porcentaje);
		UPDATE asignatura a SET a.COSTEBASICO = asig.COSTE + (asig.coste*porcentaje);
		contador:=contador+1;
	
	END LOOP;
	IF contador>-1 THEN
	contador:=contador+1;
	END IF;

	
	
RETURN contador;
	
END;


