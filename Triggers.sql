
USE BETi
GO

--EXCEPCIONES
--Usamos excepciones
EXECUTE sys.sp_addmessage @msgnum = 55000, @severity = 16, @msgtext = N'
You can not modify or delete a registered bet', @lang = 'us_english', @replace = 'replace';
EXECUTE sys.sp_addmessage @msgnum = 55000, @severity = 16, @msgtext = N'No se puede modificar ni eliminar una apuesta ya realizada', @lang = 'spanish', @replace = 'replace';
GO

EXECUTE sys.sp_addmessage @msgnum = 56000, @severity = 16, @msgtext = N'
You do not have enough money', @lang = 'us_english', @replace = 'replace';
EXECUTE sys.sp_addmessage @msgnum = 56000, @severity = 16, @msgtext = N'No posee saldo suficiente', @lang = 'spanish', @replace = 'replace';
GO

EXECUTE sys.sp_addmessage @msgnum = 57000, @severity = 16, @msgtext = N'The match is not in the bettable time range', @lang = 'us_english', @replace = 'replace';
EXECUTE sys.sp_addmessage @msgnum = 57000, @severity = 16, @msgtext = N'El partido no se encuentra en el rango de tiempo apostable', @lang = 'spanish', @replace = 'replace';
GO

EXECUTE sys.sp_addmessage @msgnum = 58000, @severity = 16, @msgtext = N'
This bet exceeds the maximun allowed. Your bet could not be placed ', @lang = 'us_english', @replace = 'replace';
EXECUTE sys.sp_addmessage @msgnum = 58000, @severity = 16, @msgtext = N'Esta apuesta supera el máximo permitido. No se ha podido realizar su apuesta', @lang = 'spanish', @replace = 'replace';
GO


--PROCEDIMIENTOS ALMACENADOS

CREATE PROCEDURE PoblarUsuarios AS

	BEGIN

		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('zamit@gmail.com', 'uoCW56L2a')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('pepe@gmail.com', 'uoCW56L2b')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('menditamk@gmail.com', 'uoCW56L2c')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('johndoe@gmail.com', 'uoCW56L2d')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('paco@gmail.com', 'uoCW56L2e')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('zopa@gmail.com', 'uoCW56L2f')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('carraga@gmail.com', 'uoCW56L2g')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('frasco@gmail.com', 'uoCW56L2h')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('jalazo@gmail.com', 'uoCW56L2i')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('kaki@gmail.com', 'uoCW56L2j')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('doma@gmail.com', 'uoCW56L2k')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('mariposo@gmail.com', 'uoCW56L2l')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('alex@gmail.com', 'uoCW56L2m')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('jeremias@gmail.com', 'uoCW56L2n')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('gardu@gmail.com', 'uoCW56L2o')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('maricarmen@gmail.com', 'uoCW56L2p')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('oscar@gmail.com', 'uoCW56L2q')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('sech@gmail.com', 'uoCW56L2r')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('jose@gmail.com', 'uoCW56L2s')
		INSERT INTO BET_Usuarios (CorreoElectronico, Contraseña) VALUES ('clara@gmail.com', 'uoCW56L2t')

	END

GO

EXECUTE PoblarUsuarios
GO

CREATE PROCEDURE PoblarEquipos AS

	BEGIN
		
		INSERT INTO BET_Equipos (ID, Nombre, Ciudad, Pais)
		VALUES('RSO', 'Real Sociedad de Fútbol', 'San Sebastián', 'España'), ('RMA', 'Real Madrid Club de Fútbol', 'Madrid', 'España'), ('VIL', 'Villareal', 'Villareal', 'España'), ('ATM', 'Club Atlético de Madrid', 'Madrid', 'España'), ('CAD', 'Cádiz Club de Fútbol', 'Cádiz', 'España'), ('GRA', 'Granada Club de Fútbol', 'Granada', 'España'), ('BET', 'Real Betis Balompié', 'Sevilla', 'España'), ('GET', 'Getafe Club de Fútbol', 'Getafe', 'España'), ('OSA', 'Club Atlético Osasuna', 'Pamplona', 'España'), ('ELC', 'Elche Club de Fútbol', 'Elche', 'España'), ('ATH', 'Athletic Club de Bilbao', 'Bilbao', 'España'), ('FCB', 'Fútbol Club Barcelona', 'Barcelona', 'España'), ('VCF', 'Valencia Club de Fútbol', 'Valencia', 'España'), ('ALA', 'Deportivo Alavés', 'Vitoria', 'España'), ('EIB', 'Sociedad Deportiva Eibar', 'Éibar', 'España'), ('SFC', 'Sevilla Fútbol Club', 'Sevilla', 'España'), ('CEL', 'Real Club Celta de Vigo', 'Vigo', 'España'), ('LEV', 'Levante Unión Deportiva', 'Valencia', 'España'), ('HUE', 'Sociedad Deportiva Huesca', 'Huesca', 'España'), ('VAL', 'Real Valladolid Club de Fútbol', 'Valladolid', 'España')

	END

