use EMPRESA
delete ITEM_VENTAS
delete VENTAS 
delete PRODUCTO

insert into VENTAS VALUES(1,'A','2020-05-15'), --1250.00
                         (2,'B','2020-06-15'), --10000.00
						 (3,'C','2020-09-27'); --1000.00

insert into PRODUCTO VALUES
(1,20,'Queso Blanco Casamcrem'),
(2,70, ' Actimel'),
(3,120,'Lampara De Bajo consumo'),
(4,200,'Insecticida Raid'),
(5, 100, 'Curitas');

 insert into ITEM_VENTAS VALUES
 (1,3,1,3),
 (2,4,1,5),
 (3,2,1,1),
 (1,3,2,3),
 (2,3,2,4),
 (1,1,3,4);