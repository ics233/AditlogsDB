
-- =============================================
-- RECIPIENT MANAGEMENT STORED PROCEDURES
-- =============================================

-- Get All Recipients
CREATE   PROCEDURE sp_Recipient_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        ID,
        FirstName,
        PaternalLastName,
        MaternalLastName,
        DateCreated,
        StatusID
    FROM Recipients
    WHERE StatusID = 1 -- Active recipients only
    ORDER BY FirstName, PaternalLastName;
END
