
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


--PROCEDIMIENTOS ALMACENADOS

CREATE PROCEDURE PoblarUsuarios AS

	BEGIN

		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('zamit@gmail.com', 'uoCW56L2a')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('pepe@gmail.com', 'uoCW56L2b')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('menditamk@gmail.com', 'uoCW56L2c')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('johndoe@gmail.com', 'uoCW56L2d')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('paco@gmail.com', 'uoCW56L2e')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('zopa@gmail.com', 'uoCW56L2f')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('carraga@gmail.com', 'uoCW56L2g')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('frasco@gmail.com', 'uoCW56L2h')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('jalazo@gmail.com', 'uoCW56L2i')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('kaki@gmail.com', 'uoCW56L2j')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('doma@gmail.com', 'uoCW56L2k')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('mariposo@gmail.com', 'uoCW56L2l')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('alex@gmail.com', 'uoCW56L2m')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('jeremias@gmail.com', 'uoCW56L2n')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('gardu@gmail.com', 'uoCW56L2o')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('maricarmen@gmail.com', 'uoCW56L2p')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('oscar@gmail.com', 'uoCW56L2q')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('sech@gmail.com', 'uoCW56L2r')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('jose@gmail.com', 'uoCW56L2s')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contrase�a) VALUES ('clara@gmail.com', 'uoCW56L2t')

	END

GO

EXECUTE PoblarUsuarios
GO

CREATE PROCEDURE PoblarEquipos AS

	BEGIN
		
		INSERT INTO BET_Equipos (ID, Nombre, Ciudad, Pais)
		VALUES('RSO', 'Real Sociedad de F�tbol', 'San Sebasti�n', 'Espa�a'), ('RMA', 'Real Madrid Club de F�tbol', 'Madrid', 'Espa�a'), ('VIL', 'Villareal', 'Villareal', 'Espa�a'), ('ATM', 'Club Atl�tico de Madrid', 'Madrid', 'Espa�a'), ('CAD', 'C�diz Club de F�tbol', 'C�diz', 'Espa�a'), ('GRA', 'Granada Club de F�tbol', 'Granada', 'Espa�a'), ('BET', 'Real Betis Balompi�', 'Sevilla', 'Espa�a'), ('GET', 'Getafe Club de F�tbol', 'Getafe', 'Espa�a'), ('OSA', 'Club Atl�tico Osasuna', 'Pamplona', 'Espa�a'), ('ELC', 'Elche Club de F�tbol', 'Elche', 'Espa�a'), ('ATH', 'Athletic Club de Bilbao', 'Bilbao', 'Espa�a'), ('FCB', 'F�tbol Club Barcelona', 'Barcelona', 'Espa�a'), ('VCF', 'Valencia Club de F�tbol', 'Valencia', 'Espa�a'), ('ALA', 'Deportivo Alav�s', 'Vitoria', 'Espa�a'), ('EIB', 'Sociedad Deportiva Eibar', '�ibar', 'Espa�a'), ('SFC', 'Sevilla F�tbol Club', 'Sevilla', 'Espa�a'), ('CEL', 'Real Club Celta de Vigo', 'Vigo', 'Espa�a'), ('LEV', 'Levante Uni�n Deportiva', 'Valencia', 'Espa�a'), ('HUE', 'Sociedad Deportiva Huesca', 'Huesca', 'Espa�a'), ('VAL', 'Real Valladolid Club de F�tbol', 'Valladolid', 'Espa�a')

	END

GO

--Estudio Interfaz
--	Prop�sito: generar una cuota que ser� aplicada a una apuesta determinada.
--	Signtaura: CREATE FUNCTION GenerarCuota (@Tipo TINYINT, @IDPartido INT, @Resultado CHAR(1) = NULL, @Over_under DECIMAL(4,2) = NULL, @GolesLocal_Visitante DECIMAL(2,1) = NULL)
--	Entradas: los datos de la apuesta excepto el usuario y la cantidad apostada.
--	Salidas: la cuota generada aleatoriamente.
--	Postcondici�n: se devuelve el valor de la cuota actualizada.

CREATE PROCEDURE GenerarCuota @Tipo TINYINT, @IDPartido INT, @Resultado CHAR(1) = NULL, @Over_under DECIMAL(4,2) = NULL, @GolesLocal_Visitante DECIMAL(2,1) = NULL, @Cuota DECIMAL(4,2)OUTPUT AS

	BEGIN

		--En resguardo	
		DECLARE @CuotaAleatoria FLOAT
		SET @CuotaAleatoria = round((rand() * 14) + 1, 2)
		SET @Cuota = CAST(@CuotaAleatoria AS DECIMAL(4,2))

	END
	
GO	 


