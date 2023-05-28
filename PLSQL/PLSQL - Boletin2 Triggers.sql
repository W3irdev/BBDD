CREATE TABLE empleados
(dni VARCHAR2(9) PRIMARY KEY,
nomemp VARCHAR2(50),
jefe VARCHAR2(9),
departamento NUMBER,
salario NUMBER(9,2) DEFAULT 1000,
usuario VARCHAR2(50),
fecha DATE,
CONSTRAINT FK_JEFE FOREIGN KEY (jefe) REFERENCES empleados (dni) );

/*Ejercicio 1
Crear un trigger sobre la tabla EMPLEADOS para que no se permita que un empleado
sea jefe de más de cinco empleados.*/

CREATE OR REPLACE TRIGGER jefes
BEFORE INSERT OR UPDATE ON empleados
FOR EACH ROW 
DECLARE 
jefes NUMBER:=0;
BEGIN 
	
	SELECT count(*) INTO jefes
	FROM EMPLEADOS e  
	WHERE e.jefe = :NEW.jefe ;

	IF jefes>5 THEN
		raise_application_error(-20600,:new.jefe||' No puede tener mas de 5 jefes');
	END IF;
	
	
END;

/*Ejercicio 2
Crear un trigger para impedir que se aumente el salario de un empleado en más de un
20%. */

CREATE OR REPLACE TRIGGER aumento_salario
BEFORE UPDATE OF SALARIO ON EMPLEADOS 
FOR EACH ROW 
BEGIN 
	
	if(:NEW.salario > :OLD.SALARIO*1.20) THEN 
	raise_application_error(-20600,:new.jefe||'No se puede aumentar salario');
	END IF;
	
END;

/*Ejercicio 3
Crear una tabla empleados_baja con la siguiente estructura:
CREATE TABLE empleados_baja
( dni VARCHAR2(9) PRIMARY KEY,
nomemp VARCHAR2 (50),
jefe VARCHAR2(9),
departamento NUMBER,
salario NUMBER(9,2) DEFAULT 1000,
usuario VARCHAR2(50),
fecha DATE );
Crear un trigger que inserte una fila en la tabla empleados_baja cuando se borre una fila
en la tabla empleados. Los datos que se insertan son los del empleado que se da de baja
en la tabla empleados, salvo en las columnas usuario y fecha se grabarán las variables
del sistema USER y SYSDATE que almacenan el usuario y fecha actual*/

CREATE TABLE empleados_baja
( dni VARCHAR2(9) PRIMARY KEY,
nomemp VARCHAR2 (50),
jefe VARCHAR2(9),
departamento NUMBER,
salario NUMBER(9,2) DEFAULT 1000,
usuario VARCHAR2(50),
fecha DATE );

CREATE OR REPLACE TRIGGER borrar_empleado
AFTER DELETE ON empleados
FOR EACH ROW 
BEGIN 
	
	INSERT INTO EMPLEADOS_BAJA eb VALUES (:OLD.dni, :OLD.nomemp, :OLD.JEFE, :OLD.departamento, :OLD.salario, USER, sysdate);
	
END;

/*Ejercicio 4
Crear un trigger para impedir que, al insertar un empleado, el empleado y su jefe puedan
pertenecer a departamentos distintos. Es decir, el jefe y el empleado deben pertenecer al
mismo departamento.*/

CREATE OR REPLACE TRIGGER distintos_departamentos
BEFORE INSERT ON empleados
FOR EACH ROW 
DECLARE 
DEPARTAMENTOs NUMBER(3) ;
BEGIN 
	
	SELECT e.DEPARTAMENTO INTO departamentos
	FROM EMPLEADOS e 
	WHERE :NEW.JEFE = e.DNI ;

	IF :NEW.departamento <> departamentos THEN
		raise_application_error(-20601, 'No se puede insertar un empleado de otro departamento');
	END IF;

	
END;

/*Ejercicio 5
Crear un trigger para impedir que, al insertar un empleado, la suma de los salarios de los
empleados pertenecientes al departamento del empleado insertado supere los 10.000
euros.*/

CREATE OR REPLACE TRIGGER suma_salarios
BEFORE INSERT ON empleados
FOR EACH ROW 
DECLARE 
totalSalario NUMBER;
BEGIN 
	
	SELECT sum(e.SALARIO) INTO totalSalario
	FROM EMPLEADOS e
	WHERE e.DEPARTAMENTO = :NEW.departamento;

	IF totalSalario > 10000 THEN
		raise_application_error(-20602, 'No se puede insertar un empleado con ese salario.');
	END IF;
	
END;

