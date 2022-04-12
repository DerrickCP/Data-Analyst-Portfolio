
-- ONLINE GAMING ANXIETY STUDY --

SELECT *
	FROM PortfolioProject.dbo.GamingStudy_survey

SELECT *
	FROM PortfolioProject.dbo.GamingStudy_demographic

-----------------------------------------------------

--# DATA CLEANING

   -- Look for Duplicates or Irrelevant Data

SELECT S_No
	FROM PortfolioProject.dbo.GamingStudy_survey    --Finding Duplicates--
		GROUP BY S_No
		HAVING COUNT(1) > 1;


   -- Remove any Duplicates & Irrelevant Data 

ALTER TABLE PortfolioProject.dbo.GamingStudy_demographic
	DROP accept;

ALTER TABLE PortfolioProject.dbo.GamingStudy_survey
	DROP League;

ALTER TABLE PortfolioProject.dbo.GamingStudy_survey
	DROP Highestleague;


   -- Find & Fill / Remove, NULL / Missing Values

SELECT * 
	FROM PortfolioProject.dbo.GamingStudy_demographic

DELETE FROM PortfolioProject.dbo.GamingStudy_demographic
	WHERE ISNULL(Gender, '')= ''


  -- Filling N/A in GADE column

SELECT GADE
	FROM PortfolioProject.dbo.GamingStudy_survey 
		WHERE ISNULL (GADE,'NA') = 'NA';

SELECT GADE
	FROM PortfolioProject.dbo.GamingStudy_survey
		WHERE GADE = 'Unknown'

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET GADE = 'Unknown'
		WHERE GADE = 'NA'


  -- Filling Nulls in Hours column

SELECT Hours
	FROM PortfolioProject.dbo.GamingStudy_survey
		WHERE ISNULL (Hours,'') = '';

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET Hours = '0'
		WHERE ISNULL(Hours, '') = ''


  -- Filling Nulls in streams column

SELECT streams
	FROM PortfolioProject.dbo.GamingStudy_survey                              
		WHERE ISNULL (streams,'') = ''

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET streams = '0'
		WHERE ISNULL(streams, '') = ''


  -- Filling Nulls in SPIN columns

SELECT SPIN1, SPIN2, SPIN3, SPIN4, SPIN5, SPIN6, SPIN7, SPIN8, SPIN9, SPIN10, SPIN11, SPIN12, SPIN13, SPIN14, SPIN15
	FROM PortfolioProject.dbo.GamingStudy_survey   

SELECT SPIN1, SPIN2, SPIN3, SPIN4, SPIN5, SPIN6, SPIN7, SPIN8, SPIN9, SPIN10, SPIN11, SPIN12, SPIN13, SPIN14, SPIN15
	FROM PortfolioProject.dbo.GamingStudy_survey   
		WHERE ISNULL (SPIN1,'') = ''

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET SPIN1 = '0'
		WHERE ISNULL(SPIN1, '') = ''

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET SPIN2 = '0'
		WHERE ISNULL(SPIN2, '') = ''

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET SPIN3 = '0'
		WHERE ISNULL(SPIN3, '') = ''

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET SPIN4 = '0'
		WHERE ISNULL(SPIN4, '') = ''

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET SPIN5 = '0'
		WHERE ISNULL(SPIN5, '') = ''

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET SPIN6 = '0'
		WHERE ISNULL(SPIN6, '') = ''

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET SPIN7 = '0'
		WHERE ISNULL(SPIN7, '') = ''

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET SPIN8 = '0'
		WHERE ISNULL(SPIN8, '') = ''

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET SPIN9 = '0'
		WHERE ISNULL(SPIN9, '') = ''

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET SPIN10 = '0'
		WHERE ISNULL(SPIN10, '') = ''

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET SPIN11 = '0'
		WHERE ISNULL(SPIN11, '') = ''

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET SPIN12 = '0'
		WHERE ISNULL(SPIN12, '') = ''

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET SPIN13 = '0'
		WHERE ISNULL(SPIN13, '') = ''

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET SPIN14 = '0'
		WHERE ISNULL(SPIN14, '') = ''

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET SPIN15 = '0'
		WHERE ISNULL(SPIN15, '') = ''

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET SPIN16 = '0'
		WHERE ISNULL(SPIN16, '') = ''

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET SPIN17 = '0'
		WHERE ISNULL(SPIN17, '') = ''

  --Filling NULLs in SPIN_T column