--Estudio Interfaz
--	Prop�sito: registrar una apuesta de un determinado tipo, realizada por un usuario, a un determinado partido.
--	Signatura: CREATE PROCEDURE RealizarApuesta @Tipo VARCHAR(15), @CantidadApostada SMALLMONEY, @IDPartido INT, @CorreoUsuario VARCHAR(50), @Resultado CHAR(1) = NULL, @Over_under DECIMAL(4,2) = NULL, @GolesLocal_Visitante DECIMAL(2,1) = NULL
--	Entradas: el tipo de apuesta, la cantidad apostada, el ID del partido al que se apuesta, el correo que identifica al usuario apostante y la apuesta en concreto que se realiza.
--	Nota: el tipo de apuesta (TINYINT) rebicir� un valor entre 1 y 3. Cada valor se corresponder� con:  1 --> GanadorPartido
--		2 --> Over/under
--		3 --> ResultadoExacto	
--	Salidas: ninguna.	
--	Postcondici�n: se graba en la tabla apuesta la correspondiente apuesta con los datos especificados.

CREATE PROCEDURE RealizarApuesta @TipoApuesta TINYINT, @CantidadApostada SMALLMONEY, @IDPartido INT, @CorreoUsuario VARCHAR(50), @Resultado CHAR(1) = NULL, @Over_under DECIMAL(4,2) = NULL, @GolesLocal_Visitante DECIMAL(2,1) = NULL AS

	BEGIN

		SET NOCOUNT ON;

		DECLARE @Tipo VARCHAR(15)
		DECLARE @Cuota DECIMAL(4,2)
		DECLARE @IDApuesta SMALLINT 	

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
				EXECUTE GenerarCuota @Tipo, @IDPartido, @Resultado, @Over_under, @GolesLocal_Visitante, @Cuota OUTPUT

				--Insertamos la nueva apuesta
				INSERT INTO BET_Apuestas VALUES(@TipoApuesta, @Tipo, @Cuota, @CantidadApostada, @IDPartido, @CorreoUsuario, @Resultado, @Over_under, @GolesLocal_Visitante)

				SET @IDApuesta = (SELECT ID FROM BET_Apuestas WHERE ID = @@IDENTITY)

				--Actualizamos el saldo del usuario
				UPDATE BET_Usuarios
				SET Saldo = Saldo - @CantidadApostada
				WHERE CorreoElectronico = @CorreoUsuario

				--Insertamos el nuevo movimiento
				INSERT INTO BET_Movimientos VALUES (@CorreoUsuario, @CantidadApostada, @IDApuesta)

			END

		ELSE
			
			BEGIN

				DECLARE @Message NVARCHAR(255) = FormatMessage(56000);
				THROW 56000, @Message, 1

			END

	END

GO

--Estudio Interfaz
--	Prop�sito: grabar en la tabla partidos todas las combinaciones posibles entre los equipos que participan en la competici�n. Se establecer�n todos los partidos como no finalizados para que se puedan realizar las apuestas.
--	Signatura: CREATE PROCEDURE PoblarPartidos
--	Entradas: ninguna.
--	Salidas: ninguna. 
--	Postcondici�n: quedan grabadas todas las combinaciones en la tabla Partidos.

CREATE PROCEDURE PoblarPartidos AS

	BEGIN

		INSERT INTO BET_Partidos (IDEquipoLocal, IDEquipoVisitante)
		SELECT L.ID, V.ID FROM BET_Equipos AS L CROSS JOIN BET_Equipos AS V WHERE L.ID != V.ID

		DECLARE CPartidos CURSOR FOR SELECT ID FROM BET_Partidos
		DECLARE @Partido SMALLINT
		DECLARE @FechaPartido SMALLDATETIME
		DECLARE @DiasAux SMALLINT
		DECLARE @HorasAux TINYINT

		SET @DiasAux = 0

		OPEN CPartidos

		FETCH NEXT FROM CPartidos INTO @Partido

		WHILE @@FETCH_STATUS = 0
			BEGIN

				SET @DiasAux = @DiasAux + 2
				SET @FechaPartido = DATEADD(DAY, @DiasAux, GETDATE())

				UPDATE BET_Partidos
				SET GolesLocal = 0, GolesVisitante = 0, Apostable = 0, Finalizado = 0, Fecha = @FechaPartido
				WHERE @Partido = ID

				FETCH NEXT FROM CPartidos INTO @Partido

			END

		CLOSE CPartidos
		DEALLOCATE CPartidos

	END

GO

--Estudio Interfaz
--	Prop�sito: grabar en la tabla movimientos el dinero ganado tras una apuesta acertada. Tambi�n se actualiza la 
--  tabla apuestas (Acertada)
--	Signatura: CREATE PROCEDURE GrabarMovimientoApuesta @IDApuesta INT
--	Entradas: la apuesta
--	Salidas: ninguna
--	Postcondici�n: genera un nuevo movimiento, en el que se ingresa la cantidad ganada por la apuesta, y se modifica
--  la apuesta correspondiente, donde se marcar� dicha apuesta como acertada.

CREATE PROCEDURE GrabarMovimientoApuesta @IDApuesta INT AS

	BEGIN

		--Grabar movimiento
		INSERT INTO BET_Movimientos 
		SELECT CorreoUsuario, Cuota * CantidadApostada AS [Beneficio], ID FROM BET_Apuestas
		WHERE @IDApuesta = ID 

		--Actualizar la tabla apuesta
		UPDATE BET_Apuestas
		SET Acertada = 1 WHERE @IDApuesta = ID

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