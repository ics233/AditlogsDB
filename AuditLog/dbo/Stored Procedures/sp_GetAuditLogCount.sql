
-- =============================================
-- AUDIT LOG COUNT PROCEDURE - REFACTORED TO AVOID DYNAMIC SQL
-- =============================================
CREATE   PROCEDURE [dbo].[sp_GetAuditLogCount]
    @FromDate DATETIME = NULL,
    @ToDate DATETIME = NULL,
    @CompanyID INT = NULL,
    @UserID INT = NULL,
    @Action NVARCHAR(50) = NULL,
    @Status NVARCHAR(20) = NULL,
    @TableName NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Set default date range if not provided
    IF @FromDate IS NULL
        SET @FromDate = DATEADD(DAY, -30, GETUTCDATE());
    
    IF @ToDate IS NULL
        SET @ToDate = GETUTCDATE();
    
    -- Validate date range
    IF @FromDate > @ToDate
        THROW 50003, 'FromDate cannot be after ToDate', 1;
    
    IF DATEDIFF(DAY, @FromDate, @ToDate) > 365
        THROW 50004, 'Date range cannot exceed 365 days', 1;
    
    -- Static SQL with proper filtering - NO DYNAMIC SQL
    SELECT COUNT(*) as TotalCount 
    FROM AuditLogs WITH (NOLOCK)
    WHERE Timestamp >= @FromDate 
      AND Timestamp <= @ToDate
      AND (@CompanyID IS NULL OR CompanyID = @CompanyID)
      AND (@UserID IS NULL OR UserID = @UserID)
      AND (@Action IS NULL OR Action = @Action)
      AND (@Status IS NULL OR Status = @Status)
      AND (@TableName IS NULL OR TableName = @TableName);
END
