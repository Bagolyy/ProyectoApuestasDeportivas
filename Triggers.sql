
USE BETi
GO

--EXCEPCIONES
--Usamos excepciones
EXECUTE sys.sp_addmessage @msgnum = 55000, @severity = 16, @msgtext = N'
You can not modify or delete a registered bet', @lang = 'us_english', @replace = 'replace';
EXECUTE sys.sp_addmessage @msgnum = 55000, @severity = 16, @msgtext = N'No se puede modificar ni eliminar una apuesta ya realizada', @lang = 'spanish', @replace = 'replace';
GO

--Usamos excepciones
EXECUTE sys.sp_addmessage @msgnum = 56000, @severity = 16, @msgtext = N'
You do not have enough money', @lang = 'us_english', @replace = 'replace';
EXECUTE sys.sp_addmessage @msgnum = 56000, @severity = 16, @msgtext = N'No posee saldo suficiente', @lang = 'spanish', @replace = 'replace';
GO


--FUNCIONES

--Estudio Interfaz
--	Propósito: generar una cuota que será aplicada a una apuesta determinada.
--	Signtaura: CREATE FUNCTION GenerarCuota (@Tipo VARCHAR(15), @IDPartido INT, @Resultado CHAR(1) = NULL, @Over_under DECIMAL(4,2) = NULL, @GolesLocal_Visitante DECIMAL(2,1) = NULL)
--	Entradas: los datos de la apuesta excepto el usuario y la cantidad apostada.
--	Salidas: la cuota generada aleatoriamente.

CREATE FUNCTION GenerarCuota (@Tipo VARCHAR(15), @IDPartido INT, @Resultado CHAR(1) = NULL, @Over_under DECIMAL(4,2) = NULL, @GolesLocal_Visitante DECIMAL(2,1) = NULL) RETURNS DECIMAL(4,2) AS

	BEGIN

		--En resguardo	
		DECLARE @CuotaAleatoria FLOAT
		SET @CuotaAleatoria = (rand() * 14) + 1
		

		RETURN round(CAST(@CuotaAleatoria AS DECIMAL(4,2)), 2, 0)

	END
	
GO	 


--PROCEDIMIENTOS ALMACENADOS

--Estudio Interfaz
--	Propósito: registrar una apuesta de un determinado tipo, realizada por un usuario, a un determinado partido.
--	Signatura: CREATE PROCEDURE RealizarApuesta @Tipo VARCHAR(15), @CantidadApostada SMALLMONEY, @IDPartido INT, @CorreoUsuario VARCHAR(50), @Resultado CHAR(1) = NULL, @Over_under DECIMAL(4,2) = NULL, @GolesLocal_Visitante DECIMAL(2,1) = NULL
--	Entradas: el tipo de apuesta, la cantidad apostada, el ID del partido al que se apuesta, el correo que identifica al usuario apostante y la apuesta en concreto que se realiza.
--	Salidas: se graba en la tabla apuesta la correspondiente apuesta con los datos especificados.

CREATE PROCEDURE RealizarApuesta @TipoApuesta TINYINT, @CantidadApostada SMALLMONEY, @IDPartido INT, @CorreoUsuario VARCHAR(50), @Resultado CHAR(1) = NULL, @Over_under DECIMAL(4,2) = NULL, @GolesLocal_Visitante DECIMAL(2,1) = NULL AS

	BEGIN

		SET NOCOUNT ON;

		DECLARE @Tipo VARCHAR(15)
		DECLARE @Cuota DECIMAL(4,2)

		SET @Tipo = ( CASE 
						WHEN @TipoApuesta = 1 THEN 'GanadorPartido'
						WHEN @TipoApuesta = 2 THEN 'Over/under'
						ELSE 'ResultadoExacto'

						END
					)


		--Comprobamos el saldo del usuario y la cantidad apostada
		IF(@CantidadApostada <= (SELECT Saldo FROM BET_Usuarios WHERE CorreoElectronico = @CorreoUsuario))

			BEGIN
	
				--Generamos una cuota aleatoria
				SET @Cuota = GenerarCuota (@Tipo, @IDPartido, @Resultado, @Over_under, @GolesLocal_Visitante)

				--Insertamos la nueva apuesta
				INSERT INTO BET_Apuestas VALUES(@TipoApuesta, @Tipo, @Cuota, @CantidadApostada, @IDPartido, @CorreoUsuario, @Resultado, @Over_under, @GolesLocal_Visitante)

				--Actualizamos el saldo del usuario
				UPDATE BET_Usuarios
				SET Saldo = Saldo - @CantidadApostada
				WHERE CorreoElectronico = @CorreoUsuario

			END

		ELSE
			
			BEGIN

				DECLARE @Message NVARCHAR(255) = FormatMessage(56000);
				THROW 56000, @Message, 1

			END

	END

GO


--TRIGGERS

--Trigger que controla que no se puedan modificar ni eliminar apuestas ya realizadas.
CREATE TRIGGER ModificarApuesta ON BET_Apuestas INSTEAD OF UPDATE, DELETE AS
	BEGIN

		DECLARE @Message NVARCHAR(255) = FormatMessage(55000);
		THROW 55000, @Message, 1

	END
GO