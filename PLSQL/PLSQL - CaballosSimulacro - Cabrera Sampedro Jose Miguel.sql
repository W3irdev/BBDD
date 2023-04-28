/*1. Crea un paquete con la siguiente nomenclatura TUNOMBREgestioncarreras que contendrá la
función y el procedimiento solicitados en el ejercicio 2 y ejercicio3. Es decir tendrá:
 Función listadocaballos que no recibirá ningún parámetro y devolverá un número.
 Procedimiento agregarcaballos que recibirá como argumento el nombre, peso, fecha
de nacimiento, nacionalidad y el dni y el nombre del dueño.
*/

CREATE OR REPLACE PACKAGE JOSEMIGUELgestioncarreras
AS 
	FUNCTION listadocaballos RETURN NUMBER;
	PROCEDURE agregarcaballos(nombreCaballo varchar2, pesoCaballo NUMBER, fechaNacimiento DATE, 
	nacionalidad varchar2, dniPro varchar2, nombreDueno varchar2);
END;

CREATE OR REPLACE PACKAGE BODY JOSEMIGUELgestioncarreras
AS 

	FUNCTION listadocaballos RETURN NUMBER 
	AS 
	CURSOR c_caballos 
	IS 
	SELECT c.CODCABALLO , c.NOMBRE , c.PESO , p.NOMBRE AS propietario 
	FROM CABALLOS c, PERSONAS p 
	WHERE c.PROPIETARIO  = p.CODIGO ;

	CURSOR c_datos_caballos(V_CodCaballo CABALLOS.CODCABALLO%type)
	IS
	SELECT c2.NOMBRECARRERA , p.NOMBRE , c2.FECHAHORA , p2.POSICIONFINAL , c2.IMPORTEPREMIO 
	FROM PARTICIPACIONES p2 , CARRERAS c2 , PERSONAS p 
	WHERE p2.CODCARRERA = c2.CODCARRERA AND p2.JOCKEY = p.CODIGO
	AND c.CODCABALLO = V_CodCaballo;
		
	cantidad_caballos NUMBER;
	carreras_ganadas NUMBER;
	premio_total NUMBER;
	BEGIN 
		
		SELECT count(c.NOMBRE) INTO cantidad_caballos
		FROM CABALLOS c ;
	
		
		dbms_output.put_line('INFORME DE LOS CABALLOS EXISTENTES EN LA BASE DE DATOS');
		dbms_output.put_line(' ');
		dbms_output.put_line(' ');
	
		
		FOR caballo IN c_caballos LOOP
			SELECT count(p.POSICIONFINAL) INTO carreras_ganadas
			FROM PARTICIPACIONES p 
			WHERE p.CODCABALLO = caballo.codcaballo 
			AND p.POSICIONFINAL = 1;
		
			SELECT sum(c.IMPORTEPREMIO) INTO premio_total
			FROM PARTICIPACIONES p , CARRERAS c 
			WHERE c.CODCARRERA = c.CODCARRERA AND p.CODCABALLO = caballo.codcaballo;
		
		
			dbms_output.put_line('Caballo: ' || caballo.NOMBRE || ' Peso: ' || caballo.PESO || ' Nombre del Propietario: ' || caballo.PROPIETARIO);
			FOR dato IN c_datos_caballos(caballo.codcaballo) LOOP
				dbms_output.put_line('		Nombre de Carrera   Nombre del jokey  Fecha     Posicion Final   Importe Premio');
				dbms_output.put_line(' 		   ' || dato.NOMBRECARRERA || ' 	   ' || dato.Nombre || '  	  '
				|| dato.FECHAHORA || '		  ' || dato.POSICIONFINAL || '  		  ' || dato.importepremio);
			
			
			END LOOP;
			dbms_output.put_line('		Número de carreras ganadas: ' || carreras_ganadas);
			dbms_output.put_line('		Total del importe de todos sus premios: ' || premio_total);
		
		END LOOP;
		
		RETURN cantidad_caballos;
	END listadocaballos;

	PROCEDURE agregarcaballos(nombreCaballo varchar2, pesoCaballo NUMBER, fechaNacimiento DATE, 
	nacionalidad varchar2, dniPro varchar2, nombreDueno varchar2)
	AS 
	dni_propietario number;
	codigo_persona_ultimo NUMBER;
	codigo_ultimo_caballo NUMBER;
	caballo_existe EXCEPTION;
	caballos_nombre NUMBER;
	BEGIN 
		
		SELECT count(p.DNI) INTO dni_propietario
		FROM PERSONAS p 
		WHERE p.DNI = dniPro;
	
		IF dni_propietario=0 THEN
		SELECT max(CODIGO)+1 INTO codigo_persona_ultimo
		from(SELECT p.CODIGO 
			FROM PERSONAS p 
			ORDER BY p.CODIGO DESC )
		WHERE rownum=1;	
		INSERT INTO PERSONAS p VALUES (codigo_persona_ultimo, dniPro, nombreDueno, NULL, NULL, null);
		
			
		END IF;
	
	SELECT max(codcaballo)+1 INTO codigo_ultimo_caballo
	FROM (SELECT c.CODCABALLO 
		FROM CABALLOS c 
		ORDER BY c.CODCABALLO DESC )
	WHERE rownum=1;
		
	SELECT count(c.NOMBRE) INTO caballos_nombre
	FROM CABALLOS c 
	WHERE c.NOMBRE = nombreCaballo;
		
	IF caballos_nombre > 0 THEN
		raise caballo_existe;
	ELSE 
		INSERT INTO CABALLOS values(codigo_ultimo_caballo, nombreCaballo, pesoCaballo, fechaNacimiento, nombreDueno, nacionalidad);
	END IF;
		

	EXCEPTION
		WHEN caballo_existe THEN
			dbms_output.put_line('Ese caballo ya existe');
		WHEN OTHERS THEN
			dbms_output.put_line('No se ha podido añadir caballo');
		

	END;

END JOSEMIGUELgestioncarreras;
	
	

SELECT JOSEMIGUELgestioncarreras.LISTADOCABALLOS() FROM dual; 

BEGIN
	JOSEMIGUELgestioncarreras.AGREGARCABALLOS('CaballoProcedure', 260, sysdate, 'ESPAÑOLA', '47349231X', 'Josemi');
END;





