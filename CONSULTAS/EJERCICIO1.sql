/*CONSULTA 1*/

SELECT CODFAC, FECHA, 2*DTO AS DESCUENTO FROM FACTURAS WHERE IVA=0;
/* CONSULTA 2*/
SELECT CODFAC FROM FACTURAS WHERE IVA IS NULL;
/* CONSULTA 3 */
SELECT CODFAC FROM FACTURAS WHERE IVA=0 OR IVA IS NULL;
/* CONSULTA 4 */
SELECT CODFAC, CODART FROM LINEAS_FAC WHERE CANT<5 AND DTO >=25;
/* CONSULTA 5 */
SELECT DESCRIP, STOCK_MIN-STOCK AS FALTAN FROM ARTICULOS WHERE STOCK<STOCK_MIN;
/* CONSULTA 6 */
SELECT DISTINCT IVA FROM FACTURAS;
/* CONSULTA 7 */
SELECT CODART, DESCRIP STOCK_MIN FROM ARTICULOS WHERE STOCK IS NULL;
/* CONSULTA 8 */
SELECT DESCRIP FROM ARTICULOS WHERE STOCK=STOCK_MIN*3 AND PRECIO>6;
/* CONSULTA 9 */
SELECT DISTINCT CODART FROM LINEAS_FAC WHERE (CODFAC BETWEEN 8 AND 10);
/* CONSULTA 10 */
SELECT NOMBRE, DIRECCION FROM CLIENTES;
/* CONSULTA 11 */
SELECT DISTINCT CODPUE FROM CLIENTES;
/* CONSULTA 12 */
SELECT DISTINCT CODPUE FROM CLIENTES WHERE CODCLI < 25;
/* CONSULTA 13 */
SELECT UPPER(NOMBRE) FROM PROVINCIAS WHERE NOMBRE LIKE '_O%';
/* CONSULTA 14 */
SELECT CODFAC, FECHA FROM FACTURAS WHERE EXTRACT(YEAR FROM FECHA)=EXTRACT(YEAR FROM SYSDATE)-1 AND CODCLI BETWEEN 50 AND 100;
/* CONSULTA 15 */
SELECT NOMBRE, DIRECCION FROM CLIENTES WHERE CODPOSTAL LIKE '12%';
/* CONSULTA 16 */
SELECT DISTINCT FECHA FROM FACTURAS WHERE CODCLI <50;
/* CONSULTA 17 */
SELECT CODFAC, FECHA FROM FACTURAS WHERE EXTRACT(MONTH FROM FECHA)=06 AND EXTRACT(YEAR FROM FECHA)=2004;
/* CONSULTA 18 */
SELECT CODFAC, FECHA FROM FACTURAS WHERE EXTRACT(MONTH FROM FECHA)=06 AND EXTRACT(YEAR FROM FECHA)=2004 AND CODCLI BETWEEN 100 AND 250;
/* CONSULTA 19 */
SELECT CODFAC, FECHA FROM FACTURAS WHERE CODCLI BETWEEN 90 AND 100 AND IVA IS NULL OR IVA=0;
/* CONSULTA 20 */
SELECT UPPER(NOMBRE) FROM PROVINCIAS WHERE NOMBRE LIKE '%S';
/* CONSULTA 21 */
SELECT NOMBRE FROM CLIENTES WHERE CODPOSTAL LIKE '02%' OR CODPOSTAL LIKE '11%' OR CODPOSTAL LIKE '21%';
/* CONSULTA 22 */
SELECT * FROM ARTICULOS WHERE STOCK>STOCK_MIN AND STOCK_MIN-STOCK<5;
/* CONSULTA 23 */
SELECT UPPER(NOMBRE) FROM PROVINCIAS WHERE NOMBRE LIKE ('%MA%');
/* CONSULTA 24 */
SELECT CODART, DESCRIP, PRECIO AS PERCIO_SIN_DESCUENTO, PRECIO-PRECIO*0.10 AS PRECIO_DESCUENTO FROM ARTICULOS WHERE PRECIO>6000 AND (PRECIO*STOCK)>60000;