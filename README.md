--COVID PANDEMIC QUERIES--

SELECT * 
	FROM PortfolioProject.dbo.COVID19

SELECT * 
	FROM PortfolioProject.dbo.COVID19part2


--DATA WE'LL BEING USING*--

SELECT location, date, population, total_cases, new_cases, total_deaths
	FROM PortfolioProject.dbo.COVID19
		ORDER BY 1, 2;



--Total Deaths vs Total Cases*--

SELECT location, date, total_cases, total_deaths
	FROM PortfolioProject.dbo.COVID19
		ORDER BY 1, 2;

-- The United States* --

SELECT location, date, total_cases, total_deaths	
	FROM PortfolioProject.dbo.COVID19
		WHERE location LIKE '%states%'
			ORDER BY 1, 2;



--Total Death percentage (Mortality Rate) from Total Cases*--

SELECT location, date, total_cases,total_deaths,
	(total_deaths / total_cases) * 100 AS Death_rate
		FROM PortfolioProject.dbo.COVID19
			GROUP BY location, date, total_cases, total_deaths
			ORDER BY 1, 2;

-- The United States* --

SELECT location, date, total_cases,total_deaths,
	(total_deaths / total_cases) * 100 AS Death_rate
		FROM PortfolioProject.dbo.COVID19
			WHERE location LIKE '%states%'
				ORDER BY 1, 2;



--Total Cases vs Total population*--

SELECT location, date, population, total_cases
		FROM PortfolioProject.dbo.COVID19
		WHERE continent IS NOT NULL
			GROUP BY location,date, population, total_Cases
			ORDER BY 1, 2;

-- THE UNITED STATES* --

SELECT location, date, population, total_cases
		FROM PortfolioProject.dbo.COVID19
			WHERE location LIKE '%states%'
				ORDER BY 1, 2;



--Countries with the Highest Infection Rates*--

SELECT location, population, MAX(total_cases) AS Highest_Infection_Count,
	MAX((total_Cases / population)) * 100 AS Percentage_of_Infected
		FROM PortfolioProject.dbo.COVID19
				GROUP BY location, population
				ORDER BY Percentage_of_infected DESC;



--Countries with the Highest Death Rates--

SELECT location, population, MAX(cast(total_deaths AS INT)) AS Total_Death_Count,
	MAX((CAST(total_deaths AS INT)) / population) * 100 AS Death_Rate
		FROM PortfolioProject.dbo.COVID19
			WHERE continent IS NOT NULL
				GROUP BY location, population
				ORDER BY 4 DESC;



--Continents with the Highest Death Counts*--

SELECT location, MAX(CAST(total_deaths AS INT)) AS Total_Death_Count
	FROM PortfolioProject.dbo.COVID19
		WHERE continent IS NULL
		AND location NOT LIKE ('%Income%')
		AND location NOT LIKE ('international')
		AND location NOT LIKE ('World')
			GROUP BY location
			ORDER BY 2 DESC;



--Global Total numbers*--

/*** Total Cases, Total Deaths, Death Rate Pct***/

SELECT SUM(new_cases) AS Total_Cases, 
	SUM(CAST(new_deaths AS INT)) AS Total_Deaths, 
	SUM(CAST(new_deaths AS INT)) / SUM(new_cases) * 100 AS Death_Rate
		FROM PortfolioProject.dbo.COVID19 AS co;
			


--Total populations vs Total Vaccinated**--
		WITH PvsV (location, date, population, new_vaccinations, Total_vaccinations) 
			AS
			(
			SELECT co.location, co.date, co.population, cop2.new_vaccinations,
			SUM(CONVERT(BIGINT, cop2.new_vaccinations)) OVER (PARTITION BY co.location ORDER BY co.location, co.date) AS Total_Vaccinations
			--(Total_Vaccinations / co.population) * 100 AS Pct_of_Vaccinated
				FROM PortfolioProject.dbo.COVID19 AS co
					JOIN PortfolioProject.dbo.COVID19part2 AS cop2
						ON co.date = cop2.date
						AND co.location = cop2.location
							WHERE co.continent IS NOT NULL
							GROUP BY co.location, co.location, co.date, co.population, cop2.new_vaccinations
								--ORDER BY 1, 2
								)
			SELECT *, (Total_Vaccinations / population) * 100 AS Pct_of_Vaccinated
				FROM PvsV
					WHERE location NOT LIKE ('%Income%')
								;
						

--Monthly Infection Rate--

