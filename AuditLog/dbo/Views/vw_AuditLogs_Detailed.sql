
-- Create a view for easier querying
CREATE VIEW vw_AuditLogs_Detailed AS
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
    CompanyName
FROM AuditLogs;
