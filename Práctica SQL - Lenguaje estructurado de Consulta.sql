use [BDD SQL_SERVER];

Insert into Alumno values (1234, 'Perez','Julio', 16, 'Moron')
Insert into Alumno values (5896, 'Gonzales','Ana', 15, 'Castelar')
Insert into Alumno values (2585, 'Martinez','Romina', 15, 'Ituzaingo')
Insert into Alumno values (5897, 'Martinez','Agustina', 15, 'Ituzaingo')
Insert into Alumno values (7755, 'Martinez','Sergio', 15, 'Moron')
Insert into Alumno values (5150, 'Telenti','hernan', 16, 'Ituzaingo')
Insert into Alumno values (2586, 'Vazquez','Luis', 15, 'Moron')
Insert into Alumno values (5850, 'Lita','Martin', 15, 'Haedo')
Insert into Alumno values (2580, 'Roa','Ingrid', 16, 'Ramos Mejia')
Insert into Alumno values (5890, 'Amenie','Susana', 15, 'Ituzaingo')

GO

Select Legajo, Apellido, Nombre from Alumno where Residencia ='Ituzaingo';
Select * from Alumno;

Select Legajo, Apellido, Nombre from Alumno where Edad=15, Residencia ='Ituzaingo';
Select * from Alumno;

Select Legajo, Apellido, Nombre from Alumno where Edad=16, Residencia <>'Ituzaingo' and Residencia <>'Moron';
Select * from Alumno;

Select Legajo, Apellido, Nombre from Alumno where Residencia ='Ituzaingo', Apellido = 'Martinez', Nombre <>'Agustina';
Select * from Alumno;

Select Legajo, Apellido, Nombre from Alumno where Residencia ='Ituzaingo', Apellido = 'Martinez', Residencia ='Moron';

Select * from Alumno;

GO