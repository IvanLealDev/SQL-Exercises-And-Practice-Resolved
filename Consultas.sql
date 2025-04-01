use EMPRESA
drop table ITEM_VENTAS
drop table VENTAS
drop table PRODUCTO

select  V.nro, V.tipo , V.fecha , sum (IV.cantidad * P.PrecioUnitario) as importe_total from VENTAS V;

join ITEM_VENTAS IV on  V.nro = IV.VENTA_nro

group by V.nro ,V.fecha, V.tipo;

select  V.nro, V.tipo , V.fecha , sum (IV.cantidad * P.PrecioUnitario) as importe_total from VENTAS V;
join ITEM_VENTAS IV on  V.nro = IV.VENTA_nro

group by V.nro ,V.fecha, V.tipo;

having sum (IV.cantidad * P.PrecioUnitario) > 5000;

create view CantidadVendidaPorProducto
as
select descripcion, sum(IV.cantidad ) as total_cantidad from PRODUCTO
group by descripcion; 

select top 1  descripcion, max(total_cantidad) as total_vendido from CantidadVendidaPorProducto
group by descripcion


select top 1 descripcion, min(total_cantidad) as total_vendido from CantidadVendidaPorProducto 
group by descripcion
order by total_vendido