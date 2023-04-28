ALTER SESSION set  NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:MI';


create table personas
(
	codigo	number(2) primary key,
	dni	varchar2(9),
	nombre	varchar2(30),
	apellidos varchar2(50),
	direccion varchar2(50),
	fecha_nacimiento date
);

create table caballos
(
	codcaballo 	varchar2(4) 	constraint pk_caballos primary key,
	nombre 		varchar2(20) 	constraint nomb_nonulo not null,
	peso 		number(3) 	constraint peso_ok check(peso between 240 and 300),
	fechanacimiento date 		constraint fecnac_ok check (to_char(fechanacimiento,'YYYY')>'2000'),
	propietario 	number(2) constraint fk_cab_pers references personas,
	nacionalidad 	varchar2(20)
);

create table carreras
(
	codcarrera 	varchar2(4) 	constraint pk_carreras primary key,
	nombrecarrera	varchar2(30),
	fechahora	date	constraint hora_ok  check (to_char(fechahora,'hhmi') between '0900' and '1430'),
	importepremio 	number(6),
	apuestalimite   number(7,2) constraint apuestaok check (apuestalimite<20000)
 );

create table clientes
(
	dni	varchar2(10) constraint pk_clientes primary key,
	nombre		varchar2(20),
	nacionalidad	varchar2(20)
);

create table apuestas
(
	dnicliente	varchar2(10)  	constraint fk_clientes references clientes,
	codcaballo	varchar2(4)    	constraint fk_caballos references caballos,
	codcarrera	varchar2(4)	constraint fk_carreras references carreras,
	importe 	number(6) 	constraint impnonulo not null,
	tantoporuno	number(6,2)	constraint tantoporuno_pos check(tantoporuno>1),
	constraint pk_apuestas primary key(dnicliente, codcaballo, codcarrera)
);

create table participaciones
(
	codcaballo	varchar2(4)     constraint fk_caballos2 references caballos,
	codcarrera	varchar2(4) 	constraint fk_carreras2 references carreras,
	dorsal		number(2)	constraint dorsalnonulo not null,
	jockey		number(2)	constraint fk_persona references personas,
	posicionfinal	number(2)	constraint posicionok check (posicionfinal>0),
	constraint pk_participaciones primary key (codcaballo, codcarrera,jockey)
);




insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (1,'6456731B','Jose','Lopez Lopez','Saravia 1','19/02/67');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (2,'23000123C','Jorge','Garcia Garcia','Avenida America 4','23/04/76');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (3,'14000123F','Gonzalo','Castillo Castillo','Cruz Conde 2','14/11/01');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (4,'29000123T','Maria','Jimenez Jimenez','La Paz 23','29/03/40');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (5,'1200012W','Rafael','Latorre Latorre','La Paz 13','12/10/73');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (6,'12000123X','Juana','Castillo Jimenez','Saravia 13','12/03/43');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (7,'31000123P','Joel','Tiger Tiger','La Paz 43','31/12/80');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (8,'75432890P','Inmaculada','Olias Alvarez','Malaga s/n','19/08/67');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (9,'22222222T','Jorge','Lopez Lopez','Constitucion 5','19/02/57');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (10,'33333333U','Juan','Garcia Naranjo','Avendia Principal, 10','09/03/76');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (11,'44444444G','Javier','Garcia Pelayo','Diamantino 12','19/08/88');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (12,'55555555I','Gustavo','Garcia Roman','Coullaut Valera, 10','21/12/67');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (13,'66666666T','Luisa','Lopez Villareal','Calle Ancha, s/n','01/01/76');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (14,'33333333R','Rafael','Latorre Latorre','Castillo principal','12/02/88');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (15,'44444444D','Javier','Garcia Junior','Los minaretes, 4','21/12/79');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (16,'55555555W','Felix','Romero Camacho','Corazon primero izq','15/04/54');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (17,'22222222R','Leticia','Ortiz','Calle Princesa','11/11/70');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (18,'33333333Y','Laura','Perea Olias','Urb. Las Gondolas','05/04/89');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (19,'44444444M','Marta','Perea Olias','Urb. Las Gondolas','11/02/99');
insert into personas (codigo, dni, nombre, apellidos, direccion, fecha_nacimiento) values (20,'55555555N','Celia','Villalobos','CORAZON','11/03/87');



