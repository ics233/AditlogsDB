
-- Delete Recipient (Soft delete)
CREATE   PROCEDURE sp_Recipient_Delete
    @ID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE Recipients 
    SET StatusID = 0 -- Mark as inactive
    WHERE ID = @ID;
END
