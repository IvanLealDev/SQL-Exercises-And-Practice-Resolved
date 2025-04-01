use EMPRESA
drop table ITEM_VENTAS
drop table VENTAS
drop table PRODUCTO

go 

--ENTIDAD CONCRETA O FUERTE.
create table VENTAS (
  
  nro int primary key,
  tipo char not null,
  fecha date not null
  )

go

--ENTIDAD D�BIL.
create table ITEM_VENTAS (
  
  id_nro int ,
  cantidad int not null,
  VENTA_nro int,
  PRODUCTO_id_producto int,
  primary key (VENTA_nro,id_nro,PRODUCTO_id_producto ),
  foreign key (VENTA_nro) references VENTAS (nro),
  foreign key(PRODUCTO_id_producto) references PRODUCTO (id_producto)
  );

  create table PRODUCTO (
  id_producto int primary key,
  PrecioUnitario decimal not null,
  Descripcion varchar(50) not null,
  );