SELECT SPIN_T
	FROM PortfolioProject.dbo.GamingStudy_demographic
		WHERE ISNULL(SPIN_T, '') = ''

UPDATE PortfolioProject.dbo.GamingStudy_demographic
	SET SPIN_T = '0'
		WHERE ISNULL(SPIN_T, '') = ''

  --Filling N/A in Ranking(League) column

SELECT Ranking
	FROM PortfolioProject.dbo.GamingStudy_survey

SELECT Ranking
	FROM PortfolioProject.dbo.GamingStudy_survey
		WHERE ISNULL(Ranking, 'NA') = 'NA'

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET Ranking = 'Unranked'
		WHERE ISNULL(Ranking, 'NA') = 'NA'


   -- Fix Structural Errors

ALTER TABLE PortfolioProject.dbo.GamingStudy_survey
	ADD Ranking Nvarchar(200);

UPDATE PortfolioProject.dbo.GamingStudy_survey
	SET RANKING = CONVERT(Nvarchar, League)

SELECT DISTINCT(Work)
	FROM PortfolioProject.dbo.GamingStudy_demographic

UPDATE PortfolioProject.dbo.GamingStudy_demographic
	SET Work = 'Unknown'
		WHERE Work = 'NA'


-----------------------------------------------------
-----------------------------------------------------


--# DATA EXPLORATION

SELECT *
	FROM PortfolioProject.dbo.GamingStudy_survey

SELECT *
	FROM PortfolioProject.dbo.GamingStudy_demographic


  -- All Different Games
SELECT DISTINCT(Game)
	FROM PortfolioProject.dbo.GamingStudy_survey


  -- All Different Platforms
SELECT DISTINCT(Platform)
	FROM PortfolioProject.dbo.GamingStudy_survey


  -- All Different Residences
SELECT DISTINCT(Residence)
	FROM PortfolioProject.dbo.GamingStudy_demographic;


  --ALL Distinct Occupations / Work
SELECT DISTINCT(Work)
	FROM PortfolioProject.dbo.GamingStudy_demographic


  -- All Distinct References
  SELECT DISTINCT(Reference)
	FROM PortfolioProject.dbo.GamingStudy_demographic

  -- Average Monthly Hours
SELECT AVG(hours)*4 AS AvgMonthly_Gaminghours
	FROM PortfolioProject.dbo.GamingStudy_survey

  -- Average Weekly Hours
SELECT AVG(Hours) AS AvgWeekly_Gaminghours
	FROM PortfolioProject.dbo.GamingStudy_survey

  -- Average Daily Hours
SELECT AVG(Hours)/7 AS AvgDaily_Gaminghours
	FROM PortfolioProject.dbo.GamingStudy_survey

  -- Average Age
SELECT AVG(Age) AS Avg_Age
	FROM PortfolioProject.dbo.GamingStudy_demographic

  -- Average Age based on Gender
SELECT Gender, AVG(age) AS Avg_Age
	FROM PortfolioProject.dbo.GamingStudy_demographic
		WHERE Gender = 'Female'
			GROUP BY Gender

SELECT Gender, AVG(age) AS Avg_Age
	FROM PortfolioProject.dbo.GamingStudy_demographic
		WHERE Gender = 'Male'
			GROUP BY Gender


-----------------------------------------------------
-----------------------------------------------------

--# For Visuals

SELECT *
	FROM PortfolioProject.dbo.GamingStudy_demographic

SELECT *
	FROM PortfolioProject.dbo.GamingStudy_survey


-- Gender vs Games
SELECT sd.Gender, ss.Game
	FROM PortfolioProject.dbo.GamingStudy_survey AS ss
		JOIN PortfolioProject.dbo.GamingStudy_demographic AS sd
		ON ss.S_No = sd.S_No


  -- Gender vs GADE
SELECT Gender, GADE
	FROM PortfolioProject.dbo.GamingStudy_demographic AS sd
		JOIN PortfolioProject.dbo.GamingStudy_survey AS ss
		ON sd.s_no = ss.s_no


  -- GADE vs Work
SELECT ss.GADE, sd.Work
	FROM PortfolioProject.dbo.GamingStudy_survey AS ss
		JOIN PortfolioProject.dbo.GamingStudy_demographic AS sd
		ON ss.s_No = sd.s_No	


  -- GADE vs Game
SELECT GADE, Game
	FROM PortfolioProject.dbo.GamingStudy_survey


  -- Whyplay, GADE vs GAME
SELECT whyplay,GADE, Game
	FROM PortfolioProject.dbo.GamingStudy_survey