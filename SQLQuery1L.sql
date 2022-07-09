use kalum_test

select * from Aspirante a
select * from ExamenAdmision ea
select * from CarreraTecnica ct
select * from Jornada j
select * from Alumno a

--Creacion de carreras tecnicas
insert into CarreraTecnica (CarreraId,CarreraTecnica) values (NEWID(),'Desarrollo de aplicaciones empresariales con .NET');
insert into CarreraTecnica (CarreraId,CarreraTecnica) values (NEWID(),'Desarrollo de aplicaciones empresariales con JAVA EE');
insert into CarreraTecnica (CarreraId,CarreraTecnica) values (NEWID(),'Desarrollo de aplicaciones Moviles');
--Creacion de examen de admision
insert into ExamenAdmision (ExamenId, FechaExamen) values (NEWID(), '2022-04-30');
insert into ExamenAdmision (ExamenId, FechaExamen) values (NEWID(), '2022-05-30');
insert into ExamenAdmision (ExamenId, FechaExamen) values (NEWID(), '2022-06-20');
insert into ExamenAdmision (ExamenId, FechaExamen) values (NEWID(), '2022-04-07');
select * from ExamenAdmision
--Creacion de Jornadas
insert into Jornada (JornadaId, Jornada, Descripcion) values (NEWID(), 'JM', 'Jornada Matutina');
insert into Jornada (JornadaId, Jornada, Descripcion) values (NEWID(), 'JV', 'Jornada Vespertina');
--Creacion de aspirante
insert into Aspirante(NoExpediente, Apellidos, Nombres, Direccion, Telefono, Email, CarreraId, ExamenId, JornadaId) 
 values ('EXP-2022001', 'Pirir Romero', 'Jose Sebastian', 'Guatemala, Guatemala', '24110101', 'jpirir@kinal.edu.gt', '0298CE01-0FEE-461B-BBC3-9E5C659AD551', '3DC0110F-0B0A-4205-BB8F-89F99A571D37', '1A88218E-4671-4403-8F43-44037366C9A9');

insert into Aspirante(NoExpediente, Apellidos, Nombres, Direccion, Telefono, Email, CarreraId, ExamenId, JornadaId) 
 values ('EXP-2022002', 'Mancilla Paz', 'Nancy Elizabeth', 'Guatemala, Guatemala', '24110102', 'nmancilla@kinal.edu.gt', '012533CD-EFEA-4A37-A2AF-C2C0AF35E9F1', 'A52812CC-6AE6-450E-ABA8-89F3A917C3EF', '101F2719-3149-42CF-A977-255968E18E29');

insert into Aspirante(NoExpediente, Apellidos, Nombres, Direccion, Telefono, Email, CarreraId, ExamenId, JornadaId) 
 values ('EXP-2022003', 'Revolorio Paz', 'Juan Alberto', 'Guatemala, Guatemala', '24110103', 'jpaz@kinal.edu.gt', '9BE97C7D-6F01-488A-BF9D-25B4A3855840', 'E9B8FA6B-949B-4573-8315-3BF05870218C', '1A88218E-4671-4403-8F43-44037366C9A9');

insert into Aspirante(NoExpediente, Apellidos, Nombres, Direccion, Telefono, Email, CarreraId, ExamenId, JornadaId) 
 values ('EXP-2022004', 'Pirir Romero', 'Jose Sebastian', 'Guatemala, Mixco', '12345678', 'josepirir@kinal.edu.gt', '9BE97C7D-6F01-488A-BF9D-25B4A3855840', '6FE7D264-B602-4A1A-A4AC-3DFC1991226D', '1A88218E-4671-4403-8F43-44037366C9A9');

-- CONSULTA
-- 01 Aspirantes que se van a examinar el día 30 de Abril, se debe de mostrar el Expediente, apellidos, nomnbes, fecha examen, y estatus.

select NoExpediente, Apellidos, Nombres, FechaExamen, CarreraTecnica, estatus 
  from Aspirante a
  inner join ExamenAdmision ea on a.ExamenId = ea.ExamenId
  inner join CarreraTecnica ct on a.CarreraId = ct.CarreraId
  where ea.FechaExamen = '2022-04-30' order by a.Apellidos;

-- View (Vistas)

create view vw_ListarAspirantesPorFechaExamen
  as
    select NoExpediente, Apellidos, Nombres, FechaExamen, CarreraTecnica, Estatus 
    from Aspirante a
    inner join ExamenAdmision ea on a.ExamenId = ea.ExamenId
    inner join CarreraTecnica ct on a.CarreraId = ct.CarreraId
