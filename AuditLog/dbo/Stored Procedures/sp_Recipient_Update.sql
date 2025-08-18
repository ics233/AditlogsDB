
-- Update Recipient
CREATE   PROCEDURE sp_Recipient_Update
    @ID INT,
    @FirstName NVARCHAR(100),
    @PaternalLastName NVARCHAR(100),
    @MaternalLastName NVARCHAR(100),
    @StatusID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE Recipients 
    SET 
        FirstName = @FirstName,
        PaternalLastName = @PaternalLastName,
        MaternalLastName = @MaternalLastName,
        StatusID = @StatusID
    WHERE ID = @ID;
END
