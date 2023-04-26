/*1*/

SELECT c.NOMBRE , p.NOMBRE AS NOMBRE_PUEBLO
FROM CLIENTES c , PUEBLOS p 
WHERE c.CODPUE = p.CODPUE ;

/*2*/

SELECT P.NOMBRE||' PERTENECE A LA PROVINCIA '|| PRO.NOMBRE AS PROVINCIA
FROM PUEBLOS p , PROVINCIAS PRO
WHERE P.CODPRO = PRO.CODPRO ;

/*3*/

SELECT C.NOMBRE AS NOMBRE_CLIENTE , P.NOMBRE AS LOCALIDAD , PRO.NOMBRE AS PROVINCIA
FROM CLIENTES c , PUEBLOS p , PROVINCIAS PRO
WHERE C.CODPUE = P.CODPUE AND P.CODPRO = PRO.CODPRO ;

/*4*/

SELECT DISTINCT C.NOMBRE AS NOMBRE_CLIENTE , P.NOMBRE AS NOMBRE_PROVINCIA
FROM PROVINCIAS p, CLIENTES c , PUEBLOS PUE
WHERE C.CODPUE = PUE.CODPUE AND P.CODPRO = PUE.CODPRO ;

/*5*/

SELECT DISTINCT  A.DESCRIP , LF.CANT 
FROM ARTICULOS a , LINEAS_FAC lf
WHERE A.CODART = LF.CODART AND LF.CANT >10 ;

/*6*/

SELECT F.FECHA , A.CODART, LF.CANT 
FROM FACTURAS f , LINEAS_FAC lf, ARTICULOS a 
WHERE F.CODFAC = LF.CODFAC  AND LF.CODART = A.CODART ORDER BY FECHA, LF.CANT DESC;

/*7*/

SELECT F.CODFAC AS CODIGO_FACTURA, F.FECHA 
FROM FACTURAS f , CLIENTES c 
WHERE F.CODCLI = C.CODCLI AND C.CODPOSTAL LIKE '%7%';

/*8*/

SELECT F.CODFAC , F.FECHA , C.NOMBRE 
FROM FACTURAS f , CLIENTES c 
WHERE F.CODCLI (+) = C.CODCLI;

/*9*/

SELECT F.CODFAC , F.FECHA , F.IVA , F.DTO , C.NOMBRE 
FROM CLIENTES c , FACTURAS f 
WHERE C.CODCLI = F.CODCLI AND ((F.IVA = 0 OR F.IVA IS NULL) OR F.DTO IS NULL);

/*10*/

SELECT A.DESCRIP , A.PRECIO AS PRECIO_ACTUAL, LF.PRECIO AS PRECIO_ANTERIOR
FROM ARTICULOS a , LINEAS_FAC lf 
WHERE LF.CODART = A.CODART AND LF.PRECIO < A.PRECIO  ;

/*11*/

SELECT DISTINCT LF.CODFAC AS CODIGO_FACTURA, F.FECHA , F.IVA, F.DTO 
FROM FACTURAS f , ARTICULOS a , LINEAS_FAC lf 
WHERE  F.CODFAC = LF.CODFAC AND LF.CODART = A.CODART ;

/*12*/

SELECT DISTINCT  C.NOMBRE, LF.CODFAC AS CODIGO_FACTURA, F.FECHA , F.IVA, F.DTO 
FROM FACTURAS f , ARTICULOS a , LINEAS_FAC lf , CLIENTES c 
WHERE  F.CODFAC = LF.CODFAC AND LF.CODART = A.CODART AND C.CODCLI = F.CODFAC  ;

/*13*/

SELECT C.NOMBRE , P.NOMBRE AS NOMBRE_PROVINCIA
FROM CLIENTES c , PROVINCIAS p, PUEBLOS pUE 
WHERE C.CODPUE = PUE.CODPUE  
AND P.CODPRO = PUE.CODPRO
AND P.NOMBRE LIKE '%MA%';

/*14*/

SELECT DISTINCT c.CODCLI 
FROM CLIENTES c , ARTICULOS a , LINEAS_FAC lf, FACTURAS f  
WHERE (f.CODCLI = c.CODCLI AND f.CODFAC = lf.CODFAC AND a.CODART = lf.CODART )
AND a.STOCK  < a.STOCK_MIN  ;

/*15*/

SELECT DISTINCT a.DESCRIP AS Nombre
FROM ARTICULOS a , LINEAS_FAC lf 
WHERE lf.CODART = a.CODART AND lf.CANT > 0;

/*16*/

SELECT (lf.PRECIO)-(lf.DTO/100)*lf.PRECIO AS PRECIO_REAL
FROM ARTICULOS a , LINEAS_FAC lf 
WHERE lf.CODART = a.CODART ;

/*17*/

SELECT A.DESCRIP 
FROM ARTICULOS a , CLIENTES c , FACTURAS f , LINEAS_FAC lf , PUEBLOS p , PROVINCIAS pro
WHERE c.CODCLI = f.CODCLI AND f.CODFAC = lf.CODFAC AND lf.CODART = a.CODART AND c.CODPUE = p.CODPUE AND p.CODPRO  = pro.CODPRO 
AND pro.NOMBRE LIKE '%a' AND LF.CANT > 0;

/*18*/

SELECT DISTINCT C.NOMBRE 
FROM CLIENTES c , FACTURAS f , LINEAS_FAC lf 
WHERE C.CODCLI = F.CODCLI AND F.CODFAC = LF.CODFAC 
AND F.DTO > 10;

/*19*/

SELECT DISTINCT C.NOMBRE 
FROM CLIENTES c , FACTURAS f , LINEAS_FAC lf 
WHERE C.CODCLI = F.CODCLI AND F.CODFAC = LF.CODFAC 
AND (F.DTO > 10 OR LF.DTO >10);

/*20*/

SELECT A.DESCRIP , LF.CANT , LF.PRECIO 
FROM ARTICULOS a , LINEAS_FAC lf , FACTURAS f , CLIENTES c 
WHERE C.CODCLI = F.CODCLI AND F.CODFAC = LF.CODFAC AND LF.CODART = A.CODART 
AND C.NOMBRE LIKE '%MARIA MERCEDES%';