go
select Apellidos, Nombres, Estatus from vw_ListarAspirantesPorFechaExamen where FechaExamen ='2022-04-30' order by Apellidos

select * from ResultadoExamenAdmision rea

--Trigger (Disparador)

create trigger tg_ActualizarEstadoAspirante on ResultadoExamenAdmision after insert
AS
BEGIN
  declare @Nota int = 0
  declare @Expediente varchar (128)
  declare @Estatus varchar(64) = 'NO ASIGNADO'
  set @Nota = (select Nota from inserted)
  set @Expediente =(select NoExpediente from inserted)
  if @Nota >= 70
  begin
    set @Estatus = 'SIGUE PROCESO DE ADMISIÓN'
  end
  else
  begin
    set @Estatus = 'NO SIGUE PROCESO DE ADMISIÓN'
  end
  update Aspirante set Estatus = @Estatus where NoExpediente = @Expediente  
END

insert into ResultadoExamenAdmision (NoExpediente, Anio, Descripcion, Nota) values('EXP-2022002', '2022', 'Resultado examen', 71)
insert into ResultadoExamenAdmision (NoExpediente, Anio, Descripcion, Nota) values('EXP-2022004', '2022', 'Resultado examen', 98)
select * from ResultadoExamenAdmision rea
select * from Aspirante a 
--store procedure

create function RPAD
(
  @string varchar(MAX), --Cadena inicial
  @length int, --tamaño de string
  @pad char --Caracter que se utilizara de remplazo
)
returns varchar(MAX)
as
begin
return @string + replicate(@pad, @length - len(@string))
end

create function LPAD
(
  @string varchar(MAX),
  @length int,
  @pad char
)
returns varchar(MAX)
as
begin
  return replicate(@pad, @length - len(@string)) + @string
end

select concat('2022', dbo.LPAD('1', 4, '0'))

select * from Aspirante a
select * from CarreraTecnica ct
select * from InversionCarreraTecnica ict

insert into InversionCarreraTecnica values(newid(), 1200,5,850,'012533CD-EFEA-4A37-A2AF-C2C0AF35E9F1')
insert into InversionCarreraTecnica values(newid(), 1200,7,850,'9BE97C7D-6F01-488A-BF9D-25B4A3855840')

select * from Cargo c
insert into Cargo values  (newid(), 'Pago de insripcion de carrera tecnica plan fin de semana', 'INSCT', 1200, 0, 0)
insert into Cargo values  (newid(), 'Pago mensual carrera técnica', 'PGMCT', 850, 0, 0)
insert into Cargo values  (newid(), 'Carné', 'CARNE', 30, 0, 0)

select * from InversionCarreraTecnica

-- Procedimiento almacenado para el proceso de inscripcion
--drop procedure sp_enrrollmentProcess
alter procedure sp_enrrollmentProcess @NoExpediente varchar(12), @Ciclo varchar(4), @MesInicioPago int, @CarreraId varchar(128)
as
begin
  --variable para informacino de aspirantes
  declare @Apellidos varchar (128)
  declare @Nombres varchar(128)
  declare @Direccion varchar(128)
  declare @Telefono varchar (64)
  declare @Email varchar(64)
  declare @JornadaId varchar(128)
  --variables para generar numero de carné
  declare @Exists int
  declare @Carne varchar (12)
  --variables para proceso de pago
  declare @MontoInscripcion numeric(10,2)
  declare @NumeroPagos int
  declare @MontoPago numeric(10,2)
  declare @Descripcion varchar(128)
  declare @Prefijo varchar(6)
  declare @CargoId varchar(128)
  declare @Monto numeric (10,2)
  declare @CorrelativoPago int
  --Inicio transaccion
begin transaction
begin try
    select @Apellidos = apellidos, @Nombres = Nombres, @Direccion = Direccion, @Telefono = Telefono, @Email = Email, @JornadaId = JornadaId
	  from Aspirante where NoExpediente = @NoExpediente
    set @Exists = (select top 1 a.Carne from Alumno a where SUBSTRING(a.Carne, 1,4) = @Ciclo ORDER BY a.Carne DESC)
	if @Exists is NULL
	BEGIN
      set @Carne = (@Ciclo * 10000) + 1
	END
	ELSE
	BEGIN
	  set @Carne = (select top 1 a.Carne from Alumno a where SUBSTRING(a.Carne,1,4) = @Ciclo ORDER BY a.Carne DESC) + 1
	END
	insert into Alumno values (@Carne, @Apellidos, @Nombres, @Direccion, @Telefono, concat(@Carne,@Email))
	insert into Inscripcion values (newid(), @Carne, @CarreraId, @JornadaId, @Ciclo, GETDATE())
	update Aspirante set Estatus = 'INSCRITO CICLO' + @Ciclo where NoExpediente = @NoExpediente
	--Proceso de cargos
	select @MontoInscripcion = MontoInscripcion, @NumeroPagos = NumeroPagos, @MontoPago = MontoPago
	  from InversionCarreraTecnica ict where ict.CarreraId = @CarreraId