/*Ejercicio 6
Crea la tabla:
CREATE TABLE controlCambios(
 usuario varchar2(30),
 fecha date,
 tipooperacion varchar2(30),
 datoanterior varchar2(30),
 datonuevo varchar2(30)
);
Creamos un trigger que se active cuando modificamos algún campo de "empleados" y
almacene en "controlCambios" el nombre del usuario que realiza la actualización, la
fecha, el tipo de operación que se realiza, el dato que se cambia y el nuevo valor.*/

CREATE TABLE controlCambios(
 usuario varchar2(30),
 fecha date,
 tipooperacion varchar2(30),
 datoanterior varchar2(30),
 datonuevo varchar2(30)
);

CREATE OR REPLACE TRIGGER TRIGGERSBOL2.logCambios
AFTER UPDATE ON EMPLEADOS 
FOR EACH ROW 
DECLARE 
datoAnterior varchar2(30);
datoNuevo varchar2(30);
tipoUpdate varchar2(30);
BEGIN 
	
	IF updating('DNI') THEN
		tipoUpdate:='Actualizar DNI '; 
		datoAnterior:= datoAnterior || ' ' || :OLD.DNI; 
		datoNuevo:= datoNuevo || ' ' ||:NEW.DNI;
	END IF;
	IF updating('NOMEMP') THEN
		tipoUpdate:='Actualizar NOMEMP '; 
		datoAnterior:= datoAnterior || ' ' || :OLD.NOMEMP; 
		datoNuevo:= datoNuevo || ' ' ||:NEW.NOMEMP;
	END IF;
	IF updating('JEFE') THEN
		tipoUpdate:='Actualizar JEFE '; 
		datoAnterior:= datoAnterior || ' ' || :OLD.JEFE; 
		datoNuevo:= datoNuevo || ' ' ||:NEW.JEFE;
	END IF;
	IF updating('DEPARTAMENTO') THEN
		tipoUpdate:='Actualizar DEPARTAMENTO '; 
		datoAnterior:= datoAnterior || ' ' || :OLD.DEPARTAMENTO; 
		datoNuevo:= datoNuevo || ' ' ||:NEW.DEPARTAMENTO;
	END IF;
	IF updating('SALARIO') THEN
		tipoUpdate:='Actualizar SALARIO '; 
		datoAnterior:= datoAnterior || ' ' || :OLD.SALARIO; 
		datoNuevo:= datoNuevo || ' ' ||:NEW.SALARIO;
	END IF;
	IF updating('USUARIO') THEN
		tipoUpdate:='Actualizar USUARIO '; 
		datoAnterior:= datoAnterior || ' ' || :OLD.USUARIO; 
		datoNuevo:= datoNuevo || ' ' ||:NEW.USUARIO;
	END IF;
	IF updating('FECHA') THEN
		tipoUpdate:='Actualizar FECHA '; 
		datoAnterior:= datoAnterior || ' ' || :OLD.FECHA; 
		datoNuevo:= datoNuevo || ' ' ||:NEW.FECHA;
	END IF;

	INSERT INTO CONTROLCAMBIOS c values(TO_CHAR(USER), sysdate, tipoUpdate, datoAnterior, datoNuevo);
	
	
END;

/*Ejercicio 7
Creamos otro trigger que se active cuando ingresamos un nuevo registro en "empleados",
debe almacenar en "controlCambios" el nombre del usuario que realiza el ingreso, la
fecha, el tipo de operación que se realiza , "null" en "datoanterior" (porque se dispara con
una inserción) y en "datonuevo" el valor del nuevo dato*/

CREATE OR REPLACE TRIGGER logInsertRegistro
AFTER INSERT ON empleados
FOR EACH row
DECLARE 
datoNuevo varchar2(30);

BEGIN 
	
	IF inserting THEN
		datoNuevo:= :NEW.DNI || :NEW.nomemp || :NEW.jefe || :NEW.departamento || :NEW.salario || :NEW.usuario || :NEW.FECHA;
	END IF;

	INSERT INTO CONTROLCAMBIOS c values(TO_char(USER), sysdate, 'INSERT ', NULL, datoNuevo );
	
END;

