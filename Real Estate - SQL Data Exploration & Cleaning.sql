
-- REAL ESTATE MARKETING DATA --

SELECT *
	FROM REM.dbo.trulia_marketing


-----------------------------------------------------------------
-----------------------------------------------------------------

-- Data Cleaning --


	--Changing the Date format FROM YYYY/MM/DD:TIME to YYYY/MM/DD--*
SELECT *
	FROM REM.dbo.trulia_marketing;

SELECT SUBSTRING(Crawl_TimeStamp, 0, CHARINDEX(':', Crawl_Timestamp)-3)
	FROM REM.dbo.trulia_marketing;

UPDATE REM.dbo.trulia_marketing
	SET Crawl_TimeStamp = SUBSTRING(Crawl_TimeStamp, 0, CHARINDEX(':', Crawl_Timestamp)-3);


	--Removing Duplicate Columns-- (Address_Full)*
SELECT Address, Address_Full
	FROM REM.dbo.trulia_marketing;

	--/ALTER TABLE REM.dbo.trulia_marketing\--
	  --/DROP COLUMN Address_Full\--


	--Reformating the Address Column--*
SELECT Address, Address_Full
	FROM REM.dbo.trulia_marketing;

UPDATE REM.dbo.trulia_marketing
	SET Address = SUBSTRING(Address, 0, CHARINDEX(',', Address)-1);


-----------------------------------------------------------------
-----------------------------------------------------------------

--Data Exploration--

SELECT *
	FROM REM.dbo.trulia_marketing;


	--For Houses that were Sold, How much is the price difference compared to Now?-- (Calculations)*
		SELECT Title, Last_Sold_Year, Price, Last_Sold_For, SUM(Price - Last_Sold_For) AS Post_Property_Value
	FROM REM.dbo.trulia_marketing
		WHERE Last_Sold_For IS NOT NULL
			GROUP BY Title, Last_Sold_Year, Price, Last_Sold_For
			ORDER BY PRICE DESC;

	--Find the homes that haven't been sold--*
SELECT Uniq_Id, Title, Year_Built, Last_Sold_Year, Last_Sold_For
	FROM REM.dbo.trulia_marketing
		WHERE Last_Sold_Year IS NULL;

			--Create a Column that indicates if a home has been sold or not--* (Case Statement)
SELECT Title, Last_Sold_Year,
	(CASE WHEN Last_Sold_Year < 2021 THEN 'Yes'
		  ELSE 'No' END) AS Has_Sold
	FROM REM.dbo.trulia_marketing;


	--In California, what's the average price for a house with 3 Bedrooms & 2 Bathrooms?--*
SELECT State, Beds, Bath, AVG(Price) AS Average_Home_Price
	FROM REM.dbo.trulia_marketing
		WHERE Beds = 3
		AND Bath = 2
		AND State = 'CA'
			GROUP BY State, Beds, Bath;

SELECT *
	FROM REM.dbo.trulia_marketing;
