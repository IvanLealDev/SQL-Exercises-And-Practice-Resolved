create database tpn2

go 

use tpn2

go

create table Clientes (
	idCliente int primary key identity, 
	APYN varChar(100), 
	domic varChar(100), 
	idlocalidad int,
	idSitIva int,
	CUIT char(11),
	estado varChar(100)
)

go

create table SitIva(
	idSitIva int primary key identity,
	SitIva int,
	alícuota float, 
	discrimina char(1)
)

go

create table Articulos(
	idArticulo int primary key identity, 
	articulo varChar(100), 
	idMarca int, 
	precioCompra float, 
	margen float, 
	precioVenta float, 
	fechaUltimaCompra date,
	stockActual int, 
	PuntoDeCompra varChar(100), 
	CantidadAComprar int
)

go

create table Marcas(
	idMarca int primary key identity, 
	marca varChar(100)
)

go

create table Localidades(
	idlocalidad int primary key identity, 
	Localidad varChar(100), 
	Provincia varChar(100)
)

go

create table Facturas(
	idFactura int primary key identity, 
	tipo varChar(100), 
	nroFactura int, 
	fecha date, 
	idCliente int, 
	subtotal1 float, 
	descuento int, 
	subtotal2 float, 
	iva1 float, 
	iva2 float,
	total float
)

go

create table DetallesFacturas(
	idDetalleFactura int primary key identity, 
	idFactura int, 
	idArticulo int, 
	cantidad int, 
	precioSinIva float, 
	alícuota float,
	precioFacturado float
)

go

-- Tabla Extra

create table Distribuidores(
	idDistribuidores int primary key identity,
	idlocalidad int,
	APYN varchar(100),
	domic varchar(100),
	CUIT varchar(100)
)

go

-- Foreing Key Extra

alter table Distribuidores add constraint
	FK_Distribuidores_Localidades foreign key (idlocalidad)
	references Localidades (idlocalidad)
	on update cascade
	on delete cascade

go

alter table Clientes add constraint
	FK_Clientes_SitIva foreign key (idSitIva)
	references SitIva (idSitIva)
	on update cascade
	on delete cascade

go

-- Localidades(1) a Clientes(N) , Significa que una localidad tiene de 1 a muchos clientes 
-- pero un cliente tiene una sola localidad

alter table Clientes add constraint
	FK_Clientes_Localidades foreign key (idlocalidad)
	references Localidades (idlocalidad)
	on update cascade
	on delete cascade

go

alter table Articulos add constraint
	FK_Articulos_Marcas foreign key (idMarca)
	references Marcas (idMarca)
	on update cascade
	on delete cascade

go

alter table Facturas add constraint
	FK_Facturas_Clientes foreign key (idCliente)
	references Clientes (idCliente)
	on update cascade
	on delete cascade

go

alter table DetallesFacturas add constraint
	FK_DetallesFacturas_Facturas foreign key (idFactura)
	references Facturas (idFactura)
	on update cascade
	on delete cascade

go

alter table DetallesFacturas add constraint
	FK_DetallesFacturas_Articulos foreign key (idArticulo)
	references Articulos (idArticulo)
	on update cascade
	on delete cascade

go

insert into Clientes values ('Perez Juan', 'Rivadavia 3211', 1 , 1 , '78945612378', 'Activo');
insert into Clientes values ('Mbappe Kylian', 'Santa Rosa 7894', 2 , 2 , '20345678910', 'No Activo');
insert into Clientes values ('Puyol Carles', 'Ratti 470', 3 , 3 , '96587412658', 'No Activo');
insert into Clientes values ('Pique Gerard', 'Cochabanba 3211', 4 , 4 , '75412369856', 'Activo');

go

insert into SitIva values ( 1 , 10.5, 'N');
insert into SitIva values ( 2 , 21, 'Y');
insert into SitIva values ( 2 , 21, 'Y');
insert into SitIva values ( 1 , 10.5, 'N');

go

insert into Articulos values ( 'Mayonesa', 1, 100, 50, 150, '01-05-2022', 50, 'Ramos Mejia', 2);
insert into Articulos values ( 'Ketchup', 2, 120, 30, 150, '02-05-2022', 50, 'Caballito', 2);
insert into Articulos values ( 'Mostaza', 3, 110, 40, 150, '03-05-2022', 50, 'Moron', 2);
insert into Articulos values ( 'Salsa Golf', 4, 130, 20, 150, '04-05-2022', 50, 'Ituzaingo', 2);