/*Ejercicio 8
Crea la siguiente tabla:
 CREATE TABLE pedidos
 ( CODIGOPEDIDO NUMBER,
FECHAPEDIDO DATE,
FECHAESPERADA DATE,
FECHAENTREGA DATE DEFAULT NULL,
ESTADO VARCHAR2(15),
COMENTARIOS CLOB,
CODIGOCLIENTE NUMBER
 )
Inserta los siguientes registros:
Insert into PEDIDOS
(CODIGOPEDIDO,FECHAPEDIDO,FECHAESPERADA,FECHAENTREGA,ESTADO,CODIGOCLIENTE)
values
(1,to_date('17/01/06','DD/MM/YY'),to_date('19/01/06','DD/MM/YY'),to_date('19/0
1/06','DD/MM/YY'),'Entregado',5);
Insert into PEDIDOS
(CODIGOPEDIDO,FECHAPEDIDO,FECHAESPERADA,FECHAENTREGA,ESTADO,CODIGOCLIENTE)
values
(2,to_date('23/10/07','DD/MM/YY'),to_date('28/10/07','DD/MM/YY'),to_date('26/1
0/07','DD/MM/YY'),'Entregado',5);
Insert into PEDIDOS
(CODIGOPEDIDO,FECHAPEDIDO,FECHAESPERADA,FECHAENTREGA,ESTADO,CODIGOCLIENTE)
values
(3,to_date('20/06/08','DD/MM/YY'),to_date('25/06/08','DD/MM/YY'),null,'Rechaza
do',5);
Insert into PEDIDOS
(CODIGOPEDIDO,FECHAPEDIDO,FECHAESPERADA,FECHAENTREGA,ESTADO,CODIGOCLIENTE)
values
(4,to_date('20/01/09','DD/MM/YY'),to_date('26/01/09','DD/MM/YY'),null,'Pendien
te',5);
Crea un trigger que al actualizar la columna fechaentrega de pedidos la compare con la
fechaesperada.
• Si fechaentrega es menor que fechaesperada añadirá a los comentarios 'Pedido
entregado antes de lo esperado'.
• Si fechaentrega es mayor que fechaesperada añadir a los comentarios 'Pedido
entregado con retraso'.*/

CREATE TABLE pedidos
 ( CODIGOPEDIDO NUMBER,
FECHAPEDIDO DATE,
FECHAESPERADA DATE,
FECHAENTREGA DATE DEFAULT NULL,
ESTADO VARCHAR2(15),
COMENTARIOS CLOB,
CODIGOCLIENTE NUMBER
 );

Insert into PEDIDOS
(CODIGOPEDIDO,FECHAPEDIDO,FECHAESPERADA,FECHAENTREGA,ESTADO,CODIGOCLIENTE)
values
(1,to_date('17/01/06','DD/MM/YY'),to_date('19/01/06','DD/MM/YY'),to_date('19/01/06','DD/MM/YY'),'Entregado',5);
Insert into PEDIDOS
(CODIGOPEDIDO,FECHAPEDIDO,FECHAESPERADA,FECHAENTREGA,ESTADO,CODIGOCLIENTE)
values
(2,to_date('23/10/07','DD/MM/YY'),to_date('28/10/07','DD/MM/YY'),to_date('26/10/07','DD/MM/YY'),'Entregado',5);
Insert into PEDIDOS
(CODIGOPEDIDO,FECHAPEDIDO,FECHAESPERADA,FECHAENTREGA,ESTADO,CODIGOCLIENTE)
values
(3,to_date('20/06/08','DD/MM/YY'),to_date('25/06/08','DD/MM/YY'),null,'Rechazado',5);
Insert into PEDIDOS
(CODIGOPEDIDO,FECHAPEDIDO,FECHAESPERADA,FECHAENTREGA,ESTADO,CODIGOCLIENTE)
values
(4,to_date('20/01/09','DD/MM/YY'),to_date('26/01/09','DD/MM/YY'),null,'Pendiente',5);

CREATE OR REPLACE TRIGGER compareFecha
BEFORE UPDATE ON PEDIDOS 
FOR EACH ROW 
DECLARE 
comentario clob:='Pedido entregado con retraso';
BEGIN 
	IF updating('FECHAENTREGA') AND :NEW.FECHAENTREGA<:NEW.FECHAESPERADA THEN 
		comentario:='Pedido entregado antes de lo esperado';
	END IF;

	UPDATE pedidos SET COMENTARIOS = comentario where CODIGOPEDIDO=:OLD.CODIGOPEDIDO;
END;

CREATE OR REPLACE TRIGGER compareFechaEjercicio9
BEFORE UPDATE ON PEDIDOS 
FOR EACH ROW WHEN (:NEW.FECHAENTREGA>:NEW.FECHAESPERADA)
DECLARE 
comentario clob:='Pedido entregado con retraso';
BEGIN 

	UPDATE pedidos SET COMENTARIOS = comentario where CODIGOPEDIDO=:OLD.CODIGOPEDIDO;
END;


 
