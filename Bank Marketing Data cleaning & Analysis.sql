
--# BANK MARKETING DATA

SELECT *
	FROM PortfolioProject.dbo.bank

-----------------------------------------------------------

--# DATA CLEANING


  -- Check for Null / Missing Values (No Null values - Used query for all columns)
SELECT *
	FROM PortfolioProject.dbo.bank
		WHERE isnull (deposit, '') = ''

  -- Fix Structural errors

    --< Renaming column campaign to campaign_interactions

ALTER TABLE PortfolioProject.dbo.bank
	ADD campaign_interactions Nvarchar(50)

UPDATE PortfolioProject.dbo.bank
	SET campaign_interactions = CONVERT(Nvarchar, campaign)

    --< In column Poutcome, replaced 'Outcome' & 'Other' to Unknown

SELECT DISTINCT(poutcome)
	FROM PortfolioProject.dbo.bank                                

SELECT poutcome, REPLACE(poutcome, 'Outcome', 'Unknown')
	FROM PortfolioProject.dbo.bank

UPDATE PortfolioProject.dbo.bank
	SET poutcome = 'Unknown'
	WHERE poutcome = 'Outcome'

UPDATE PortfolioProject.dbo.bank
	SET poutcome = 'Unknown'
	WHERE poutcome = 'Other'

  -- Drop irrelevant Columns (duration, campaign)
ALTER TABLE PortfolioProject.dbo.bank
	DROP duration

ALTER TABLE PortfolioProject.dbo.bank
	DROP campaign


-----------------------------------------------------------

--# DATA EXPLORATION (Obj: Find the customer base / habits more likely to open a Bank account)

SELECT *
	FROM PortfolioProject.dbo.bank

SELECT DISTINCT(poutcome)
	FROM PortfolioProject.dbo.bank

  -- Analyzing amount of the different results --

SELECT COUNT(poutcome) AS Outcome_Unknown
	FROM PortfolioProject.dbo.bank	
		WHERE poutcome = 'unknown'

SELECT COUNT(poutcome) AS Outcome_Unknown
	FROM PortfolioProject.dbo.bank	
		WHERE poutcome = 'success'

SELECT COUNT(poutcome) AS Outcome_Unknown
	FROM PortfolioProject.dbo.bank	
		WHERE poutcome = 'failure'

  -- Analyze the Ages --

SELECT MIN(age) as Youngest, Max(age) as Eldest, AVG(age) as Avg_age
	FROM PortfolioProject.dbo.bank

  -- Count jobs, martial, education, & housing --***

SELECT COUNT(DISTINCT job) AS Jobs, COUNT(DISTINCT Marital) AS Marital, COUNT(DISTINCT education) AS Education, COUNT(DISTINCT housing) AS Housing
	FROM PortfolioProject.dbo.bank

  -- The amount of people reached out to each month --

SELECT month, COUNT(job) AS Potential_Customers
	FROM PortfolioProject.dbo.bank
		GROUP BY month
		ORDER BY month

  -- Month that had the Most reach --

SELECT month, COUNT(job) AS Potential_Customers
	FROM PortfolioProject.dbo.bank
		GROUP BY month
		ORDER BY COUNT(job) DESC


--# For Visual Analysis

  -- Age v.s Deposit --***

SELECT age, deposit
	FROM PortfolioProject.dbo.bank

  -- Job v.s Deposit --***

SELECT job, deposit
	FROM PortfolioProject.dbo.bank

  -- Marital v.s Deposit --***

SELECT Marital, poutcome
	FROM PortfolioProject.dbo.bank

  -- Education v.s Deposit --***

SELECT education, deposit
	FROM PortfolioProject.dbo.bank

  -- Housing v.s Deposit --***

SELECT housing, deposit
	FROM PortfolioProject.dbo.bank

  -- Loan v.s Deposit --***

SELECT loan, deposit
	FROM PortfolioProject.dbo.bank

  -- Default v.s Deposit --***

SELECT default, deposit
	FROM PortfolioProject.dbo.bank

  -- Campaign Interactions v.s Deposit --***

SELECT Campaign_interactions, deposit
	FROM PortfolioProject.dbo.bank

  -- Age v.s poutcome --***

SELECT age, poutcome
	FROM PortfolioProject.dbo.bank

  -- Job v.s poutcome --

SELECT job, poutcome
	FROM PortfolioProject.dbo.bank

  -- Marital v.s poutcome --

SELECT Marital, poutcome
	FROM PortfolioProject.dbo.bank

  -- Education v.s poutcome --

SELECT education, poutcome
	FROM PortfolioProject.dbo.bank

  -- Housing v.s poutcome --

SELECT housing, poutcome
	FROM PortfolioProject.dbo.bank

  -- Loan v.s poutcome --

SELECT loan, poutcome
	FROM PortfolioProject.dbo.bank

  -- Default v.s poutcome --

SELECT default, poutcome
	FROM PortfolioProject.dbo.bank

  -- Campaign v.s poutcome --

SELECT campaign_interactions, poutcome
	FROM PortfolioProject.dbo.bank

  -- Month v.s poutcome -- (Monthly graph)

SELECT month, poutcome
	FROM PortfolioProject.dbo.bank

SELECT month, campaign_interactions 
	FROM PortfolioProject.dbo.bank


--# SQL ANALYSIS CONCLUSION

  --< Firstly, the Data lacks in education & can be solved by specifying the exact education so targeting is more accurate

  --< Other than that, I can conclude my first insights...
      --~ AGE minimum: 18 years old | maximum: 95 years old
	 

--< For this dataset, I see it's best continue to find deeper insights through Visualizations (Tableau) >---