GO

EXECUTE PoblarEquipos
GO

--Estudio Interfaz
--	Propósito: generar una cuota que será aplicada a una apuesta determinada.
--	Signtaura: CREATE FUNCTION GenerarCuota (@Tipo TINYINT, @IDPartido INT, @Resultado CHAR(1) = NULL, @Over_under DECIMAL(4,2) = NULL, @GolesLocal_Visitante DECIMAL(2,1) = NULL)
--	Entradas: los datos de la apuesta excepto el usuario y la cantidad apostada.
--	Salidas: la cuota generada aleatoriamente.
--	Postcondición: se devuelve el valor de la cuota actualizada.

CREATE PROCEDURE GenerarCuota @Tipo TINYINT, @IDPartido INT, @Resultado CHAR(1) = NULL, @Over_under DECIMAL(4,2) = NULL, @GolesLocal_Visitante DECIMAL(2,1) = NULL, @Cuota DECIMAL(4,2)OUTPUT AS

	BEGIN

		--En resguardo	
		DECLARE @CuotaAleatoria FLOAT
		SET @CuotaAleatoria = round((rand() * 14) + 1, 2)
		SET @Cuota = CAST(@CuotaAleatoria AS DECIMAL(4,2))

	END
	
GO	 

DECLARE @Cuota DECIMAL(4,2)
EXECUTE GenerarCuota 1, 1, '1', NULL, NULL, @Cuota OUTPUT
GO

--Estudio Interfaz
--	Propósito: registrar una apuesta de un determinado tipo, realizada por un usuario, a un determinado partido.
--	Signatura: CREATE PROCEDURE RealizarApuesta @Tipo VARCHAR(15), @CantidadApostada SMALLMONEY, @IDPartido INT, @CorreoUsuario VARCHAR(50), @Resultado CHAR(1) = NULL, @Over_under DECIMAL(4,2) = NULL, @GolesLocal_Visitante DECIMAL(2,1) = NULL
--	Entradas: el tipo de apuesta, la cantidad apostada, el ID del partido al que se apuesta, el correo que identifica al usuario apostante y la apuesta en concreto que se realiza.
--	Nota: el tipo de apuesta (TINYINT) rebicirá un valor entre 1 y 3. Cada valor se corresponderá con:  1 --> GanadorPartido
--		2 --> Over/under
--		3 --> ResultadoExacto	
--	Salidas: ninguna.	
--	Postcondición: se graba en la tabla apuesta la correspondiente apuesta con los datos especificados.

ALTER PROCEDURE RealizarApuesta @TipoApuesta TINYINT, @CantidadApostada SMALLMONEY, @IDPartido INT, @CorreoUsuario VARCHAR(50), @Resultado CHAR(1) = NULL, @Over_under DECIMAL(4,2) = NULL, @GolesLocal_Visitante DECIMAL(2,1) = NULL AS

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
				EXECUTE GenerarCuota @TipoApuesta, @IDPartido, @Resultado, @Over_under, @GolesLocal_Visitante, @Cuota OUTPUT

				IF([dbo].ComprobarSuperaMaximo(@IDPartido, @Cuota, @TipoApuesta, @CantidadApostada, @Resultado, @Over_under, @GolesLocal_Visitante) = 1)

					BEGIN

						DECLARE @MessageSupera NVARCHAR(255) = FormatMessage(58000);
						THROW 58000, @MessageSupera, 1

					END

				ELSE
					BEGIN

						--Insertamos la nueva apuesta
						INSERT INTO BET_Apuestas VALUES(@Tipo, @Cuota, @CantidadApostada, 0, @IDPartido, @CorreoUsuario, @Resultado, @Over_under, @GolesLocal_Visitante)

						SET @IDApuesta = (SELECT ID FROM BET_Apuestas WHERE ID = @@IDENTITY)

						--Actualizamos el saldo del usuario
						UPDATE BET_Usuarios
						SET Saldo = Saldo - @CantidadApostada
						WHERE CorreoElectronico = @CorreoUsuario

						--Insertamos el nuevo movimiento
						INSERT INTO BET_Movimientos VALUES (@CorreoUsuario, @CantidadApostada, @IDApuesta)

					END

			END

		ELSE
			
			BEGIN

				DECLARE @MessageSaldo NVARCHAR(255) = FormatMessage(56000);
				THROW 56000, @MessageSaldo, 1

			END

	END

