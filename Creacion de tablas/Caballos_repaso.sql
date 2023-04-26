CREATE TABLE CABALLOS
(
CODCABALLO VARCHAR2(4),
NOMBRE VARCHAR2(20) NOT NULL,
PESO NUMBER(3),
FECHANACIMIENTO DATE,
PROPIETARIO VARCHAR2(25),
NACIONALIDAD VARCHAR2(20),
CONSTRAINT PK_CABALLOS PRIMARY KEY (CODCABALLO),
CONSTRAINT CHK1_PESO CHECK (PESO BETWEEN 240 AND 300),
CONSTRAINT CHK2_FECHA CHECK ((EXTRACT(YEAR FROM FECHANACIMIENTO))>2000),
CONSTRAINT CHK3_NACIONALIDAD CHECK (NACIONALIDAD=UPPER(NACIONALIDAD))
);

CREATE TABLE CARRERAS
(
CODCARRERA VARCHAR2(4),
FECHAYHORA DATE,
IMPORTEPREMIO NUMBER(6),
APUESTALIMITE NUMBER(7,2),
CONSTRAINT PK_CARRERAS PRIMARY KEY (CODCARRERA),
CONSTRAINT CHK1_FECHAYHORA CHECK (TO_CHAR(FECHAYHORA, 'HH24:MI')>'09:00' AND TO_CHAR(FECHAYHORA, 'HH24:MI')<'14:30'),
CONSTRAINT CHK2_APUESTALIMITE CHECK (APUESTALIMITE<2000)
);

CREATE TABLE PARTICIPACIONES
(
CODCABALLO VARCHAR2(4), 
CODCARRERA VARCHAR2(4),
DORSAL NUMBER(2) NOT NULL,
JOCKEY VARCHAR2(10) NOT NULL,
POSICIONFINAL NUMBER(2),
CONSTRAINT PK_PARTICIPACIONES PRIMARY KEY (CODCABALLO, CODCARRERA),
CONSTRAINT CHK1_POSICIONFINAL CHECK (POSICIONFINAL>0),
CONSTRAINT FK1_CODCABALLO FOREIGN KEY (CODCABALLO) REFERENCES CABALLOS(CODCABALLO),
CONSTRAINT FK2_CODCARRERA FOREIGN KEY (CODCARRERA) REFERENCES CARRERAS(CODCARRERA)
);

CREATE TABLE CLIENTES
(
DNI VARCHAR2(10),
NOMBRE VARCHAR2(20),
NACIONALIDAD VARCHAR2(20),
CONSTRAINT PK_CLIENTES PRIMARY KEY (DNI),
CONSTRAINT CHK1_DNI CHECK (REGEXP_LIKE(DNI,'^[0-9]{8}[A-Z]{1}$')),
CONSTRAINT CHK2_NACIONALIDAD CHECK (NACIONALIDAD=UPPER(NACIONALIDAD))
);

CREATE TABLE APUESTAS
(
DNICLIENTE VARCHAR2(10),
CODCABALLO VARCHAR2(4),
CODCARRERA VARCHAR2(4),
IMPORTE NUMBER(6) DEFAULT 300 NOT NULL,
TANTOPORUNO NUMBER (6,2),
CONSTRAINT PK_APUESTAS PRIMARY KEY (DNICLIENTE, CODCABALLO, CODCARRERA),
CONSTRAINT FK1_DNICLIENTE FOREIGN KEY (DNICLIENTE) REFERENCES CLIENTES(DNI) ON DELETE CASCADE,
CONSTRAINT FK2_CODCABALLO FOREIGN KEY (CODCABALLO) REFERENCES CABALLOS(CODCABALLO) ON DELETE CASCADE,
CONSTRAINT FK3_CODCARRERA FOREIGN KEY (CODCARRERA) REFERENCES CARRERAS(CODCARRERA) ON DELETE CASCADE
);

ALTER TABLE PARTICIPACIONES ADD CONSTRAINT CHK2_JOCKEYS CHECK ((JOCKEY)=INITCAP(JOCKEY));

ALTER TABLE CARRERAS ADD CONSTRAINT CHK3_FECHA CHECK (TO_CHAR(FECHAYHORA, 'DD/MM')>'10/03' AND (TO_CHAR(FECHAYHORA, 'DD/MM')<'10/11'));
