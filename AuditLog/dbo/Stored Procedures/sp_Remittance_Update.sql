
-- Update Remittance
CREATE   PROCEDURE sp_Remittance_Update
    @RemittanceID INT,
    @CompanyID INT,
    @FirstName NVARCHAR(100) = NULL,
    @PaternalLastName NVARCHAR(100) = NULL,
    @MaternalLastName NVARCHAR(100) = NULL,
    @Amount DECIMAL(18,2) = NULL,
    @Destination NVARCHAR(255) = NULL,
    @RecipientFirstName NVARCHAR(100) = NULL,
    @RecipientPaternalLastName NVARCHAR(100) = NULL,
    @RecipientMaternalLastName NVARCHAR(100) = NULL,
    @StoreLocationID INT = NULL,
    @Note NVARCHAR(MAX) = NULL,
    @UpdatedBy NVARCHAR(100) = NULL,
    @UserDateTime DATETIME = NULL,
    @RemittanceStatusID INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE Remittances 
    SET 
        FirstName = ISNULL(@FirstName, FirstName),
        PaternalLastName = ISNULL(@PaternalLastName, PaternalLastName),
        MaternalLastName = ISNULL(@MaternalLastName, MaternalLastName),
        Amount = ISNULL(@Amount, Amount),
        Destination = ISNULL(@Destination, Destination),
        RecipientFirstName = ISNULL(@RecipientFirstName, RecipientFirstName),
        RecipientPaternalLastName = ISNULL(@RecipientPaternalLastName, RecipientPaternalLastName),
        RecipientMaternalLastName = ISNULL(@RecipientMaternalLastName, RecipientMaternalLastName),
        StoreLocationID = ISNULL(@StoreLocationID, StoreLocationID),
        Note = ISNULL(@Note, Note),
        UserDateTime = ISNULL(@UserDateTime, UserDateTime),
        RemittanceStatusID = ISNULL(@RemittanceStatusID, RemittanceStatusID)
    WHERE RemittanceID = @RemittanceID AND CompanyID = @CompanyID;
END
