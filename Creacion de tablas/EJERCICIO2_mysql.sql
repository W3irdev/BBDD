CREATE TABLE DEPARTAMENTO(
CODIGO INTEGER(10),
NOMBRE VARCHAR(100),
PRESUPUESTO DOUBLE,
GASTOS DOUBLE,
CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY (CODIGO)
);

CREATE TABLE EMPLEADO(
CODIGO INTEGER(10),
NIF VARCHAR(9),
NOMBRE VARCHAR(100),
APPELIDO1 VARCHAR(100),
APELLIDO2 VARCHAR(100),
CODIGO_DEPARTAMENTO INTEGER(10),
CONSTRAINT PK_EMPLEADO PRIMARY KEY (CODIGO),
CONSTRAINT FK_CODIGO_DEPARTAMENTO FOREIGN KEY (CODIGO_DEPARTAMENTO) REFERENCES DEPARTAMENTO(CODIGO)
);

INSERT INTO DEPARTAMENTO 
VALUES (1, 'DESARROLLO', 120000, 6000);

INSERT INTO DEPARTAMENTO 
VALUES (2, 'SISTEMAS', 150000, 21000);

INSERT INTO DEPARTAMENTO 
VALUES (3, 'RECURSOS HUMANOS', 280000, 25000);

INSERT INTO DEPARTAMENTO 
VALUES (4, 'CONTABILIDAD', 110000, 3000);

INSERT INTO DEPARTAMENTO 
VALUES (5, 'I+D', 375000, 380000);

INSERT INTO DEPARTAMENTO 
VALUES (6, 'PROYECTOS', 0, 0);

INSERT INTO DEPARTAMENTO 
VALUES (7, 'PUBLICIDAD', 0, 1000);

INSERT INTO EMPLEADO 
VALUES (1, '32481596F', 'AARON', 'RIVERO', 'GOMEZ', 1);

INSERT INTO EMPLEADO 
VALUES (2, 'Y5575632D', ' ADELA', 'SALAS', 'DIAS', 2);

INSERT INTO EMPLEADO 
VALUES (3, 'R6970642B', 'ADOLFO', 'RUBIO', 'FLORES', 3);

INSERT INTO EMPLEADO 
VALUES (4, '77705545E', 'ADRIAN', 'SUAREZ', NULL, 4);

INSERT INTO EMPLEADO 
VALUES (5, '17087203C', 'MARCOS', 'LOYOLA', 'MENDEZ', 5);

INSERT INTO EMPLEADO 
VALUES (6, '38382980M', 'MARIA', 'SANTANA', 'MORENO', 1);

INSERT INTO EMPLEADO 
VALUES (7, '80576669X', 'PILAR', 'RUIZ', NULL, 2);

INSERT INTO EMPLEADO 
VALUES (8, '71651431Z', 'PEPE', 'RUIZ', 'SANTANA', 3);

INSERT INTO EMPLEADO 
VALUES (9, '56399183D', 'JUAN', 'GOMEZ', 'LOPEZ', 2);

INSERT INTO EMPLEADO 
VALUES (10, '46384486H', 'DIEGO', 'FLORES', 'SALAS', 5);

INSERT INTO EMPLEADO 
VALUES (11, '67389283A', 'MARTA', 'HERRERA', 'GIL', 1);

INSERT INTO EMPLEADO 
VALUES (12, '41234836R', 'IRENE', 'SALAS', 'FLORES', NULL);

INSERT INTO EMPLEADO 
VALUES (13, '82635162B', 'JUAN ANTONIO', 'SAEZ', 'GUERRERO', NULL);

INSERT INTO DEPARTAMENTO (CODIGO, NOMBRE, PRESUPUESTO)
VALUES(8, 'LABORATORIO', 80000);


/*INSERT INTO departamento (nombre, presupuesto) 
VALUES('Marketing', 250000);*/

INSERT INTO DEPARTAMENTO  (CODIGO, NOMBRE, PRESUPUESTO, GASTOS) VALUES
(9, 'Comunicación', 300000, 10000);

INSERT INTO EMPLEADO
VALUES(14, '65559874Q', 'ANDREA', 'MARRON', 'GARCIA', 8);

/* INSERT INTO EMPLEADO
 * VALUES('69774365K', 'MIRYAM', 'GARCIA', 'ZAMUDIO', 9);
 */

CREATE TABLE DEPARTAMENTO_BACKUP(
CODIGO INTEGER(10),
NOMBRE VARCHAR(100),
PRESUPUESTO DOUBLE,
GASTOS DOUBLE,
CONSTRAINT PK_DEPARTAMENTO_BACKUP PRIMARY KEY (CODIGO)
);

INSERT INTO DEPARTAMENTO_BACKUP SELECT * FROM DEPARTAMENTO;

/*
DELETE FROM EMPLEADO WHERE CODIGO_DEPARTAMENTO = 6;*/


DELETE FROM DEPARTAMENTO WHERE CODIGO = 6;

DELETE FROM EMPLEADO WHERE CODIGO_DEPARTAMENTO = 1;

DELETE FROM DEPARTAMENTO WHERE NOMBRE LIKE ('DESARROLLO');

/*UPDATE EMPLEADO SET CODIGO_DEPARTAMENTO = 30 WHERE CODIGO_DEPARTAMENTO = 3;

UPDATE DEPARTAMENTO SET CODIGO = 30 WHERE CODIGO = 3;*/

/*UPDATE DEPARTAMENTO SET CODIGO = 40 WHERE NOMBRE LIKE (PUBLICIDAD);*/

UPDATE DEPARTAMENTO SET PRESUPUESTO=PRESUPUESTO+50000 WHERE (PRESUPUESTO < 20000);

DELETE FROM EMPLEADO WHERE CODIGO_DEPARTAMENTO = NULL;

