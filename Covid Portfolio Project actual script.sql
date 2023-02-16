select * from coviddeaths
where continent is not null
order by 3,4



--select * from covidvaccinations
--order by 3,4


select location, date, total_cases, new_cases, total_deaths, population 
from CovidDeaths
order by 1,2

--Total Cases vs Total Deaths
--Shows the likelihood of dying if you contract Covid in France

select location, date, total_cases,  total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
from CovidDeaths
where location like '%France%'
order by 1,2

--Looking at Total cases vs Population
--Shows the percentage of population that got covid

select location, date,population, total_cases,   (total_cases/population) * 100 as PercentPolpulationInfected
from CovidDeaths
--where location like '%France%'
order by 1,2

--Looking at countries with highest infection rate compared to population


select location, population, max(total_cases) as HighestInfectionCount,   max((total_cases/population)) * 100 as PercentPolpulationInfected

from CovidDeaths
--where location like '%france%'
Group by location, population
order by PercentPolpulationInfected desc

--Shows the countries with the highest death count per population

select location, max(cast(total_deaths as int)) as TotalDeathCount
from CovidDeaths
--where location like '%france%'
where continent is not null
Group by location, population
order by TotalDeathCount desc



--LET'S BREAK THINGS DOWN BY CONTINENT

select continent, max(cast(total_deaths as int)) as TotalDeathCount
from CovidDeaths
--where location like '%france%'
where continent is not null
Group by continent
order by TotalDeathCount desc

--Showing the continent with the highest death count 

select continent, max(cast(total_deaths as int)) as TotalDeathCount
from CovidDeaths
--where location like '%france%'
where continent is not null
Group by continent
order by TotalDeathCount desc

--GlOBAL NUMBERS


select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths,
Sum(cast(new_deaths as int)) /sum(new_cases)* 100 
as DeathPercentage
from CovidDeaths
--where location like '%France%'
where continent is not null
--group by date
order by 1,2


--Looking at Total Population vs Vaccination

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
,sum(cast(vac.new_vaccinations as bigint)) over (Partition by dea.location order by dea.location, dea.date)
as RolllingPeopleVaccinated 
--,(RollingPeopleVaccinated/population) * 100
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location 
  and dea.date = vac.date
  where dea.continent is not null
  order by 2,3


  --USE CTE


  With POpvsVac 
   (Continent, location, date, population, New_Vaccinations, RollingPeopleVaccinated) as
  (
  select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
,sum(cast(vac.new_vaccinations as bigint)) over (Partition by dea.location order by dea.location, dea.date)
as RolllingPeopleVaccinated 
--,(RollingPeopleVaccinated/population) * 100
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location 
  and dea.date = vac.date
  where dea.continent is not null
  --order by 2,3
  )
  select *, (RollingPeopleVaccinated/Population) * 100
  From PopvsVac


  ----TEMP TABLE

  DROP Table if exists #PercentPopulationVaccinated
  Create table #PercentPopulationVaccinated
  (
  Continent nvarchar(255),
  location nvarchar(255),
  Date datetime,
  Population numeric,
  New_vaccinations numeric,
  RollingPeopleVaccinated numeric)

  Insert into #PercentPopulationVaccinated
  select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
,sum(cast(vac.new_vaccinations as bigint)) over (Partition by dea.location order by dea.location, dea.date)
as RolllingPeopleVaccinated 
--,(RollingPeopleVaccinated/population) * 100
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location 
  and dea.date = vac.date
  --where dea.continent is not null
  --order by 2,3

   select *, (RollingPeopleVaccinated/Population) * 100
  From #PercentPopulationVaccinated 



  --Creating view to store data for later visualization

  Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 


select *
from PercentPopulationVaccinated