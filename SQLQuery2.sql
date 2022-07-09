--create database kalum_test
--go
use kalum_test
go
create table ExamenAdmision
(
  ExamenId varchar(128) primary key not null,
  FechaExamen datetime not null
)
go
create table CarreraTecnica
(
  CarreraId varchar(128) primary key not null,
  CarreraTecnica varchar(128) not null
)
go
create table Jornada
(
  JornadaId varchar(128) primary key not null,
  Jornada varchar(2) not null,
  Descripcion varchar(128) not null
)
go
create table Aspirante
(
  NoExpediente varchar (128) primary key not null,
  Apellidos varchar(128) not null,
  Nombres varchar(128) not null,
  Direccion varchar(128) not null,
  Telefono varchar(64) not null,
  Email varchar(128) not null unique,
  Estatus varchar(32) default 'NO ASIGNADO',
  CarreraId varchar(128) not null,
  ExamenId varchar(128) not null,
  JornadaId varchar(128) not null,
  constraint FK_ASPIRANTE_CARRERA_TECNICA foreign key (CarreraId) references CarreraTecnica(CarreraId),
  constraint FK_ASPIRANTE_EXAMEN_ADMISION foreign key (ExamenId) references ExamenAdmision(ExamenId),
  constraint FK_ASPIRANTE_JORNADA foreign key (JornadaId) references Jornada(JornadaId)
)
go
create table Alumno
(
  Carne varchar(8) primary key not null,
  Apellidos varchar(128) not null,
  Nombres varchar(128) not null,
  Direccion varchar(128) not null,
  Telefono varchar(64) not null,
  Email varchar(64) not null
)
go
create table Cargo
(
  CargoId varchar(128) primary key not null,
  Descripcion varchar(128) not null,
  Prefijo varchar(64) not null,
  Monto Decimal(10,2) not null,
  GeneraMora bit not null,
  PorcentajeMora int not null
)
go
create table InversionCarreraTecnica
(
  InversionId varchar(128) primary key not null,
  MontoInscripcion decimal(10,2) not null,
  NumeroPagos int not null,
  MontoPago decimal(10,2) not null,
  CarreraId varchar(128) not null,
  constraint FK_INVERSIONCARRERATECNICA_CARRERA foreign key (CarreraId) references CarreraTecnica(CarreraId)
)
go
create table Inscripcion
(
  InscripcionId varchar(128) primary key not null,
  Carne varchar(8) not null,
  CarreraId varchar(128) not null,
  JornadaId varchar(128) not null,
  Ciclo varchar(4) not null,
  FechaInscripcion datetime not null,
  constraint FK_INSCRIPCION_ALUMNO foreign key (Carne) references Alumno(Carne),
  constraint FK_INSCRIPCION_CARRERA foreign key (CarreraId) references CarreraTecnica(CarreraId),
  constraint FK_INSCRIPCION_JORNADA foreign key (JornadaId) references Jornada(JornadaId)
)
go
create table CuentaXCobrar
(
  Cargo varchar(128) primary key not null,
  Anio varchar(4) not null,
  Carne varchar(8) not null,
  CargoId varchar(128) not null,
  Descripcion varchar(128) not null,
  FechaCargo datetime not null,
  FechaAplica datetime not null,
  Monto decimal(10,2) not null,
  Mora decimal(10,2) not null,
  Descuento decimal(10,2) not null
  constraint FK_CuentaXCobrar_Alumno foreign key (Carne) references Alumno(Carne),
  constraint FK_CuentaXCobrar_Cargo foreign key (CargoId) references Cargo(CargoId)
)
go
create table ResultadoExamenAdmision
(
  NoExpediente varchar(128)  not null,
  Anio varchar(4)  not null,
  Descripcion varchar(128) not null,
  Nota int not null,
  primary key (NoExpediente, Anio),
  constraint FK_RESULTADOEXAMENADMISION_ASPIRANTE foreign key (NoExpediente) references Aspirante (NoExpediente)
)
go
create table InscripcionPago
(
  BoletaPago varchar(128) not null,
  NoExpediente varchar(128) not null,
  Anio varchar(4) not null,
  FechaPago datetime not null,
  Monto decimal(10,2) not null,
  primary key (BoletaPago, NoExpediente, Anio),
  constraint FK_INSCRIPCIONPAGO_ASPIRANTE foreign key (NoExpediente) references Aspirante (NoExpediente)
)