GO

EXECUTE RealizarApuesta 1, 80.0, 1, 'zamit@gmail.com', '1', NULL, NULL
GO


--Estudio Interfaz
--	Propósito: grabar en la tabla partidos todas las combinaciones posibles entre los equipos que participan en la competición. Se establecerán todos los partidos como no finalizados para que se puedan realizar las apuestas.
--	Signatura: CREATE PROCEDURE PoblarPartidos
--	Entradas: ninguna.
--	Salidas: ninguna. 
--	Postcondición: quedan grabadas todas las combinaciones en la tabla Partidos.

CREATE PROCEDURE PoblarPartidos AS

	BEGIN

		INSERT INTO BET_Partidos (IDEquipoLocal, IDEquipoVisitante, GolesLocal, GolesVisitante, Apostable, Finalizado)
		SELECT L.ID, V.ID, 0, 0, 0, 0 FROM BET_Equipos AS L CROSS JOIN BET_Equipos AS V WHERE L.ID != V.ID

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
				SET @FechaPartido = DATEADD(DAY, @DiasAux, CAST(GETDATE() AS SMALLDATETIME))

				UPDATE BET_Partidos
				SET Fecha = @FechaPartido
				WHERE @Partido = ID

				FETCH NEXT FROM CPartidos INTO @Partido

			END

		CLOSE CPartidos
		DEALLOCATE CPartidos

	END

GO

EXECUTE PoblarPartidos
GO

--Estudio Interfaz
--	Propósito: grabar en la tabla movimientos el dinero ganado tras una apuesta acertada. También se actualiza la 
--  tabla apuestas (Acertada)
--	Signatura: CREATE PROCEDURE GrabarMovimientoApuesta @IDApuesta INT
--	Entradas: la apuesta
--	Salidas: ninguna
--	Postcondición: genera un nuevo movimiento, en el que se ingresa la cantidad ganada por la apuesta, y se modifica
--  la apuesta correspondiente, donde se marcará dicha apuesta como acertada.

CREATE PROCEDURE GrabarMovimientoApuesta @IDApuesta INT AS

	BEGIN

		--Grabar movimiento
		INSERT INTO BET_Movimientos 
		SELECT CorreoUsuario, Cuota * CantidadApostada AS [Beneficio], ID FROM BET_Apuestas
		WHERE @IDApuesta = ID 

		--Actualizar la tabla apuesta
		UPDATE BET_Apuestas
		SET Acertada = 1 WHERE @IDApuesta = ID

		--Actualizamos el saldo del usuario
		UPDATE BET_Usuarios
		SET Saldo = Saldo + (A.Cuota * A.CantidadApostada)
		FROM BET_Usuarios AS U
		INNER JOIN BET_Apuestas AS A
		ON U.CorreoElectronico = A.CorreoUsuario
		WHERE A.ID = @IDApuesta 

	END

GO

--Estudio Interfaz
--	Propósito: actualizar el saldo del usuario tras realizar un ingreso de saldo.
--	Signatura: CREATE PROCEDURE IngresarDinero @CorreoUsuario VARCHAR(50), @CantidadIngresar MONEY
--	Entradas: el correo del usuario y la cantidad a ingresar.
--	Salidas: ninguna.
--	Postcondiciones: se actualiza el saldo del usuario.

CREATE PROCEDURE IngresarDinero @CorreoUsuario VARCHAR(50), @CantidadIngresar MONEY AS

	BEGIN

		UPDATE BET_Usuarios 
		SET Saldo = Saldo + @CantidadIngresar
		WHERE CorreoElectronico = @CorreoUsuario

		INSERT INTO BET_Movimientos
		VALUES(@CorreoUsuario, @CantidadIngresar, NULL)

	END

GO

EXECUTE IngresarDinero 'zamit@gmail.com', 100.0
GO

SELECT * FROM BET_Usuarios
GO

--Estudio Interfaz
--	Propósito: actualizar el saldo del usuario tras realizar una retirada de saldo.
--	Signatura: CREATE PROCEDURE RetirarDinero @CorreoUsuario VARCHAR(50), @CantidadRetirar MONEY
--	Entradas: el correo del usuario y la cantidad a retirar.
--	Salidas: ninguna.
--	Postcondiciones: se actualiza el saldo del usuario.

