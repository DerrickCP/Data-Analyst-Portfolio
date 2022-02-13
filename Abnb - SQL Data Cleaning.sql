

---SQL DATA CLEANING: AirBnb 2019 NYC Bookings---


SELECT *
	FROM PortfolioProject.dbo.ABNB_NYC_2019
	

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format --

SELECT last_review_date, CONVERT(Date, Last_Review)
	FROM PortfolioProject.dbo.ABNB_NYC_2019;

ALTER TABLE PortfolioProject.dbo.ABNB_NYC_2019
	ADD Last_Review_Date Date;

UPDATE PortfolioProject.dbo.ABNB_NYC_2019
	SET Last_Review_Date = CONVERT(Date,Last_Review);




--------------------------------------------------------------------------------------------------------------------------

-- Optimize titles of columns (Name, Price, neighbourhood, neighbourhood_group, calculated_home_listings_count) --


SELECT *
	FROM PortfolioProject.dbo.ABNB_NYC_2019


ALTER TABLE PortfolioProject.dbo.ABNB_NYC_2019
	ADD Booking_Name Nvarchar(255)

UPDATE PortfolioProject.dbo.ABNB_NYC_2019
	SET Booking_Name = CONVERT(Nvarchar, name)



ALTER TABLE PortfolioProject.dbo.ABNB_NYC_2019
	ADD Price_per_Night Nvarchar (25);

UPDATE PortfolioProject.dbo.ABNB_NYC_2019
	SET Price_per_Night = CONVERT(Nvarchar, price)



ALTER TABLE PortfolioProject.dbo.ABNB_NYC_2019
	ADD City Nvarchar (100);

UPDATE PortfolioProject.dbo.ABNB_NYC_2019
	SET City = CONVERT(Nvarchar, neighbourhood_group)



ALTER TABLE PortfolioProject.dbo.ABNB_NYC_2019
	ADD StreetName Nvarchar (150);

UPDATE PortfolioProject.dbo.ABNB_NYC_2019
	SET StreetName = CONVERT(Nvarchar, neighbourhood)



ALTER TABLE PortfolioProject.dbo.ABNB_NYC_2019
	ADD BookingCount Nvarchar (25);

UPDATE PortfolioProject.dbo.ABNB_NYC_2019
	SET BookingCount = CONVERT (Nvarchar, calculated_host_listings_count)



--------------------------------------------------------------------------------------------------------------------------

-- DELETE Unused Columns -- (Longitude, Latitude, last_review, reviews_per_month)


SELECT *
	FROM PortfolioProject.dbo.ABNB_NYC_2019;

ALTER TABLE PortfolioProject.dbo.ABNB_NYC_2019
	DROP COLUMN Latitude, Longitude 
				--, last_review, reviews_per_month, name, neighbourhood_group, neighbourhood--




--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
