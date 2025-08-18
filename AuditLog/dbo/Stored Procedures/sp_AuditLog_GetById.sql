
    CREATE   PROCEDURE [dbo].[sp_AuditLog_GetById]
        @AuditLogID INT
    AS
    BEGIN
        SET NOCOUNT ON;
        
        SELECT 
            AuditLogID,
            UserID,
            CompanyID,
            Action,
            TableName,
            RecordID,
            OldValues,
            NewValues,
            IPAddress,
            UserAgent,
            SessionID,
            Timestamp,
            Status,
            ErrorMessage,
            AdditionalData,
            Username,
            UserFirstName,
            UserLastName,
            UserEmail,
            CompanyName,
            -- Enhanced user display: Name (ID) or fallback to ID
            CASE 
                WHEN UserFirstName IS NOT NULL AND UserLastName IS NOT NULL 
                THEN UserFirstName + ' ' + UserLastName + ' (ID: ' + CAST(UserID AS VARCHAR(10)) + ')'
                ELSE 'User ID: ' + CAST(UserID AS VARCHAR(10))
            END AS UserDisplayName,
            -- Enhanced company display: Name (ID) or fallback to ID
            CASE 
                WHEN CompanyName IS NOT NULL 
                THEN CompanyName + ' (ID: ' + CAST(CompanyID AS VARCHAR(10)) + ')'
                ELSE 'Company ID: ' + CAST(CompanyID AS VARCHAR(10))
            END AS CompanyDisplayName
        FROM AuditLogs
        WHERE AuditLogID = @AuditLogID;
    END