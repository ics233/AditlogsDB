
-- Get Recipient by ID
CREATE   PROCEDURE sp_Recipient_GetById
    @ID INT
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
    WHERE ID = @ID;
END