go

insert into Marcas values ('Hellmanns');
insert into Marcas values ('Heinz');
insert into Marcas values ('Benidorm');
insert into Marcas values ('Molto');

go

insert into Localidades values ('Ituzaingo', 'Buenos Aires');
insert into Localidades values ('Haedo', 'Buenos Aires');
insert into Localidades values ('Moron', 'Buenos Aires');
insert into Localidades values ('Once', 'Buenos Aires');

go

insert into Facturas values ('Electronica' , 1 , '25/04/2022', 1 , 500 , 15 , 425 , 14 , 7 , 514.25);
insert into Facturas values ('Electronica' , 2 , '26/04/2022', 2 , 300 , 20 , 240 , 14 , 7 , 290.4);
insert into Facturas values ('Electronica' , 3 , '27/04/2022', 3 , 200 , 30 , 140 , 14 , 7 , 169.4);
insert into Facturas values ('Electronica' , 4 , '28/04/2022', 4 , 400 , 25 , 300 , 14 , 7 , 363);

go

insert into DetallesFacturas values (1 , 1 , 20 , 100 , 50 , 150);
insert into DetallesFacturas values (2 , 2 , 10 , 50 , 50 , 100);
insert into DetallesFacturas values (3 , 3 , 15 , 150 , 50 , 200);
insert into DetallesFacturas values (4 , 4 , 25 , 200 , 50 , 250);

go

-- Insert Extra

insert into Distribuidores values (1 ,'Lopez Luis', 'Guarda Pampa 1458', '456987456321');
insert into Distribuidores values (1 ,'Herbaut ZywOo', 'Chasquibum 1668', '789564123486');
insert into Distribuidores values (1 ,'Medesclaire Apex', 'Misere 4587', '785412369857');
insert into Distribuidores values (1 ,'Bremer BlemeF', 'Peron 1485', '785423698541');

-- Delete from Clientes where idCliente = 5 , Ejemplo para borrar tablas duplicadas.

-- A) Listado de facturas del cliente con apyn “Pepe”

create view con1 with encryption
as
	select 		F.* 
	from 		Facturas F 
	inner join 	Clientes C
	on 			F.idCliente = C.idCliente
	where 		APYN like '%Pepe%';

select * from con1;

sp_helptext con1;

go

-- B) Listado de clientes del Municipio de Ituzaingó y adyacentes.

create view con2 with encryption
as
	select			C.*
	from			Clientes C
	inner join		Localidades L
	on				L.idlocalidad = C.idlocalidad
	where			Localidad in ('Ituzaingo','Moron','Hurlingham','Merlo','Moreno','San Miguel');

select * from con2;

sp_helptext con2;

go

-- C) Listado de Municipios de Buenos Aires con la cantidad de clientes de cada uno.

create view con3 with encryption
as
	select			L.Localidad, count (C.idCliente) as 'Cantidad de Clientes'
	from			Clientes C
	inner join		Localidades L
	on				L.idlocalidad = C.idCliente
	where			L.Provincia = 'Buenos Aires'
	group by		L.Localidad;

select * from con3;

sp_helptext con3;

go

-- D) Listar la siguiente información: Marca, artículo, stockActual, cantidad a comprar,
-- precioCompra, fechaUltimaCompra de los artículos cuyo stockActual sea menor que el puntoDeCompra.

create view con4 with encryption
as
	select			M.Marca, A.articulo, A.stockActual, A.cantidadacomprar, A.precioCompra, fechaUltimaCompra
	from			Marcas M
	inner join		Articulos A
	on				M.idMarca = A.idArticulo
	where			A.stockActual < A.CantidadAComprar;

select * from con4;

sp_helptext con4;

go

-- E) Listado de artículos de cada marca (los artículos de cada marca, además, se mostraran juntos)

create view con5 with encryption
as
	select			M.Marca, A.Articulo
	from			Articulos A
	inner join		Marcas M
	on				M.idMarca = A.idMarca;

select * from con5 order by Marca;

sp_helptext con5;

go

-- F) Cuantas facturas por mes del último, fueron de artículos de una sola marca.

