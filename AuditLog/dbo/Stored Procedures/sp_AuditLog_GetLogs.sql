CREATE   PROCEDURE [dbo].[sp_AuditLog_GetLogs]
    @UserID INT = NULL,
    @CompanyID INT = NULL,
    @Action NVARCHAR(100) = NULL,
    @TableName NVARCHAR(100) = NULL,
    @FromDate DATETIME = NULL,
    @ToDate DATETIME = NULL,
    @Status NVARCHAR(50) = NULL,
    @Page INT = 1,
    @PageSize INT = 50
AS
BEGIN
    SET NOCOUNT ON;
    
    WITH NumberedLogs AS (
        SELECT 
            al.AuditLogID,
            al.UserID,
            al.CompanyID,
            al.Action,
            al.TableName,
            al.RecordID,
            al.OldValues,
            al.NewValues,
            al.IPAddress,
            al.UserAgent,
            al.SessionID,
            al.Timestamp,
            al.Status,
            al.ErrorMessage,
            al.AdditionalData,
            al.Username,
            al.UserFirstName,
            al.UserLastName,
            al.UserEmail,
            al.CompanyName,
            -- Enhanced user display: Name (ID) or fallback to ID
            CASE 
                WHEN al.UserFirstName IS NOT NULL AND al.UserLastName IS NOT NULL 
                THEN al.UserFirstName + ' ' + al.UserLastName + ' (ID: ' + CAST(al.UserID AS VARCHAR(10)) + ')'
                ELSE 'User ID: ' + CAST(al.UserID AS VARCHAR(10))
            END AS UserDisplayName,
            -- Enhanced company display: Name (ID) or fallback to ID
            CASE 
                WHEN al.CompanyName IS NOT NULL 
                THEN al.CompanyName + ' (ID: ' + CAST(al.CompanyID AS VARCHAR(10)) + ')'
                ELSE 'Company ID: ' + CAST(al.CompanyID AS VARCHAR(10))
            END AS CompanyDisplayName,
            -- Row number for display purposes (1, 2, 3, 4...)
            ROW_NUMBER() OVER (ORDER BY al.AuditLogID DESC) AS RowNumber
        FROM AuditLogs al WITH (NOLOCK)
        WHERE (@UserID IS NULL OR al.UserID = @UserID)
          AND (@CompanyID IS NULL OR al.CompanyID = @CompanyID)
          AND (@Action IS NULL OR al.Action = @Action)
          AND (@TableName IS NULL OR al.TableName = @TableName)
          AND (@FromDate IS NULL OR al.Timestamp >= @FromDate)
          AND (@ToDate IS NULL OR al.Timestamp <= @ToDate)
          AND (@Status IS NULL OR al.Status = @Status)
    )
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
        UserDisplayName,
        CompanyDisplayName,
        RowNumber AS DisplayID  -- This will be 1, 2, 3, 4... for display
    FROM NumberedLogs
    ORDER BY AuditLogID DESC
    OFFSET (@Page - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
