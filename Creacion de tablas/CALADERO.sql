CREATE TABLE BARCOS
(
MATRICULA VARCHAR2(10),
NOMBRE VARCHAR2(20),
CLASE VARCHAR2(20),
ARMADOR VARCHAR2(20),
CAPACIDAD NUMBER(10),
NACIONALIDAD VARCHAR2(20),
CONSTRAINT PK_BARCOS PRIMARY KEY (MATRICULA)
);

CREATE TABLE CALADERO
(
CODIGO VARCHAR2(10),
NOMBRE VARCHAR2(20),
UBICACION VARCHAR2(20),
ESPECIEPRINCIPAL VARCHAR2(20),
CONSTRAINT PK_CALADERO PRIMARY KEY (CODIGO)
);

CREATE TABLE ESPECIE
(
CODIGO VARCHAR2(10),
NOMBRE VARCHAR2(10),
TIPO VARCHAR2(10),
CUPOPORBARCO NUMBER(10),
CALADEROPRINCIPAL VARCHAR2(20),
CONSTRAINT PK_CODIGO PRIMARY KEY (CODIGO),
CONSTRAINT FK1_CALADEROPRINCIPAL FOREIGN KEY (CALADEROPRINCIPAL) REFERENCES CALADERO(CODIGO)
);

CREATE TABLE LOTES
(
CODIGO VARCHAR2(10),
MATRICULA VARCHAR2(10),
NUMKILOS NUMBER(10),
PRECIOPORKILOSALIDA NUMBER(20,3),
PRECIOPORKILOADJUDICADO NUMBER(20,3),
FECHAVENTE DATE NOT NULL,
CODESPECIE VARCHAR2(10),
CONSTRAINT PK_LOTES PRIMARY KEY (CODIGO),
CONSTRAINT FK1_MATRICULA FOREIGN KEY (MATRICULA) REFERENCES BARCOS(MATRICULA) ON DELETE CASCADE,
CONSTRAINT FK2_CODESPECIE FOREIGN KEY (CODESPECIE) REFERENCES ESPECIE(CODIGO) ON DELETE CASCADE
);

CREATE TABLE FECHAS_CAPTURAS_PERMITIDAS 
(
CODESPECIE VARCHAR2(10),
CODCALADERO VARCHAR2(10),
FECHAINICIAL DATE,
FECHAFINAL DATE,
CONSTRAINT PK_FECHASCAPTURASPERMITIDAS PRIMARY KEY (CODESPECIE, CODCALADERO),
CONSTRAINT FK1_CODESPECIE FOREIGN KEY (CODESPECIE) REFERENCES ESPECIE(CODIGO),
CONSTRAINT FK2_CODCALADERO FOREIGN KEY (CODCALADERO) REFERENCES CALADERO(CODIGO)
)


ALTER TABLE CALADERO ADD CONSTRAINT FK1_ESPECIEPRINCIPAL FOREIGN KEY (ESPECIEPRINCIPAL) REFERENCES ESPECIE(CODIGO);
ALTER TABLE BARCOS ADD CONSTRAINT CHK1_MATRICULA CHECK (REGEXP_LIKE(MATRICULA, '^[A-Z]{2}-[0-9]{4}$'));
ALTER TABLE LOTES ADD CONSTRAINT CHK2_PRECIOPORKILOADJUDICADO CHECK (PRECIOPORKILOADJUDICADO>PRECIOPORKILOSALIDA);
ALTER TABLE LOTES ADD CONSTRAINT CHK3_NUMKILOSPRECIO CHECK ((NUMKILOS > 0) AND (PRECIOPORKILOSALIDA > 0) AND (PRECIOPORKILOADJUDICADO > 0));
ALTER TABLE CALADERO ADD CONSTRAINT CHK1_MAYUSCNOMBRE CHECK (UPPER(NOMBRE) = NOMBRE);
ALTER TABLE CALADERO ADD CONSTRAINT CHK1_MAYUSCUBICACION CHECK (UPPER(UBICACION) = UBICACION);
ALTER TABLE FECHAS_CAPTURAS_PERMITIDAS ADD CONSTRAINT CHK1_FECHASPERMITIDAS CHECK (NOT (fechainicial BETWEEN TO_DATE('2022-02-02', 'YYYY-MM-DD') AND TO_DATE('2022-03-28', 'YYYY-MM-DD')) AND NOT (fechafinal BETWEEN TO_DATE('2022-02-02', 'YYYY-MM-DD') AND TO_DATE('2022-03-28', 'YYYY-MM-DD')));
alter table FECHAS_CAPTURAS_PERMITIDAS add constraint ejer61 check (to_char(fechainicial,'mm/dd') < '02/02' or to_char(fechainicial,'mm/dd') > '03/28');
ALTER TABLE CALADERO ADD (NOMBRECIENTIFICO VARCHAR2(20));
DROP caladero cascade CONSTRAINT;