create view con6 with encryption
as
	select			month(F.Fecha) as 'Numero de Mes', count(F.idFactura) as 'Cantidad de Facturas', count(A.idMarca) as 'Cantidad de Marcas'
	from			Facturas F
	inner join		DetallesFacturas DF
	on				F.idFactura = DF.idFactura
	inner join		Articulos A
	on				A.idArticulo = DF.idArticulo
	where			month(F.Fecha) = (select month(getdate()))
	group by		month(F.Fecha)
	having			count(A.idMarca) = 1;

select * from con6;

sp_helptext con6;

-- select month('2022/09/24');
-- select month(GETDATE());

go

-- G) Listado de artículos cuyas ventas (en cantidad) del último mes superen el promedio
-- informando producto, marca, margen

-- Error no muestra Salsa Golf

create view con7 with encryption
as
	select			A.Articulo, M.Marca, A.Margen, sum(C.Cantidad) as 'Cantidad de Ventas X Articulo'
	from			Facturas F
	inner join		DetallesFacturas C
	on				F.idCliente = C.idFactura
	inner join		Articulos A
	on				A.idArticulo = C.idArticulo
	inner join		Marcas M
	on				A.idMarca = M.idMarca
	where			month(F.Fecha) = (select month(getdate()))
	group by		A.articulo, M.marca, A.margen
	having			sum(C.cantidad) > (select sum(C.cantidad) / count(distinct C.idArticulo) from DetallesFacturas C);

	-- El Promedio es 17
	-- El unico que cumple es Salsa Golf con 25.

select * from con7

sp_helptext con7;

go

-- H) Mostrar las productos que adquiere cada cliente los cuales superen la media (últimos seis meses)

create view con8 with encryption
as
	select			C.APYN as Cliente, A.Articulo, sum(DF.Cantidad) as 'Cantidad de Ventas'
	from			Clientes C
	inner join		Facturas F
	on				C.idCliente = F.idCliente
	inner join		DetallesFacturas DF
	on				F.idFactura = DF.idFactura
	inner join		Articulos A
	on				A.idArticulo = DF.idArticulo
	where			fecha between (select dateadd (mm, -6, getdate())) and (select getdate())
	group by		C.APYN, A.articulo
	having			sum(DF.cantidad) > (select sum(DF.cantidad) / count(distinct DF.idArticulo) from DetallesFacturas DF); -- Te devuelve 17.

select * from con8;

sp_helptext con8;

go

-- I) Listado de los artículos (artículo, marca, puntoDeCompraActual,
-- puntoDeCompraCalculado, CantidadAComprarActual, CantidadAComprarCalculado ),
-- calculando en base a las ventas de los últimos 3 meses, cuanto es la cantidad que se
-- compra de cada artículo en promedio (puntoDeCompraCalculado = cantidad de ventas
-- mensuales promedio * cantidad promedio de cada compra) y cuánto debe comprarse para
-- cubrir con una compra los próximos 3 meses.

-- Completar Punto (I)

create view con9 with encryption
as
	select			sum((Cantidad)*3) as 'Punto De Compra Calculado', A.idArticulo
	from			DetallesFacturas DF
	inner join		Articulos A
	on				DF.idArticulo = A.idArticulo
	inner join		Facturas F
	on				DF.idFactura = F.idFactura
	where			DF.cantidad >= 1
	group by		A.idArticulo

select * from con9;
select * from Articulos A inner join con9 on A.idArticulo = con9.idArticulo

sp_helptext con9;

go

-- J) Listado de artículos de que no se vendieron el mes pasado a ningún cliente de cada marca

create view con10 with encryption
as
	select			A.Articulo, DF.*
	from			Articulos A
	left join		DetallesFacturas DF
	on				A.idArticulo = DF.idArticulo
	left join		Facturas F
	on				F.idFactura = DF.idFactura
	where			F.idFactura is null
	and				F.Fecha between (select dateadd (mm, -1, getdate())) and (select getdate());

-- Left o Right outer join, devuelven aquellos registros en los que coinciden o no los valores de los campos X los cuales
-- se relacionan las tablas.
-- inner join solo devuelve las coincidencias.
-- Para quedarme solo con la no coincidencias filtro con el Where.

select * from con10

sp_helptext con10;

go

-- K) Realizar tres vistas que utilicen al menos tres tablas relacionadas y al menos la cláusula IN

