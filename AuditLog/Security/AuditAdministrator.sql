CREATE ROLE [AuditAdministrator]
    AUTHORIZATION [dbo];


GO
ALTER ROLE [AuditAdministrator] ADD MEMBER [AuditAdminUser];

