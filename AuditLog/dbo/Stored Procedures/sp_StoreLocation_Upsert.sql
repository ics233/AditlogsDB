
-- Upsert Store Location
CREATE   PROCEDURE sp_StoreLocation_Upsert
    @StoreLocationID INT = 0,
    @CompanyID INT,
    @Name NVARCHAR(255),
    @Email NVARCHAR(255),
    @StreetAddress NVARCHAR(255),
    @City NVARCHAR(100),
    @State NVARCHAR(50),
    @Zip NVARCHAR(20),
    @PhoneNumber NVARCHAR(20),
    @StatusID INT = 1
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @StoreLocationID = 0
    BEGIN
        -- Insert new store location
        INSERT INTO StoreLocations (
            CompanyID, Name, Email, StreetAddress, City, State, Zip, PhoneNumber, StatusID, DateCreated
        )
        VALUES (
            @CompanyID, @Name, @Email, @StreetAddress, @City, @State, @Zip, @PhoneNumber, @StatusID, GETDATE()
        );
        
        SELECT CAST(SCOPE_IDENTITY() as int) as StoreLocationID;
    END
    ELSE
    BEGIN
        -- Update existing store location
        UPDATE StoreLocations 
        SET 
            Name = @Name,
            Email = @Email,
            StreetAddress = @StreetAddress,
            City = @City,
            State = @State,
            Zip = @Zip,
            PhoneNumber = @PhoneNumber,
            StatusID = @StatusID
        WHERE StoreLocationID = @StoreLocationID AND CompanyID = @CompanyID;
        
        SELECT @StoreLocationID as StoreLocationID;
    END
END
