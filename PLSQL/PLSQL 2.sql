/*1*/

CREATE OR REPLACE FUNCTION  josemiguelcabreranumero (num NUMBER, salida IN OUT number) RETURN number
IS 
retorno NUMBER:=(-1);
contador NUMBER:=0;
BEGIN 
	IF num < 0 THEN
		salida:=0;
	ELSE 
		WHILE contador < num LOOP
			contador:=contador+1;
			salida:=salida+contador;
			retorno:=1;
		END LOOP;
	END IF;
	RETURN retorno;
		
	
END;

DECLARE
	salida NUMBER:=0;
	suma number:=josemiguelcabreranumero(5, salida);
BEGIN
	dbms_output.put_line(salida);
	dbms_output.put_line(suma);
END;

DECLARE
	salida NUMBER:=5;
	suma number:=josemiguelcabreranumero(-2, salida);
BEGIN
	dbms_output.put_line(salida);
	dbms_output.put_line(suma);
END;

/*2*/

CREATE OR REPLACE TRIGGER insertciclista 
BEFORE INSERT ON ciclistas
FOR EACH ROW 
DECLARE 
hay NUMBER:=0;
BEGIN 
	
	SELECT COUNT(c.NOMBRE) INTO hay
	FROM EQUIPOS e , CICLISTAS c
	WHERE e.CODEQUIPO = c.CODEQUIPO AND c.CODEQUIPO = :NEW.codequipo
	GROUP BY c.CODEQUIPO;

	IF hay >=4 THEN
		raise_application_error(-20001, 'Hay demasiados ciclistas en el equipo.');
	END IF;
	
	
END;


	INSERT INTO CICLISTAS c values(25, 'Josemi2', 'ESPAÑOLA', 5, to_date('1992-07-20', 'yyyy-MM-dd'));
	INSERT INTO CICLISTAS c values(25, 'Josemi2', 'ESPAÑOLA', 2, to_date('1992-07-20', 'yyyy-MM-dd'));


/*3*/

CREATE TABLE memoria(
descripcion varchar2(300)
);

CREATE OR REPLACE TRIGGER logger
AFTER INSERT ON ciclistas
FOR EACH ROW 
DECLARE
descripcion varchar2(300);
nombreequipo varchar2(100);
BEGIN
	SELECT e.NOMBRE INTO nombreequipo
	FROM EQUIPOS e 
	WHERE e.CODEQUIPO = :NEW.codequipo;
	
	descripcion:='El jugador ' || :NEW.nombre || ' ha empezado a formar parte del equipo ' || nombreequipo || ' el dia ' || sysdate;
	INSERT INTO MEMORIA m VALUES (DESCRIPCION);
END;


	INSERT INTO CICLISTAS c values(22, 'Josemi4', 'ESPAÑOLA', 3, to_date('1992-07-20', 'yyyy-MM-dd'));


	SELECT * FROM MEMORIA;

/*4*/

CREATE OR REPLACE PROCEDURE JOSEMIGUELlistado
AS 
num_jugadores NUMBER:=0;

CURSOR c_equipos is
SELECT e.CODEQUIPO , e.NOMBRE , e.NACIONALIDAD , e.NOMBREDIRECTOR 
FROM EQUIPOS e ;

CURSOR c_ciclistas (codequipo_v number) is
SELECT c.NOMBRE , c.FECHANACIMIENTO 
FROM CICLISTAS c 
WHERE c.CODEQUIPO = codequipo_v;

BEGIN 
	
	FOR equipo IN c_equipos LOOP
		num_jugadores:=0;
		
		dbms_output.put_line('Nombre: ' || equipo.nombre || ' Nacionalidad: ' || equipo.nacionalidad || ' Nombre del director: ' || equipo.nombredirector);
		dbms_output.put_line('');	
	FOR ciclista IN c_ciclistas(equipo.codequipo) LOOP
		dbms_output.put_line('Nombre ciclista: ' || ciclista.nombre || ' Fecha nacimiento ' || ciclista.fechanacimiento);	
			
		num_jugadores:=num_jugadores+1;
		END LOOP;
		dbms_output.put_line(num_jugadores);
		dbms_output.put_line('------------------------------------------');
	
	END LOOP;
	
	
END;


BEGIN
	JOSEMIGUELlistado;
END;