insert into caballos (codcaballo, nombre, peso, fechanacimiento, propietario, nacionalidad)
values('1','Ariza',245,'03/06/2004',18,'Britanica');
insert into caballos (codcaballo, nombre, peso, fechanacimiento, propietario, nacionalidad)
values('2','Duncan De Ran',267,'02/07/2006',20,'EspaNola');
insert into caballos (codcaballo, nombre, peso, fechanacimiento, propietario, nacionalidad)
values('3','Giraldilla',241,'03/10/2005',20,'Arabe');
insert into caballos (codcaballo, nombre, peso, fechanacimiento, propietario, nacionalidad)
values('4','Danirrah',287,'12/11/2004',1,'Britanica');
insert into caballos (codcaballo, nombre, peso, fechanacimiento, propietario, nacionalidad)
values('5','Persicus',275,'03/10/2004',12,'EspaNola');
insert into caballos (codcaballo, nombre, peso, fechanacimiento, propietario, nacionalidad)
values('6','Mia''s Choice',250,'07/07/2005',10, 'Britanica');
insert into caballos (codcaballo, nombre, peso, fechanacimiento, propietario, nacionalidad)
values('7','Comanche Trail',296,'22/11/2005',12, 'Britanica');
insert into caballos (codcaballo, nombre, peso, fechanacimiento, propietario, nacionalidad)
values('8','Chulapo',260,'10/07/2006',20,'EspaNola');


insert into carreras(codcarrera, nombrecarrera, fechahora, importepremio, apuestalimite)
values('C1', 'G.P. Toscano',to_date('12/07/2009 09:30','DD-MM-YYYY HH24:MI'),50000, 2000);
insert into carreras(codcarrera, nombrecarrera, fechahora, importepremio, apuestalimite)
values('C2', 'G.P. Nazareno',to_date('12/07/2009 10:30','DD-MM-YYYY HH24:MI'), 12000, 1300);
insert into carreras(codcarrera, nombrecarrera, fechahora, importepremio, apuestalimite)
values( 'C3','G.P. Paquino', to_date('12/07/2009 11:30','DD-MM-YYYY HH24:MI'), 4000, 500 );
insert into carreras(codcarrera, nombrecarrera, fechahora, importepremio, apuestalimite)
values( 'C4','G.P. San Rafael', to_date('19/07/2009 09:30','DD-MM-YYYY HH24:MI'), 24000, 900);
insert into carreras(codcarrera, nombrecarrera, fechahora, importepremio, apuestalimite)
values( 'C5', 'G.P. Topeka', to_date('19/07/2009 10:30','DD-MM-YYYY HH24:MI'), 3000, 350);
insert into carreras(codcarrera, nombrecarrera, fechahora, importepremio, apuestalimite)
values( 'C6', 'G.P. El Emilio', to_date('21/10/2009 11:00','DD-MM-YYYY HH24:MI'), 5000, 400);
insert into carreras(codcarrera, nombrecarrera, fechahora, importepremio, apuestalimite)
values( 'C7', 'G.P. La Jarrita', to_date('21/10/2008 12:00','DD-MM-YYYY HH24:MI'), 25000, 2400);



insert into clientes (dni, nombre, nacionalidad)
values ('111A', 'Ronald McDonald', 'Estadounidense');
insert into clientes (dni, nombre, nacionalidad)
values ('222B', 'Douglas O''Connors', 'Escocesa');
insert into clientes (dni, nombre, nacionalidad)
values ('333C', 'Juanita de Alba', 'EspaNola');
insert into clientes (dni, nombre, nacionalidad)
values ('444D', 'Sid Vicious', 'Estadounidense');
insert into clientes (dni, nombre, nacionalidad)
values ('555E', 'Rob Halford', 'Britanica');
insert into clientes (dni, nombre, nacionalidad)
values ('666F', 'Dioni Perez', 'EspaNola');
insert into clientes (dni, nombre, nacionalidad)
values ('777G', 'Hamed Karim Aizam', 'arabe');
insert into clientes (dni, nombre, nacionalidad)
values ('888H', 'John H. Bonham', 'Britanica');
insert into clientes (dni, nombre, nacionalidad)
values ('999I', 'Manuel Sanchez', 'EspaNola');



