


---SQL DATA CLEANING: Nashville Housing Data---


SELECT *
	FROM PortfolioProject.dbo.NashvilleHousing;
	
--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format --

SELECT Salesdate, Convert(Date,SaleDate)
	FROM PortfolioProject.dbo.NashvilleHousing;

--UPDATE PortfolioProject.dbo.NashvilleHousing
	--SET Saledate = Convert(Date,SaleDate)

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
	ADD Salesdate Date;

UPDATE PortfolioProject.dbo.NashvilleHousing
	SET Salesdate = Convert(Date,SaleDate);


 
--------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address Data --

SELECT *
	FROM PortfolioProject.dbo.NashvilleHousing
		ORDER BY ParcelID;


SELECT n1.ParcelID, n1.propertyaddress, n2.ParcelID, n2.PropertyAddress
	FROM PortfolioProject.dbo.NashvilleHousing AS n1
		JOIN PortfolioProject.dbo.NashvilleHousing AS n2
		ON n1.ParcelID = n2.ParcelID
		AND n1.[UniqueID ] <> n2.[UniqueID ]
			WHERE n1.propertyaddress IS NULL;

UPDATE N1
	SET n1.PropertyAddress = ISNULL (n1.propertyaddress, n2.propertyaddress)
		FROM PortfolioProject.dbo.NashvilleHousing AS n1
			JOIN PortfolioProject.dbo.NashvilleHousing AS n2
			ON n1.ParcelID = n2.ParcelID
			AND n1.[UniqueID ] <> n2.[UniqueID ]
				WHERE n1.propertyaddress IS NULL;



--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, States) --

	------PropertyAddress------

SELECT Propertyaddress
	FROM PortfolioProject.dbo.NashvilleHousing;
		
SELECT SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Address,
	SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) AS Address2
		FROM PortfolioProject.dbo.NashvilleHousing


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
	ADD PropertyCutAddress Nvarchar(255);

UPDATE PortfolioProject.dbo.NashvilleHousing
	SET PropertyCutAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1);


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
	ADD PropertyCutCity Nvarchar(255);

UPDATE PortfolioProject.dbo.NashvilleHousing
	SET PropertyCutCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress));


SELECT *
	FROM PortfolioProject.dbo.NashvilleHousing


	-----Owner Address------



SELECT OwnerAddress	
	FROM PortfolioProject.dbo.NashvilleHousing

SELECT PARSENAME (REPLACE(OwnerAddress,',','.') , 3),
	PARSENAME (REPLACE(OwnerAddress,',','.') , 2),
	PARSENAME (REPLACE(OwnerAddress,',','.') , 1)
		FROM PortfolioProject.dbo.NashvilleHousing


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
	ADD OwnerCutAddress Nvarchar(255);

UPDATE PortfolioProject.dbo.NashvilleHousing
	SET OwnerCutAddress = PARSENAME (REPLACE(OwnerAddress,',','.') , 3);


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
	ADD OwnerCutCity Nvarchar(255);

UPDATE PortfolioProject.dbo.NashvilleHousing
	SET OwnerCutCity = PARSENAME (REPLACE(OwnerAddress,',','.') , 2);


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
	ADD OwnerCutState Nvarchar(255);

UPDATE PortfolioProject.dbo.NashvilleHousing
	SET OwnerCutState = PARSENAME (REPLACE(OwnerAddress,',','.') , 1);


SELECT *
	FROM PortfolioProject.dbo.NashvilleHousing


--------------------------------------------------------------------------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant' field --

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
	FROM PortfolioProject.dbo.NashvilleHousing
		GROUP BY SoldAsVacant
		ORDER BY 2;

SELECT SoldAsVacant,
	CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant END
	FROM PortfolioProject.dbo.NashvilleHousing


UPDATE PortfolioProject.dbo.NashvilleHousing
	SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant END



--------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates --

WITH RowNumCTE AS
(
SELECT *,
	ROW_NUMBER () OVER (
	PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference ORDER BY UniqueID) AS RowNum
		FROM PortfolioProject.dbo.NashvilleHousing
)

	--DELETE-- 
	SELECT *
		FROM RowNumCTE
		WHERE Rownum > 1
		ORDER BY PropertyCutAddress



SELECT *
	FROM PortfolioProject.dbo.NashvilleHousing



--------------------------------------------------------------------------------------------------------------------------

-- DELETE Unused Columns -- 


SELECT * 
	FROM PortfolioProject.dbo.NashvilleHousing


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
	DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate




--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
