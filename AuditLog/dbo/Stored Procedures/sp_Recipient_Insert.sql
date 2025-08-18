
-- Insert Recipient
CREATE   PROCEDURE sp_Recipient_Insert
    @FirstName NVARCHAR(100),
    @PaternalLastName NVARCHAR(100),
    @MaternalLastName NVARCHAR(100),
    @StatusID INT = 1
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO Recipients (FirstName, PaternalLastName, MaternalLastName, StatusID, DateCreated)
    VALUES (@FirstName, @PaternalLastName, @MaternalLastName, @StatusID, GETDATE());
    
    SELECT CAST(SCOPE_IDENTITY() as int) as ID;
END
