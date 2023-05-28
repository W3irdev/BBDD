/*5.7.1. Crea un trigger que, cada vez que se inserte o elimine un empleado, registre
una entrada en la tabla AUDITORIA_EMPLEADOS con la fecha del suceso,
número y nombre de empleado, así como el tipo de operación realizada
(INSERCIÓN o ELIMINACIÓN).*/

CREATE TABLE AUDITORIA_EMPLEADOS (descripcion VARCHAR2(200));

CREATE VIEW SEDE_DEPARTAMENTOS AS
SELECT C.NUMCE, C.NOMCE, C.DIRCE,
 D.NUMDE, D.NOMDE, D.PRESU, D.DIREC, D.TIDIR, D.DEPDE
FROM CENTROS C JOIN DEPARTAMENTOS D ON C.NUMCE=D.NUMCE; 

INSERT INTO DEPARTAMENTOS VALUES (0, 10, 260, 'F', 10, 100, 'TEMP');


CREATE OR REPLACE TRIGGER logger 
AFTER INSERT OR DELETE ON EMPLEADOS
FOR EACH ROW 
BEGIN 
	
	IF inserting THEN 

	INSERT INTO AUDITORIA_EMPLEADOS values(to_char(sysdate, 'DD/MM/YYYY') || ' ' || to_char(:NEW.NUMEM) || ' ' || :NEW.NOMEM || ' ' || 'INSERCION');
	ELSE
	INSERT INTO AUDITORIA_EMPLEADOS values(to_char(sysdate, 'DD/MM/YYYY') || to_char(:OLD.NUMEM) || :OLD.NOMEM  || 'ELIMINACION');
	END IF;
	
END;

INSERT INTO EMPLEADOS e (NUMEM, NOMEM) values(555, 'Josemi');

/*5.7.2. Crea un trigger que, cada vez que se modi(quen datos de un empleado,
registre una entrada en la tabla AUDITORIA_EMPLEADOS con la fecha del
suceso, valor antiguo y valor nuevo de cada campo, así como el tipo de operación
realizada (en este caso MODIFICACIÓN).*/

CREATE OR REPLACE TRIGGER logMod
AFTER UPDATE ON empleados
FOR EACH ROW 
DECLARE 
DATOS VARCHAR2(200):=to_char(sysdate, 'DD/MM/YYYY') || ' ';
BEGIN 
	
	IF UPDATING('NUMEM') THEN
	DATOS:=DATOS || ' NUMEM-A ' || :OLD.NUMEM || ' NUMEM-N ';
	END IF;
	IF UPDATING('EXTEL') THEN
	DATOS:=DATOS || ' EXTEL-A ' || :OLD.EXTEL || ' EXTEL-N ' || :NEW.EXTEL;
	END IF;
	IF UPDATING('FECNA') THEN
	DATOS:=DATOS || ' FECNA-A ' || :OLD.FECNA || ' FECNA-N ' || :NEW.FECNA;
	END IF;
	IF UPDATING('FECIN') THEN
	DATOS:=DATOS || ' FECIN-A ' || :OLD.FECIN || ' FECIN-N ' || :NEW.FECIN;
	END IF;
	IF UPDATING('SALAR') THEN
	DATOS:=DATOS || ' SALAR-A ' || :OLD.SALAR || ' SALAR-N ' || :NEW.SALAR;
	END IF;
	IF UPDATING('COMIS') THEN
	DATOS:=DATOS || ' COMIS-A ' || :OLD.COMIS || 'COMIS-N ' || :NEW.COMIS;
	END IF;
	IF UPDATING('NUMHI') THEN
	DATOS:=DATOS || ' NUMHI-A ' ||:OLD.NUMHI || ' NUMHI-N ' || :NEW.NUMHI;
	END IF;
	IF UPDATING('NOMEM') THEN
	DATOS:=DATOS || ' NOMEM-A ' || :OLD.NOMEM || ' NOMEM-N ' || :NEW.NOMEM;
	END IF;
	IF UPDATING('NUMDE') THEN
	DATOS:=DATOS || ' NUMDE-A ' || :OLD.NUMDE ||' NUMDE-N ' || :NEW.NUMDE;
	END IF;
	

	INSERT INTO AUDITORIA_EMPLEADOS ae values(DATOS || ' MODIFY');
	
END;

UPDATE EMPLEADOS E SET COMIS=25, numhi=2 WHERE E.NOMEM LIKE 'Josemi';

/*5.7.3. Crea un trigger para que registre en la tabla AUDITORIA_EMPLEADOS las
subidas de salarios superiores al 5%. */

CREATE OR REPLACE TRIGGER LOGSUBIDA
AFTER UPDATE ON EMPLEADOS 
FOR EACH ROW 
BEGIN 
	IF UPDATING('SALAR') THEN 
	IF :NEW.SALAR > :OLD.SALAR*1.05 THEN 
	INSERT INTO AUDITORIA_EMPLEADOS ae values(to_char(sysdate, 'DD/MM/YYYY') || ' SALARIO ANTIGUO ' || :OLD.salar || ' SALARIO NUEVO ' || :NEW.salar);
	END IF;
	END IF;
END;

UPDATE EMPLEADOS E SET SALAR=16000 WHERE E.NOMEM LIKE 'Josemi';

