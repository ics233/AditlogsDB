
-- Insert Remittance
CREATE   PROCEDURE sp_Remittance_Insert
    @CompanyID INT,
    @FirstName NVARCHAR(100),
    @PaternalLastName NVARCHAR(100),
    @MaternalLastName NVARCHAR(100),
    @Amount DECIMAL(18,2),
    @Username NVARCHAR(100),
    @Note NVARCHAR(MAX),
    @Destination NVARCHAR(255),
    @RecepientId INT = NULL,
    @RecipientFirstName NVARCHAR(100) = NULL,
    @RecipientPaternalLastName NVARCHAR(100) = NULL,
    @RecipientMaternalLastName NVARCHAR(100) = NULL,
    @StoreLocationID INT = NULL,
    @UserDateTime DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @UserDateTime IS NULL
        SET @UserDateTime = GETDATE();
    
    INSERT INTO Remittances (
        CompanyID, FirstName, PaternalLastName, MaternalLastName,
        Amount, Username, Note, Destination, RecepientId,
        RecipientFirstName, RecipientPaternalLastName, RecipientMaternalLastName,
        StoreLocationID, UserDateTime, DateCreated
    )
    VALUES (
        @CompanyID, @FirstName, @PaternalLastName, @MaternalLastName,
        @Amount, @Username, @Note, @Destination, @RecepientId,
        @RecipientFirstName, @RecipientPaternalLastName, @RecipientMaternalLastName,
        @StoreLocationID, @UserDateTime, GETDATE()
    );
    
    SELECT CAST(SCOPE_IDENTITY() as int) as RemittanceID;
END
