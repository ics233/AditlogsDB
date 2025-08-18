CREATE TABLE [dbo].[AuditLogs] (
    [AuditLogID]     INT            IDENTITY (1, 1) NOT NULL,
    [UserID]         INT            NOT NULL,
    [CompanyID]      INT            NOT NULL,
    [Action]         NVARCHAR (50)  NOT NULL,
    [TableName]      NVARCHAR (100) NOT NULL,
    [RecordID]       NVARCHAR (50)  NULL,
    [OldValues]      NVARCHAR (MAX) NULL,
    [NewValues]      NVARCHAR (MAX) NULL,
    [IPAddress]      NVARCHAR (45)  NULL,
    [UserAgent]      NVARCHAR (500) NULL,
    [SessionID]      NVARCHAR (100) NULL,
    [Timestamp]      DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [Status]         NVARCHAR (20)  DEFAULT ('SUCCESS') NULL,
    [ErrorMessage]   NVARCHAR (MAX) NULL,
    [AdditionalData] NVARCHAR (MAX) NULL,
    [Username]       NVARCHAR (100) NULL,
    [UserFirstName]  NVARCHAR (100) NULL,
    [UserLastName]   NVARCHAR (100) NULL,
    [UserEmail]      NVARCHAR (255) NULL,
    [CompanyName]    NVARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([AuditLogID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_AuditLogs_UserID]
    ON [dbo].[AuditLogs]([UserID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_AuditLogs_Action]
    ON [dbo].[AuditLogs]([Action] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_AuditLogs_CompanyID_Timestamp]
    ON [dbo].[AuditLogs]([CompanyID] ASC, [Timestamp] ASC);