/*.7.4. Deseamos operar sobre los datos de los departamentos y los centros donde
se hallan. Para ello haremos uso de la vista SEDE_DEPARTAMENTOS creada
anteriormente. Al tratarse de una vista que involucra más de una tabla,
necesitaremos crear un trigger de sustitución para gestionar las operaciones de
actualización de la información. Crea el trigger necesario para realizar inserciones,
eliminaciones y modi(caciones en la vista anterior.*/

CREATE OR REPLACE
TRIGGER Actualizacion_departamento
INSTEAD OF DELETE OR INSERT OR UPDATE ON SEDE_DEPARTAMENTOS
FOR EACH ROW
DECLARE
cantidad NUMBER(3);
BEGIN
-- Modificamos datos
IF UPDATING THEN
UPDATE CENTROS
SET NOMCE = :new.NOMCE, DIRCE = :new.DIRCE
WHERE NUMCE = :old.NUMCE;
UPDATE DEPARTAMENTOS
SET NUMCE = :new.NUMCE, NOMDE = :new.NOMDE, DIREC = :new.DIREC,
TIDIR = :new.TIDIR, PRESU = :new.PRESU, DEPDE = :new.DEPDE
WHERE NUMCE = :old.NUMCE AND NUMDE = :old.NUMDE;

-- Borramos datos
ELSIF DELETING THEN
-- Si el departamento tiene empleados
-- los movemos al departamento 'TEMP', luego borramos el partamento
-- Si el centro tiene departamentos, no borramos el centro.
SELECT COUNT(NUMDE) INTO cantidad
FROM EMPLEADOS WHERE NUMDE = :old.NUMDE;
IF cantidad > 0 THEN
UPDATE EMPLEADOS SET NUMDE = 0 WHERE NUMDE = :old.NUMDE;
END IF;
DELETE DEPARTAMENTOS WHERE NUMDE = :old.NUMDE;
SELECT COUNT(NUMCE) INTO cantidad
FROM DEPARTAMENTOS WHERE NUMCE = :old.NUMCE;
IF cantid
IF cantidad = 0 THEN
DELETE CENTROS WHERE NUMCE = :old.NUMCE;
END IF;
-- Insertamos datos
ELSIF INSERTING THEN
-- Si el centro o el departamento no existe lo damos de alta,
-- en otro caso actualizamos los datos
SELECT COUNT(NUMCE) INTO cantidad
FROM CENTROS WHERE NUMCE = :new.NUMCE;
IF cantidad = 0 THEN
INSERT INTO CENTROS
VALUES(:new.NUMCE, :new.NOMCE, :new.DIRCE);
ELSE
UPDATE CENTROS
SET NOMCE = :new.NOMCE, DIRCE = :new.DIRCE
WHERE NUMCE = :new.NUMCE;
END IF;
SELECT COUNT(NUMDE) INTO cantidad
FROM DEPARTAMENTOS WHERE NUMDE = :new.NUMDE;
IF cantidad = 0 THEN
INSERT INTO DEPARTAMENTOS
VALUES(:new.NUMDE, :new.NUMCE, :new.DIREC, :new.TIDIR,
:new.PRESU, :new.DEPDE, :new.NOMDE);
ELSE
UPDATE DEPARTAMENTOS
SET NUMCE = :new.NUMCE, DIREC = :new.DIREC, TIDIR = :new.TIDIR,
PRESU = :new.PRESU, DEPDE = :new.DEPDE, NOMDE = :new.NOMDE
WHERE NUMCE = :new.NUMCE;
END IF;
ELSE
RAISE_APPLICATION_ERROR(-20500, 'Error en la actualización');
END IF;
END Actualizacion_departamento;

/*5.7.5. Realiza las siguientes operaciones para comprobar si el disparador anterior
funciona correctamente.*/

-- Inserción de datos
INSERT INTO SEDE_DEPARTAMENTOS (NUMCE, NUMDE, NOMDE)
VALUES (30, 310, 'NUEVO1');
INSERT INTO SEDE_DEPARTAMENTOS (NUMCE, NUMDE, NOMDE)
VALUES (30, 320, 'NUEVO2');
INSERT INTO SEDE_DEPARTAMENTOS (NUMCE, NUMDE, NOMDE)
VALUES (30, 330, 'NUEVO3');
SELECT * FROM CENTROS;
SELECT * FROM DEPARTAMENTOS;
-- Borrado de datos
DELETE FROM SEDE_DEPARTAMENTOS WHERE NUMDE=310;
SELECT * FROM SEDE_DEPARTAMENTOS;
DELETE FROM SEDE_DEPARTAMENTOS WHERE NUMCE=30;
SELECT * FROM SEDE_DEPARTAMENTOS;
-- Modificación de datos
UPDATE SEDE_DEPARTAMENTOS
SET NOMDE='CUENTAS', TIDIR='F', NUMCE=20 WHERE NOMDE='FINANZAS';
SELECT * FROM DEPARTAMENTOS;
UPDATE SEDE_DEPARTAMENTOS
SET NOMDE='FINANZAS', TIDIR='P', NUMCE=10 WHERE NOMDE='CUENTAS';
SELECT * FROM DEPARTAMENTOS;
