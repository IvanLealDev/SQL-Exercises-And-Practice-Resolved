create database TpTrigger

go

use TpTrigger

go

CREATE TABLE [dbo].[Articulos](
[idArticulo] [int] IDENTITY(1,1) NOT NULL,
[codigo] [char](10) NULL,
[articulo] [varchar](100) NOT NULL,
[precio] [money] NOT NULL,
[fecUltComp] [date] NULL,
[idMarca] [int] NULL,
PRIMARY KEY CLUSTERED
(
[idArticulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
CONSTRAINT [UNQ_Codigo] UNIQUE NONCLUSTERED
(
[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
goCREATE TABLE [dbo].[Marcas](
[idMarca] [int] IDENTITY(1,1) NOT NULL,
[marca] [varchar](100) NULL,
PRIMARY KEY CLUSTERED
(
[idMarca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

go

ALTER TABLE [dbo].[Articulos] WITH CHECK ADD CONSTRAINT [FK_ArtMarc] FOREIGN
KEY([idMarca])
REFERENCES [dbo].[Marcas] ([idMarca])

go

ALTER TABLE [dbo].[Articulos] CHECK CONSTRAINT [FK_ArtMarc]
goCREATE TABLE [dbo].[Logx](
[idLog] [int] IDENTITY(1,1) NOT NULL,
[log] [varchar](100) NULL,
CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED
(
[idLog] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
goSET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER primerTrig
ON ArticulosAFTER UPDATE	AS
	BEGIN	SET NOCOUNT ON;	declare @preAnt money;
	declare @preAct money;
	set @preAct= (select top 1 precio from inserted)
	set @preAnt= (select top 1 precio from deleted)
	insert into Logx (Log) values (convert(VARCHAR,@preAct) + '...>' +
	convert(VARCHAR,@preAnt))	end	go-- Modificar el trigger para que guarde cuando se realizó el cambio.alter table Logx add FechaCambio dateexec sp_columns Logxalter trigger primerTrigon Articulosafter update	as	begin	set nocount on;		declare @preAnt money;
	declare @preAct money;
	declare @varFecha date;
	set @preAct= (select top 1 precio from inserted)
	set @preAnt= (select top 1 precio from deleted)
	set @varFecha = (select top 1 getdate() from inserted)
	insert into Logx (Log, FechaCambio) values (convert(VARCHAR,@preAct) + '...>' +
	convert(VARCHAR,@preAnt), @varFecha)

	end
	go

	insert into Marcas(marca) values ('Nike');
	insert into Marcas(marca) values ('Adidas');

	select * from Marcas

	insert into Articulos(codigo, articulo, precio, fecUltComp, idMarca) values ('A7j8', 'Remera', 1000, '2022/04/06', 1);

	select * from Articulos

	update Articulos set precio = precio * 1.15 where idArticulo = 1

	select * from Logx

-- Modificar el trigger para que guarde quién realizó el cambio.alter table Logx add usuarioCambio varchar(30)exec sp_columns Logxalter trigger primerTrigon Articulosafter update	as	begin	set nocount on;		declare @preAnt money;
	declare @preAct money;
	declare @varFecha date;
	declare @usuarioC varChar(30);
	set @preAct= (select top 1 precio from inserted)
	set @preAnt= (select top 1 precio from deleted)
	set @varFecha = (select top 1 getdate() from inserted)
	set @usuarioC = (select top 1 suser_sname() from inserted)
	insert into Logx (Log, FechaCambio, usuarioCambio) values (convert(VARCHAR,@preAct) + '...>' +
	convert(VARCHAR,@preAnt), @varFecha, @usuarioC)

	end
	go

	update Articulos set precio = precio * 1.15 where idArticulo = 1

	select * from Logx
-- Crear un trigger que no permita poner precios nulos o negativos.create trigger segundoTrigon Articulos instead of insert	as	begin	set nocount on;
	declare @precio money;
	set @precio= (select top 1 precio from inserted)
	if (@precio is null or @precio < 0)
		begin
			select 'No se Pudo Insertar un Precio Nulo'
		end
	else
		begin
			select 'Se Realizo Correctamente'
			insert into Articulos(codigo, articulo, precio, fecUltComp, idMarca)
			select top 1 codigo, articulo, precio, fecUltComp, idMarca from inserted
		end
	end
	go	
	insert into Articulos(codigo, articulo, precio, fecUltComp, idMarca) values ('IJ78', 'Buzo', 5000, '2022/05/07', 2);
	insert into Articulos(codigo, articulo, precio, fecUltComp, idMarca) values ('AR8', 'Campera', -100, '2022/10/10', 1);
	insert into Articulos(codigo, articulo, precio, fecUltComp, idMarca) values ('KHAS', 'Medias', null, '2022/11/20', 2);

	select * from Articulos