WITH MonthlyInfectionCTE AS
(
SELECT location, date, population, total_cases, (total_cases / population) * 100 AS Monthly_Infection_Rate,
(
	CASE 
		 WHEN date BETWEEN '2020-02-24' AND '2020-02-28' THEN 'February'
		 WHEN date BETWEEN '2020-03-01' AND '2020-03-31' THEN 'March'
		 WHEN date BETWEEN '2020-04-01' AND '2020-04-30' THEN 'April'
		 WHEN date BETWEEN '2020-05-01' AND '2020-05-31' THEN 'May'
		 WHEN date BETWEEN '2020-06-01' AND '2020-06-30' THEN 'June'
		 WHEN date BETWEEN '2020-07-01' AND '2020-07-31' THEN 'July'
		 WHEN date BETWEEN '2020-08-01' AND '2020-08-31' THEN 'August'
		 WHEN date BETWEEN '2020-09-01' AND '2020-09-30' THEN 'September'
		 WHEN date BETWEEN '2020-10-01' AND '2020-10-31' THEN 'October'
		 WHEN date BETWEEN '2020-11-01' AND '2020-11-30' THEN 'November'
		 WHEN date BETWEEN '2020-12-01' AND '2020-12-31' THEN 'December'
		 WHEN date BETWEEN '2021-01-01' AND '2021-01-31' THEN 'January'
		 WHEN date BETWEEN '2021-02-01' AND '2021-02-28' THEN 'February'
		 WHEN date BETWEEN '2021-03-01' AND '2021-03-31' THEN 'March'
		 WHEN date BETWEEN '2021-04-01' AND '2021-04-30' THEN 'April'
		 WHEN date BETWEEN '2021-05-01' AND '2021-05-31' THEN 'May'
		 WHEN date BETWEEN '2021-06-01' AND '2021-06-30' THEN 'June'
		 WHEN date BETWEEN '2021-07-01' AND '2021-07-02' THEN 'July'
		 WHEN date BETWEEN '2021-08-01' AND '2021-08-31' THEN 'August'
		 WHEN date BETWEEN '2021-09-01' AND '2021-09-30' THEN 'September'
		 WHEN date BETWEEN '2021-10-01' AND '2021-10-31' THEN 'October'
		 WHEN date BETWEEN '2021-11-01' AND '2021-11-02' THEN 'November' END
		) AS DateMonth
			FROM PortfolioProject.dbo.COVID19
			WHERE location = 'World'
				GROUP BY location, date, population, total_cases
				ORDER BY Monthly_Infection_Rate DESC
)				
	SELECT MAX(Monthly_Infection_Rate)
		FROM MonthlyInfectionCTE



--Creating Views to store date for Later Visualizations--

/* SQL: Creating and using Views
	- CREATE VIEW
	- Querying the view
	- Finding the view INFORMATION_SCHEMA.VIEWS
	- ALTER / DROP VIEW
*/

CREATE VIEW Cases_and_Pop AS
	SELECT location, date, total_cases, population, 
		(Total_Cases / population) * 100 AS Infection_Rate
			FROM PortfolioProject.dbo.COVID19
				GROUP BY location,date, total_cases, population
				--ORDER BY 1, 2 DESC;



--Queries for Tableu / Power BI--


	--1.Global Numbers
SELECT SUM(new_cases) AS Total_Cases, 
	SUM(CAST(new_deaths AS INT)) AS Total_Deaths, 
	SUM(CAST(new_deaths AS INT)) / SUM(new_cases) * 100 AS Death_Rate
		FROM PortfolioProject.dbo.COVID19 AS co
			WHERE continent IS NOT NULL;


	--2.Continents with the Highest Death Counts
SELECT location, MAX(CAST(total_deaths AS INT)) AS Total_Death_Count
	FROM PortfolioProject.dbo.COVID19
		WHERE continent IS NULL
		AND location NOT LIKE ('%Income%')
		AND location NOT LIKE ('international')
		AND location NOT LIKE ('World')
		AND location NOT LIKE ('European Union')
			GROUP BY location
			ORDER BY 2 DESC;


		--3.Countries with Highest Infection count
SELECT location, population, MAX(total_cases) AS Highest_Infection_Count,  
	MAX((total_Cases / population)) * 100 AS Percentage_of_Infected
		FROM PortfolioProject.dbo.COVID19
			WHERE continent IS NOT NULL
				GROUP BY location, population
				ORDER BY Percentage_of_infected DESC;


		--4.
SELECT location, population, date, MAX(total_cases) AS Highest_Infection_Count,
	MAX((total_Cases / population)) * 100 AS Percentage_of_Infected
		FROM PortfolioProject.dbo.COVID19
			WHERE continent IS NOT NULL
				GROUP BY location, population, date
				ORDER BY 5 DESC;


		--5. Global Infection Progress (Confirmed cases)
SELECT location, date, SUM(total_cases) AS Total_Cases
	FROM PortfolioProject.dbo.COVID19
		WHERE location = 'World'
			GROUP BY location, date
			ORDER BY 2;


		--6. Global Infection Rate
SELECT location, population, date, MAX(total_cases) AS Highest_Infection_Count,
	MAX((total_Cases / population)) * 100 AS Percentage_of_Infected
		FROM PortfolioProject.dbo.COVID19
			WHERE location = 'World'
			AND date = '2021-11-02'
				GROUP BY location, population, date
				ORDER BY 5 DESC;


		--7. Global infection Sum count 
SELECT DISTINCT location, population, MAX(total_cases) AS Infection_Count
		FROM PortfolioProject.dbo.COVID19
			WHERE continent IS NOT NUll
				GROUP BY location, population
				ORDER BY MAX(total_cases) DESC; 
