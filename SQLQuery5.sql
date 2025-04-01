create database IndicesEstadisticas

-- drop database IndicesEstadisticas

go

use IndicesEstadisticas

-- use master

go

-- 0) Explicar la diferencias entre un �ndice NONCLUSTERED y uno CLUSTERED.
-- 0. Un �ndice non-clustered, la clave por la que buscamos tiene un puntero a la p�gina de datos donde se encuentra el registro. 
-- Mientras que en �ndice clustered, la leaf level es la pagina de datos!. Con lo cual, el SQL Server, 
-- se ahorra hacer un salto para leer los datos del registro (Bookmark lookup).
-- La diferencia es importante, ya que el uso de este tipo de �ndices al evitar tener que hacer lecturas adicionales para traer el registro, 
-- son m�s performantes.

-- Indice Agrupados: Un �ndice agrupado define el orden en el cual los datos son f�sicamente almacenados en una tabla. 
-- Los datos de las tablas pueden ser ordenados s�lo en una forma, por lo tanto, s�lo puede haber un �ndice agrupado por tabla.

-- Un �ndice no agrupado no ordena los datos f�sicos dentro de la tabla. De hecho, un �ndice no agrupado es agrupado en un solo lugar y los datos de la tabla son almacenados en otro lugar. 
-- Esto es similar a un libro de texto donde el contenido del libro est� localizado en un lugar y el �ndice est� localizado en otro. 
-- Esto permite tener m�s de un �ndice no agrupado por tabla.

-- 1) Crear 3 (tres ) �ndices (NONCLUSTERED INDEX) para una tabla determinada.

--drop table Articulos

create table Articulos (
	idArticulo int primary key identity,
	codigo int not null,
	descrip varChar(100) not null,
	pcompra int not null,
)

go

declare @count int
select @count = 1
while @count >= 1 and @count <= 1000
begin
	insert into Articulos values (1 + @count, 'Lorem' + Convert(VarChar, @count), 0 + @count);
	select @count = @count + 1
end

go

CREATE NONCLUSTERED INDEX IX_tblArticulos1
ON Articulos (codigo DESC)

go

CREATE NONCLUSTERED INDEX IX_tblArticulos2
ON Articulos (descrip DESC)

go

CREATE NONCLUSTERED INDEX IX_tblArticulos3
ON Articulos (pcompra DESC)

go

-- 2) Escriba una consulta que utiliza en el where los 3(campos) sobre los que cre� los �ndices.

-- drop view con1

create view con1
as
	SELECT * 
	FROM Articulos
	WHERE codigo > 2
	AND descrip <> 'Lorem1'
	AND pcompra > 1

select * from con1

select * from Articulos

go

-- 3) Active la opci�n estad�sticas del producto y registre la informaci�n en una tabla.

select * from sysindexes where id = object_id('Test')

dbcc show_statistics (Test, NCI_TEST_NOMBRE)

-- 4) Verificar los datos utilizando clausulas DISTINCT, LIKE, BETWEEN, OVER en caso de que aplique. (Realizar un resumen de ellas)

select count (distinct codigo) 
as Distintos 
from Articulos;

go

select count (codigo) 
as Parecidos 
from Articulos
where codigo like '%85';

go

select count (codigo) 
as Entre_20Y80 
from Articulos 
where codigo between 20 and 80;

go

select count (pcompra) 
over (partition by pcompra) 
from Articulos;

go

-- 5) Escriba la consulta anterior como 3 (tres) consultas independientes, ejec�telas y por cada una 
-- registre la informaci�n en 3 tablas separadas (igual que en punto 3))

 create table CodDistintos(
	idDistintos int identity primary key,
	codigo int not null
 )

 go

 insert into CodDistintos (codigo) 
 select distinct codigo 
 from Articulos

 select * from CodDistintos

 go

 create table Parecidos(
	idParecidos int identity primary key,
	codigo85 int not null
 )

 go

 insert into Parecidos (codigo85)
 select codigo 
 from Articulos 
 where codigo like '85%'

 select * from Parecidos;

 go

 create table Entre_20Y80 (
	idParecidos int identity primary key,
	codEntre int not null
 )
 
 go

 insert into Entre_20Y80 (codEntre)
 select codigo
 from Articulos
 where codigo
 between 20 and 80;

 select * from Entre_20Y80;


-- 6) Compare la informaci�n estad�stica de cada tabla, unificando resultados en una tabla final.

-- Adjunto Imagen.

-- 7) Analice los resultados expuestos en la tabla comparativa anterior.

-- En la tabla anterior combine los resultados de las otras tablas. 
-- En su conjunto, me muestra la tabla, debajo de lo que devuelve el SELECT, en la que aparecen los �tems que seleccione. 
-- �Stmt Text� me muestra toda la consulta realizada. Son todas distintas ya que realice consultas utilizando clausulas distintas (DISTINCT, LIKE, BETWEEN Y OVER).
-- �EstimatedRows� nos dice la cantidad de filas que el propio SQL cree o espera leer y devolver para completar la consulta. 