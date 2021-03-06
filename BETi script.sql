--Proyecto realizado por: 
--Juan Antonio Quintero
--Alejandro Gata
--Jaime Albarr�n

CREATE DATABASE BETi
GO

USE BETi
GO

CREATE TABLE BET_Usuarios (

	CorreoElectronico VARCHAR(50) NOT NULL,
	Contrase�a VARCHAR(128) NOT NULL,
	Saldo MONEY NOT NULL DEFAULT 0,
	
	CONSTRAINT PKUsuarios PRIMARY KEY(CorreoElectronico),
	CONSTRAINT CKCorreoElectronico CHECK (CorreoElectronico LIKE '%@%.%'),
	CONSTRAINT CKContrase�a CHECK (DATALENGTH(Contrase�a) > 7),
	CONSTRAINT CKSaldo CHECK (Saldo >= 0.0)

)
GO

CREATE TABLE BET_Equipos (

	ID CHAR(3) NOT NULL,
	Nombre VARCHAR(40) NOT NULL,
	Ciudad VARCHAR(30) NULL,
	Pais VARCHAR(30) NULL,

	CONSTRAINT PKEquipos PRIMARY KEY(ID)

)
GO

CREATE TABLE BET_Partidos (
	
	ID INT NOT NULL IDENTITY(1,1),
	IDEquipoLocal CHAR(3) NOT NULL,
	IDEquipoVisitante CHAR(3) NOT NULL,
	GolesLocal TINYINT NOT NULL,
	GolesVisitante TINYINT NOT NULL,
	Apostable BIT NOT NULL,
	Finalizado BIT NOT NULL,
	Fecha SMALLDATETIME NULL,

	CONSTRAINT PKPartidos PRIMARY KEY(ID),
	CONSTRAINT FKPartidosEquipoLocal FOREIGN KEY(IDEquipoLocal) REFERENCES BET_Equipos(ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT FKPartidosEquipoVisitante FOREIGN KEY(IDEquipoVisitante) REFERENCES BET_Equipos(ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT CKGolesLocal CHECK (GolesLocal >= 0),
	CONSTRAINT CKGolesVisitante CHECK (GolesVisitante >= 0) 

)
GO

CREATE TABLE BET_Apuestas (

	ID INT NOT NULL IDENTITY(1,1),
	Tipo VARCHAR(15) NOT NULL,
	Cuota DECIMAL(4,2) NOT NULL,
	CantidadApostada SMALLMONEY NOT NULL,
	Acertada BIT NULL,
	IDPartido INT NOT NULL,
	CorreoUsuario VARCHAR(50) NOT NULL,
	Resultado CHAR(1) NULL,
	[Over/Under] DECIMAL(2,1) NULL,
	GolesLocal_Visitante DECIMAL(2,1) NULL,		--Local --> Parte entera DECIMAL
												--Visitante --> Parte decimal DECIMAL

	CONSTRAINT PKApuestas PRIMARY KEY(ID),
	CONSTRAINT FKApuestasPartidos FOREIGN KEY(IDPartido) REFERENCES BET_Partidos(ID) ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT FKApuestasUsuarios FOREIGN KEY(CorreoUsuario) REFERENCES BET_Usuarios(CorreoElectronico) ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT CKCuota CHECK(Cuota > 1.00),
	CONSTRAINT CKTipo CHECK (Tipo IN ('GanadorPartido', 'Over/under', 'ResultadoExacto')),
	CONSTRAINT CKResultado CHECK (Resultado IN ('1', 'x', '2')),
	CONSTRAINT CKOverUnder CHECK ([Over/Under] % 0.5 = 0),
	CONSTRAINT CKGolesLocal_Visitante CHECK (GolesLocal_Visitante >= 0.0)
	 
)
GO

CREATE TABLE BET_Movimientos (

	ID INT NOT NULL IDENTITY(1,1),
	CorreoUsuario VARCHAR(50) NOT NULL,
	Cantidad SMALLMONEY NOT NULL,
	IDApuesta INT NULL,

	CONSTRAINT PKMovimientos PRIMARY KEY(ID),
	CONSTRAINT FKMovimientosUsuarios FOREIGN KEY(CorreoUsuario) REFERENCES BET_Usuarios(CorreoElectronico) ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT FKMovimientosApuestas FOREIGN KEY(IDApuesta) REFERENCES BET_Apuestas(ID) ON DELETE NO ACTION ON UPDATE NO ACTION

)