
-- =============================================
-- REMITTANCE MANAGEMENT STORED PROCEDURES
-- =============================================

-- Get Remittances by Company
CREATE   PROCEDURE sp_Remittance_GetByCompany
    @CompanyID INT,
    @Page INT = 1,
    @PageSize INT = 50
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        r.RemittanceID,
        r.CompanyID,
        r.FirstName,
        r.PaternalLastName,
        r.MaternalLastName,
        r.Amount,
        r.Username,
        r.Note,
        r.Destination,
        r.RecepientId,
        r.RecipientFirstName,
        r.RecipientPaternalLastName,
        r.RecipientMaternalLastName,
        r.StoreLocationID,
        r.UserDateTime,
        r.RemittanceStatusID,
        r.DateCreated,
        sl.Name as StoreLocationName,
        rec.FirstName as RecipientFullName
    FROM Remittances r
    LEFT JOIN StoreLocations sl ON r.StoreLocationID = sl.StoreLocationID
    LEFT JOIN Recipients rec ON r.RecepientId = rec.ID
    WHERE r.CompanyID = @CompanyID
    ORDER BY r.DateCreated DESC
    OFFSET (@Page - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
