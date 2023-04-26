CREATE TABLE TEMA
(
cod_tema varchar2(10),
denominacion varchar2(10),
cod_tema_padre varchar2(10),
CONSTRAINT PK_cod_tema PRIMARY KEY (cod_tema),
CONSTRAINT FK1_cod_tema FOREIGN KEY (cod_tema_padre) REFERENCES tema(cod_tema)
);

CREATE TABLE AUTOR
(
cod_autor varchar2(10),
nombre varchar2(25),
f_nacimiento DATE,
libro_principal varchar2(25),
CONSTRAINT PK_cod_autor PRIMARY KEY (cod_autor)
);


CREATE TABLE LIBRO
(
cod_libro varchar2(25),
titulo varchar2(25),
f_creacion DATE,
cod_tema varchar2(25),
autor_principal varchar2(10),
CONSTRAINT PK_cod_libro PRIMARY KEY (cod_libro),
CONSTRAINT FK1_autor_principal FOREIGN KEY (autor_principal) REFERENCES AUTOR(cod_autor)
);



CREATE TABLE LIBRO_AUTOR
(
cod_libro varchar2(25),
cod_autor varchar2(10),
orden varchar2(25),
CONSTRAINT PK_libro_autor PRIMARY KEY (cod_libro, cod_autor)
);

CREATE TABLE EDITORIAL
(
cod_editorial varchar2(25),
denominacion varchar2(25),
CONSTRAINT cod_editorial PRIMARY KEY (cod_editorial)
);

CREATE TABLE PUBLICACIONES
(
cod_editorial varchar2(25),
cod_libro varchar2(25),
precio NUMBER(10),
f_publicacion DATE,
CONSTRAINT cod_publicaciones PRIMARY KEY (cod_editorial, cod_libro)
);




ALTER TABLE LIBRO_AUTOR ADD CONSTRAINT FK1_cod_libro FOREIGN KEY (cod_libro) REFERENCES LIBRO(cod_libro);
ALTER TABLE LIBRO_AUTOR ADD CONSTRAINT FK2_cod_autor FOREIGN KEY (cod_autor) REFERENCES AUTOR(cod_autor);
ALTER TABLE LIBRO ADD CONSTRAINT FK2_cod_tema FOREIGN KEY (cod_tema) REFERENCES TEMA(cod_tema);
ALTER TABLE PUBLICACIONES ADD CONSTRAINT FK1_cod_libro1 FOREIGN KEY (cod_libro) REFERENCES LIBRO(cod_libro);
ALTER TABLE PUBLICACIONES ADD CONSTRAINT FK2_cod_editorial FOREIGN KEY (cod_editorial) REFERENCES EDITORIAL(cod_editorial);
ALTER TABLE AUTOR ADD CONSTRAINT FK1_libro_principal FOREIGN KEY (libro_principal) REFERENCES LIBRO(cod_libro);