ALTER PROCEDURE RetirarDinero @CorreoUsuario VARCHAR(50), @CantidadRetirar MONEY AS

	BEGIN

		DECLARE @SaldoUsuario MONEY
		SET @SaldoUsuario = (SELECT Saldo FROM BET_Usuarios WHERE CorreoElectronico = @CorreoUsuario)

		IF(@SaldoUsuario - @CantidadRetirar < 0.0)
			BEGIN
				UPDATE BET_Usuarios 
				SET Saldo = 0
				WHERE CorreoElectronico = @CorreoUsuario
			END
		ELSE 
			BEGIN
				UPDATE BET_Usuarios 
				SET Saldo = Saldo - @CantidadRetirar
				WHERE CorreoElectronico = @CorreoUsuario
			END


		INSERT INTO BET_Movimientos
		VALUES(@CorreoUsuario, @CantidadRetirar, NULL)

	END

GO

EXECUTE RetirarDinero 'zamit@gmail.com', 10.0
GO

--FUNCIONES

--Estudio Interfaz
--	Propósito: comprobar si los premios de una misma apuesta a un determinado evento supera el máximo fijado. 
--	Signatura: CREATE FUNCTION ComprobarSuperaMaximo (@IDPartido INT, @Cuota DECIMAL(4,2), @Tipo TINYINT, @CantidadApostada SMALLMONEY, @Resultado CHAR(1) = NULL, @Over_under DECIMAL(4,2) = NULL, @GolesLocal_Visitante DECIMAL(2,1) = NULL) RETURNS BIT
--	Entradas: el ID del partido, el tipo de apuesta, la cuota y cantidad apostada para calcular el beneficio y, el tipo de apuesta que se realiza.
--	Salidas: un valor booleano que indique que si supera el máximo o no.
--	Postcondiciones: se devuelve el valor de tipo BIT asociado al nombre.
--		0 --> No supera
--		1 --> Supera

CREATE FUNCTION ComprobarSuperaMaximo (@IDPartido INT, @Cuota DECIMAL(4,2), @Tipo TINYINT, @CantidadApostada SMALLMONEY, @Resultado CHAR(1) = NULL, @Over_under DECIMAL(4,2) = NULL, @GolesLocal_Visitante DECIMAL(2,1) = NULL) RETURNS BIT AS

	BEGIN
		
		DECLARE @Supera BIT
		SET @Supera = 0
		DECLARE @BeneficioTotal MONEY
			
		SET @BeneficioTotal	= (CASE @Tipo

									WHEN 1 THEN (SELECT SUM(CantidadApostada * Cuota) FROM BET_Apuestas WHERE IDPartido = @IDPartido AND Resultado = @Resultado)
									WHEN 2 THEN (SELECT SUM(CantidadApostada * Cuota) FROM BET_Apuestas WHERE IDPartido = @IDPartido AND [Over/under] = @Over_under)
									WHEN 3 THEN (SELECT SUM(CantidadApostada * Cuota) FROM BET_Apuestas WHERE IDPartido = @IDPartido AND GolesLocal_Visitante = @GolesLocal_Visitante)

								END)


		IF(@BeneficioTotal + (@Cuota*@CantidadApostada) > 10000.0)

			BEGIN
				SET @Supera = 1
			END
	
		RETURN @Supera

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

--Trigger que comprueba que, al realizar una apuesta, el partido al que se apuesta, sea apostable. 
--En caso de que no se pueda apostar, lanzará un mensaje.
CREATE TRIGGER ComprobarPartidoApostable ON BET_Apuestas INSTEAD OF INSERT AS
	BEGIN
		
		DECLARE @FechaPartido SMALLDATETIME
		
		SELECT @FechaPartido = P.Fecha FROM inserted AS I INNER JOIN BET_Partidos AS P ON I.IDPartido = P.ID

		IF(CAST(GETDATE() AS smalldatetime) < DATEADD(DAY, -2, @FechaPartido) OR CAST(GETDATE() AS smalldatetime) > @FechaPartido)

			BEGIN

				DECLARE @Message NVARCHAR(255) = FormatMessage(57000);
				THROW 57000, @Message, 1

			END

	END
GO

--Trigger que muestra un mensaje de confirmación de que se ha realizado la apuesta.
CREATE TRIGGER ConfirmacionApueta ON BET_Apuestas AFTER INSERT AS
	
	BEGIN

		PRINT 'La apuesta se ha realizado correctamente'

	END

GO