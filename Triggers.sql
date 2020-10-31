USE BETi
GO

--Usamos excepciones
EXECUTE sys.sp_addmessage @msgnum = 55000, @severity = 16, @msgtext = N'
You can not modify or delete a registered bet', @lang = 'us_english', @replace = 'replace';
EXECUTE sys.sp_addmessage @msgnum = 55000, @severity = 16, @msgtext = N'No se puede modificar ni eliminar una apuesta ya realizada', @lang = 'spanish', @replace = 'replace';
GO

--Trigger que controla que no se puedan modificar ni eliminar apuestas ya realizadas.
CREATE TRIGGER ModificarApuesta ON BET_Apuestas INSTEAD OF UPDATE, DELETE AS
	BEGIN

		DECLARE @Message NVARCHAR(255) = FormatMessage(55000);
		THROW 55000, @Message, 1

	END
GO