/*  select @MontoPago*/
	select @CargoId = CargoId, @Descripcion =Descripcion, @Prefijo = Prefijo, @Monto = Monto
	  from Cargo c2 where c2.CargoId = 'A1CBEAB9-D413-4A6E-9370-0B10F086475A'
    insert into CuentaXCobrar values(concat(@Prefijo, SUBSTRING(@Ciclo,3,2), dbo.lpad('1',2,'0')),@Ciclo,@Carne,@CargoId,@Descripcion,GETDATE(),GETDATE(),@MontoInscripcion,0,0)
	--Cargo de pago de carné
	select @CargoId = CargoId, @Descripcion = Descripcion, @Prefijo = Prefijo, @Monto = Monto 
	from Cargo c2 where c2.CargoId = '265DA434-86AD-4A50-85B0-76ED5CA4AFBA'
	insert into CuentaXCobrar
	 values(concat(@Prefijo, SUBSTRING(@Ciclo, 3,2),dbo.LPAD('1',2,'0')),@Ciclo,@Carne,@CargoId,@Descripcion,GETDATE(),GETDATE(), @Monto, 0,0)
	--Cargos mensuales
	set @CorrelativoPago = 1
	select @CargoId = CargoId, @Descripcion = Descripcion, @Prefijo = Prefijo from Cargo c2 where c2.CargoId = '070C4134-6DC1-4B24-BA1C-A3DAA2AC75A6'
	while (@CorrelativoPago <= @NumeroPagos)
	BEGIN
		insert into CuentaXCobrar
		
		  values(CONCAT(@Prefijo, SUBSTRING(@Ciclo,3,2),dbo.lpad(@CorrelativoPago,2,'0')), @Ciclo, @Carne, @CargoId, @Descripcion, 
		  GETDATE(), concat(@Ciclo, '-',dbo.lpad(@MesInicioPago, 2,'0'),'-','05'),@MontoPago,0,0)
		set @CorrelativoPago = @CorrelativoPago + 1
		set @MesInicioPago = @MesInicioPago + 1
	END
    commit transaction
	select 'TRANSACTION SUCCESS' as status, @Carne as carne
  end try
  begin catch
/*  SELECT
            ERROR_NUMBER() AS ErrorNumber
            ,ERROR_SEVERITY() AS ErrorSeverity
            ,ERROR_STATE() AS ErrorState
            ,ERROR_PROCEDURE() AS ErrorProcedure
            ,ERROR_LINE() AS ErrorLine
            ,ERROR_MESSAGE() AS ErrorMessage;*/

    rollback transaction
	select 'TRANSACTION ERROR' as status, 0 as carne
	end catch
end

select CONCAT('INSC', SUBSTRING('2022',3,2),dbo.lpad('1','2','0'))
select name from sys.key_constraints where type ='PK' and OBJECT_NAME(parent_object_id) = N'CuentaXCobrar' 
alter table CuentaXCobrar drop constraint PK__CuentaXC__68A1C0DE33266155
alter table CuentaXCobrar add primary key (Cargo,Anio,Carne)
select (2022 * 10000)+1
select SUBSTRING('20220001',1,4)

execute sp_enrrollmentProcess 'EXP-2022002', '2022', 2, '012533CD-EFEA-4A37-A2AF-C2C0AF35E9F1'

execute sp_enrrollmentProcess 'EXP-2022004', '2022', 2, '9BE97C7D-6F01-488A-BF9D-25B4A3855840'

go

select * from Inscripcion
select * from CuentaXCobrar
select * from Aspirante a where a.NoExpediente = 'EXP-2022001';
select * from Alumno



select * from Cargo

select * from InversionCarreraTecnica

select * from CuentaXCobrar cxc


update Aspirante set Estatus = 'SIGUE PROCESO DE ADMISIÓN' where NoExpediente = 'EXP-2022004'


delete from Inscripcion where Carne >0
delete from CuentaXCobrar where Anio >0
delete from Alumno where Carne > 0

select*from CarreraTecnica

execute sp_rename 'CarreraTecnica.CarreraTecnica', 'Nombre', 'COLUMN'

use kalum_test;
select * from CarreraTecnica;

use kalum_test;
execute sp_rename 'Jornada.Jornada', 'JornadaNombre', 'COLUMN'
select * from Jornada;