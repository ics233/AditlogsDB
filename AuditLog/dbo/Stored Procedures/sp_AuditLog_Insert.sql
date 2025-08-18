
    CREATE   PROCEDURE [dbo].[sp_AuditLog_Insert]
        @UserID INT,
        @CompanyID INT,
        @Action NVARCHAR(100),
        @TableName NVARCHAR(100),
        @RecordID NVARCHAR(50) = NULL,
        @OldValues NVARCHAR(MAX) = NULL,
        @NewValues NVARCHAR(MAX) = NULL,
        @IPAddress NVARCHAR(45) = NULL,
        @UserAgent NVARCHAR(500) = NULL,
        @SessionID NVARCHAR(100) = NULL,
        @Timestamp DATETIME = NULL,
        @Status NVARCHAR(50) = 'SUCCESS',
        @ErrorMessage NVARCHAR(MAX) = NULL,
        @AdditionalData NVARCHAR(MAX) = NULL,
        @Username NVARCHAR(100) = NULL,
        @UserFirstName NVARCHAR(100) = NULL,
        @UserLastName NVARCHAR(100) = NULL,
        @UserEmail NVARCHAR(255) = NULL,
        @CompanyName NVARCHAR(255) = NULL
    AS
    BEGIN
        SET NOCOUNT ON;
        
        IF @Timestamp IS NULL
            SET @Timestamp = GETDATE();
        
        INSERT INTO AuditLogs (
            UserID, CompanyID, Action, TableName, RecordID, 
            OldValues, NewValues, IPAddress, UserAgent, SessionID, 
            Timestamp, Status, ErrorMessage, AdditionalData,
            Username, UserFirstName, UserLastName, UserEmail, CompanyName
        )
        VALUES (
            @UserID, @CompanyID, @Action, @TableName, @RecordID,
            @OldValues, @NewValues, @IPAddress, @UserAgent, @SessionID,
            @Timestamp, @Status, @ErrorMessage, @AdditionalData,
            @Username, @UserFirstName, @UserLastName, @UserEmail, @CompanyName
        );
        
        SELECT SCOPE_IDENTITY() AS AuditLogID;
    END