insert into apuestas (dnicliente, codcaballo, codcarrera, importe, tantoporuno)
values('111A','1','C1',400,25);
insert into apuestas (dnicliente, codcaballo, codcarrera, importe, tantoporuno)
values('111A','2','C1',300,4);
insert into apuestas (dnicliente, codcaballo, codcarrera, importe, tantoporuno)
values('222B','3','C1',500,5.5 );
insert into apuestas (dnicliente, codcaballo, codcarrera, importe, tantoporuno)
values('333C','4','C2',1200,6 );
insert into apuestas (dnicliente, codcaballo, codcarrera, importe, tantoporuno)
values('333C','5','C2',1800,10);
insert into apuestas (dnicliente, codcaballo, codcarrera, importe, tantoporuno)
values('444D','6','C2',3000,2);
insert into apuestas (dnicliente, codcaballo, codcarrera, importe, tantoporuno)
values('444D','7','C3',350,10);
insert into apuestas (dnicliente, codcaballo, codcarrera, importe, tantoporuno)
values('555E','8','C3',400,6 );
insert into apuestas (dnicliente, codcaballo, codcarrera, importe, tantoporuno)
values('777G','8','C3',300,1.8 );
insert into apuestas (dnicliente, codcaballo, codcarrera, importe, tantoporuno)
values('111A','1','C4',400,3 );
insert into apuestas (dnicliente, codcaballo, codcarrera, importe, tantoporuno)
values('888H','3','C4',600,2.5 );
insert into apuestas (dnicliente, codcaballo, codcarrera, importe, tantoporuno)
values('999I','5','C4',800,5 );
insert into apuestas (dnicliente, codcaballo, codcarrera, importe, tantoporuno)
values('222B','2','C5',300,5 );
insert into apuestas (dnicliente, codcaballo, codcarrera, importe, tantoporuno)
values('333C','2','C5',310,5 );
insert into apuestas (dnicliente, codcaballo, codcarrera, importe, tantoporuno)
values('555E','4','C5',325,3 );



insert into participaciones(codcaballo, codcarrera,dorsal, jockey, posicionfinal)
values('1','C1',3,20, 1);
insert into participaciones(codcaballo, codcarrera,dorsal, jockey, posicionfinal)
values('2','C1',1,1, 3);
insert into participaciones(codcaballo, codcarrera,dorsal, jockey, posicionfinal)
values('3','C1',2,2, 2);
insert into participaciones(codcaballo, codcarrera,dorsal, jockey, posicionfinal)
values('4','C2',2,20, 1);
insert into participaciones(codcaballo, codcarrera,dorsal, jockey, posicionfinal)
values('5','C2',3,3, 3);
insert into participaciones(codcaballo, codcarrera,dorsal, jockey, posicionfinal)
values('6','C2',2,1, 2);
insert into participaciones(codcaballo, codcarrera,dorsal, jockey, posicionfinal)
values('7','C3',8,20, 2);
insert into participaciones(codcaballo, codcarrera,dorsal, jockey, posicionfinal)
values('8','C5',5,2, 1);
insert into participaciones(codcaballo, codcarrera,dorsal, jockey, posicionfinal)
values('8','C3',12,3, 3);
insert into participaciones(codcaballo, codcarrera,dorsal, jockey, posicionfinal)
values('1','C4',1,3, 2);
insert into participaciones(codcaballo, codcarrera,dorsal, jockey, posicionfinal)
values('3','C4',6,4, 3);
insert into participaciones(codcaballo, codcarrera,dorsal, jockey, posicionfinal)
values('5','C4',4,20, 1);
insert into participaciones(codcaballo, codcarrera,dorsal, jockey, posicionfinal)
values('7','C4',2,3, 4);
insert into participaciones(codcaballo, codcarrera,dorsal, jockey, posicionfinal)
values('2','C5',3,14, 1);
insert into participaciones(codcaballo, codcarrera,dorsal, jockey, posicionfinal)
values('6','C5',6,15, 3);
insert into participaciones(codcaballo, codcarrera,dorsal, jockey, posicionfinal) values('1','C5',2,11, 4);
insert into participaciones(codcaballo, codcarrera,dorsal, jockey, posicionfinal)
values('5','C5',1,20, 2);