create view con11 with encryption
as
	select			A.Articulo
	from			Articulos A
	inner join		DetallesFacturas DF
	on				A.idArticulo = DF.idArticulo
	inner join		Facturas F
	on				F.idFactura = DF.idFactura
	where			F.idCliente in 
	(
    select			C.idCliente
    from			Clientes C
	inner join		Localidades L
	on				L.idLocalidad = C.idlocalidad
	where			L.Localidad = 'Ituzaingo'
	);

select * from con11;

sp_helptext con11;

go

-- I)  Realizar tres vistas que utilicen al menos tres tablas relacionadas y al menos la cláusula
-- NOT IN

create view con12 with encryption
as
	select			sum(DF.Cantidad) as 'Cantidad Total Comprada'
	from			DetallesFacturas DF
	inner join		Articulos A
	on				A.idArticulo = DF.idArticulo
	where			A.idMarca not in
	(
	select			M.idMarca
	from			Marcas M
	where			M.Marca = 'Hellmanns'
	);

select * from con12;

sp_helptext con12;

go

-- M) Realizar dos vistas que utilicen al menos tres tablas relacionadas y al menos la cláusula
-- EXISTS

create view con13 with encryption
as
	select			C.APYN as Cliente, F.idFactura
	from			Clientes C
	inner join		Facturas F
	on				C.idCliente = F.idCliente
	where exists
	(
	select			*
	from			DetallesFacturas DF
	inner join		Articulos A
	on				DF.idArticulo = A.idArticulo
	where			F.idFactura = DF.idFactura
	and				A.articulo = 'Mayonesa'
	);

select * from con13;

sp_helptext con13;

go

-- N) Realizar dos vistas que utilicen al menos tres tablas relacionadas y al menos la cláusula
-- NOT EXISTS

create view con14 with encryption
as
	select			C.APYN as Cliente
	from			Clientes C
	inner join		Facturas F
	on				C.idCliente = F.idCliente
	where not exists
	(
	select			*
	from			DetallesFacturas DF
	inner join		Articulos A
	on				DF.idArticulo = A.idArticulo
	where			F.idFactura = DF.idFactura
	and				A.articulo = 'Mostaza'
	);

select * from con14;

sp_helptext con14;

go

-- O) Realizar dos vistas que utilicen al menos tres tablas relacionadas y al menos la cláusula
-- UNION

create view con15 with encryption
as
	select			C.APYN, C.Domic, C.idLocalidad, C.CUIT, L.Localidad
	from			Clientes C
	inner join		Localidades L
	on				C.idlocalidad = L.idlocalidad
	where			lower(L.idlocalidad) in ('Ituzaingo')
	union
	select			G.APYN, G.Domic, G.idLocalidad, G.Cuit, L.Localidad
	from			Distribuidores G
	inner join		Localidades L
	on				G.idlocalidad = L.idlocalidad
	where			lower(L.Localidad) in ('Ituzaingo')

select * from con15;

sp_helptext con15;

go

-- P) Realizar dos vistas que utilicen al menos tres tablas relacionadas y al menos la cláusula
-- INTERSECT

create view con16 with encryption
as
	select			L.Localidad 
	from			Clientes C
	inner join		Localidades L
	on				C.idlocalidad = L.idlocalidad
	where			lower(L.Localidad) in ('Ituzaingo')
	intersect
	select			L.Localidad
	from			Distribuidores D
	inner join		Localidades L
	on				D.idLocalidad = L.idlocalidad
	where			lower(L.Localidad) in ('Ituzaingo')

select * from con16;

sp_helptext con16;

go

-- Q) Realizar dos vistas que utilicen al menos tres tablas relacionadas y al menos la cláusula
-- EXCEPT

create view con17 with encryption
as
	select			L.Localidad 
	from			Clientes C
	inner join		Localidades L
	on				C.idlocalidad = L.idlocalidad
	where			lower(L.Localidad) in ('Ituzaingo')
	except
	select			L.Localidad
	from			Distribuidores D
	inner join		Localidades L
	on				D.idLocalidad = L.idlocalidad
	where			lower(L.Localidad) in ('Ituzaingo')


-- EXCEPT te devuelve todos los registros de la primera tabla excepto todos los registros de la 2da tabla.

select * from con17;

sp_helptext con17;
