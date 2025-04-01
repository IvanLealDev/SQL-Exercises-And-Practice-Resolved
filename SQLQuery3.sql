create database TpTrigger2

-- drop database TpTrigger2

go

use TpTrigger2

-- use master

go

CREATE TABLE [dbo].[Marcas](
[idMarca] [int] NOT NULL,
[marca] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED
(
[idMarca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

go

CREATE TABLE [dbo].[Articulos](
[idArticulo] [int] NOT NULL,
[articulo] [varchar](20) NOT NULL,
[idMarca] [int] NOT NULL,
[precioCompra] [int] NOT NULL,
[margen] [int] NOT NULL,
[precioVenta] [float] NOT NULL,
[fechaUltimaCompra] [date] NOT NULL,
[stockActual] [int] NOT NULL,
[puntoDeCompra] [varchar](20) NOT NULL,
[cantidadAComprar] [int] NOT NULL,
PRIMARY KEY CLUSTERED
(
[idArticulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

go

CREATE TABLE [dbo].[SitIva](
[idSitIva] [int] NOT NULL,
[SitIva] [int] NOT NULL,
[alicuota] [int] NOT NULL,
[discrimina] [bit] NOT NULL,
PRIMARY KEY CLUSTERED
(
[idSitIva] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

go

CREATE TABLE [dbo].[Localidades](
[idLocalidad] [int] NOT NULL,
[localidad] [varchar](20) NOT NULL,
[provincia] [varchar](20) NOT NULL,
[cp] [char](4) NULL,
[cpa] [char](8) NULL,
PRIMARY KEY CLUSTERED
(
[idLocalidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

go

CREATE TABLE [dbo].[Clientes](
[idCliente] [int] NOT NULL,
[APYN] [varchar](20) NOT NULL,
[domicilio] [varchar](20) NOT NULL,
[idLocalidad] [int] NOT NULL,
[idSitIva] [int] NOT NULL,
[CUIT] [int] NOT NULL,
[estado] [bit] NOT NULL,
PRIMARY KEY CLUSTERED
(
[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

go

CREATE TABLE [dbo].[Facturas](
[idFactura] [int] NOT NULL,
[tipo] [varchar](50) NOT NULL,
[nroFactura] [int] NOT NULL,
[fecha] [datetime] NOT NULL,
[idCliente] [int] NOT NULL,
[subtotal1] [float] NOT NULL,
[descuento] [float] NOT NULL,
[subtotal2] [float] NOT NULL,
[iva1] [float] NOT NULL,
[iva2] [float] NOT NULL,
[total] [float] NOT NULL,
PRIMARY KEY CLUSTERED
(
[idFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

go

CREATE TABLE [dbo].[DetallesFacturas](
[idDetallesFacturas] [int] NOT NULL,
[idFacturas] [int] NOT NULL,
[idArticulo] [int] NOT NULL,
[cantidad] [int] NOT NULL,
[precioSinIva] [float] NOT NULL,
[alicuota] [int] NOT NULL,
[precioFacturado] [float] NOT NULL,
PRIMARY KEY CLUSTERED
(
[idDetallesFacturas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

go

ALTER TABLE [dbo].[DetallesFacturas] WITH CHECK ADD FOREIGN KEY([idFacturas])
REFERENCES [dbo].[Facturas] ([idFactura])

go

ALTER TABLE [dbo].[DetallesFacturas] WITH CHECK ADD FOREIGN KEY([idArticulo])
REFERENCES [dbo].[Articulos] ([idArticulo])
goALTER TABLE [dbo].[Articulos] WITH CHECK ADD FOREIGN KEY([idMarca])
REFERENCES [dbo].[Marcas] ([idMarca])goALTER TABLE [dbo].[Facturas] WITH CHECK ADD FOREIGN KEY([idCliente])
REFERENCES [dbo].[Clientes] ([idCliente])

go

ALTER TABLE [dbo].[Clientes] WITH CHECK ADD FOREIGN KEY([idLocalidad])
REFERENCES [dbo].[Localidades] ([idLocalidad])

go

ALTER TABLE [dbo].[Clientes] WITH CHECK ADD CONSTRAINT [FK_Clientes_SitIva]
FOREIGN KEY([idSitIva])
REFERENCES [dbo].[SitIva] ([idSitIva])go-- Crear una tabla para registra id de evento, fecha y hora, usuario, detalle, datoaux1, datoaux2.create table eventos(	idEvento int primary key identity,	fecHora date not null,	usuario varChar(100),	detalle varChar(100),	datoaux1 varChar(100),	datoaux2 VarChar(100))go-- Realizar un trigger que informe de intentos de modificar precios a los artículos, por
-- parte de usuarios

-- drop trigger itento_actualizar_precio

create trigger itento_actualizar_precio
on Articulos 
for update
as
BEGIN
	declare @preAnt money;
	declare @preAct money;
	set @preAct = (select top 1 precioVenta from inserted)
	set @preAnt = (select top 1 precioVenta from deleted)

	if (@preAct != @preAnt)
	begin
		select 'Intento de Actualizar Hecho' Texto
		insert into eventos (fecHora, usuario, detalle, datoaux1, datoaux2)
		select top 1 getdate(), suser_name(), 'Hecho', convert(varchar, @preAnt), convert (Varchar, @preAct) from inserted
END
	else
	begin
		select 'Intento de Actualizar Fallido' Texto
		insert into eventos(fecHora, usuario, detalle, datoaux1, datoaux2)
		values (getdate(), suser_name(), 'Fallido', convert (VarChar, @preAnt), convert (Varchar, @preAnt))
end
end

insert into Marcas values (1, 'Montagne');
insert into Marcas values (2, 'Nike');

select * from Marcas;

insert into Articulos values (1, 'Campera', 1, 5000, 2000, 7000, '2022/06/06', 5, 1, 1);
insert into Articulos values (2, 'Pantalones', 2, 1000, 500, 1500, '2022/05/05', 10, 1, 2);

select * from Articulos;

update Articulos
	set precioVenta = precioVenta * 1.15
	where idArticulo = 1
--	where idArticulo = 2
--	where idArticulo = 5

select * from Articulos;

select * from eventos;

go

-- Crear una tabla para llevar el registro de stock: idArti, cantidad.

create table Registro(
	idArti int primary key identity,
	cantidad int not null
)

go

-- Realizar un trigger que registre en forma negativa, cada venta que se haga de un
-- artículo. (Factura y Detalle de Factura -> Venta -> idArti 1 Cantidad 6 -> en Stock ->
-- Registro -> Update para restar 6 al stock actual. Si no existe entonces es -6)create trigger actualizar_articuloon detallesFacturasfor insertas	begin		declare @idArti int; 
		declare @cantidad int;
	
		select @idArti = idArticulo, 
			   @cantidad = cantidad 
		from inserted

		update Articulos set stockActual = stockActual - @cantidad
		where idArticulo = @idArti

		insert into Registro (cantidad) values (convert(varchar, -@cantidad))	endinsert into Localidades(idLocalidad, localidad, provincia, cp, cpa)
values (1, 'CABA', 'CABA' , '1027', 'ABC1027H');

insert into SitIva(idSitIva, SitIva, alicuota, discrimina)
values (1, 1, 21, 1);

insert into Clientes(idCliente, APYN, domicilio, idLocalidad, idSitIva, CUIT, estado)
values(1, 'Franco Lago', 'Ratti 470', 1, 1, 1234, 0);

insert into Facturas(idFactura, tipo, nroFactura, fecha, idCliente, subtotal1, descuento, subtotal2, iva1, iva2, total) 
values(1, 'C', 1, '2022/06/06', 1, 7000, 0, 7000, 21, 21, 7000);

insert into DetallesFacturas (idDetallesFacturas, idFacturas, idArticulo, cantidad, precioSinIva, alicuota, precioFacturado) 
values(1, 1, 1, 1, 5530, 21, 7000);

select * from DetallesFacturas;

select * from Registro;

select * from Articulos;

go

-- Realizar un trigger que no deje realizar ventas, cuando un artículo se intente vender
-- con cantidades negativas. Registrar en el Log. (Factura y Detalle de Factura -> Venta ->
-- idArti 1 Cantidad -6 -> no tiene que dejarme Hacer y registrar en el LOG)

create trigger verificar_cantidad_negativa
	on detallesFacturas
	instead of insert
	as
		begin
			declare @idDetallesFacturas int;
			declare @idFacturas int;
			declare @idArti int;
			declare @cantidad int;
			declare @precioSinIva float;
			declare @alicuota int;
			declare @precioFacturado float

			select @idDetallesFacturas = idDetallesFacturas,
				   @idFacturas = idFacturas,
				   @idArti = idArticulo,
				   @cantidad = cantidad,
				   @precioSinIva = precioSinIva,
				   @alicuota = alicuota,
				   @precioFacturado = precioFacturado
			from inserted

			if (@cantidad < 0)
				begin
					select 'La Cantidad No Puede Ser Negativa'
					insert into Registro (cantidad) values (CONVERT(varchar, @cantidad))
				end
			else
				begin
					insert into DetallesFacturas(idDetallesFacturas, idFacturas, idArticulo, cantidad, precioSinIva, alicuota, precioFacturado) 
					select top 1 @idDetallesFacturas, @idFacturas, @idArti, @cantidad, @precioSinIva, @alicuota, @precioFacturado 
					from inserted

					update Articulos set stockActual = stockActual - @cantidad
					where idArticulo = @idArti

					insert into Registro (cantidad) values (convert(varchar, @cantidad))
				end
		end

insert into DetallesFacturas (idDetallesFacturas, idFacturas, idArticulo, cantidad, precioSinIva, alicuota, precioFacturado) 
values(2, 1, 1, 1, 5530, 21, 7000); 

insert into DetallesFacturas (idDetallesFacturas, idFacturas, idArticulo, cantidad, precioSinIva, alicuota, precioFacturado) 
values(3, 1, 1, -1, 5530, 21, 7000);

-- drop trigger actualizar_articulo

select * from DetallesFacturas;

select * from Articulos;

select * from Registro;

go