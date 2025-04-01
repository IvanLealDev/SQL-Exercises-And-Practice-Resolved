-- 1) List each country name where the population is larger than that of 'Russia'.

SELECT name FROM world
	WHERE population > (
	SELECT population 
	FROM world
	WHERE name='Russia')
	
go
	
-- 2) Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

SELECT name FROM world
  WHERE continent = 'Europe' 
  AND gdp / population > (SELECT gdp / population
  FROM world
  WHERE name in ('United Kingdom')
  )

go

-- 3) List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

SELECT name, continent 
FROM world
WHERE continent = (SELECT continent FROM world where name in ('Argentina'))
or
continent = (SELECT continent FROM world where name in ('Australia'))
order by name

go

-- 4) Which country has a population that is more than United Kingom but less than Germany? Show the name and the population.

SELECT name, population
FROM world
WHERE population > (SELECT population FROM world where name in ('United Kingdom'))
and
population < (SELECT population FROM world where name in ('Germany'))
order by name

go

-- 5) Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.
-- Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

SELECT name, 
CONCAT(ROUND((population * 100) / (
SELECT population 
FROM world 
WHERE name = 'Germany'), 0), '%')
FROM world
WHERE population IN (
SELECT population
FROM world
WHERE continent='Europe')

go

-- 6) Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)

SELECT name 
FROM world
WHERE gdp > (SELECT max(gdp) 
FROM world 
WHERE continent in ('Europe'))

go

-- 7) Find the largest country (by area) in each continent, show the continent, the name and the area:

SELECT continent, name, area
FROM world 
WHERE area = (SELECT max(area) FROM world WHERE continent in ('Oceania'))
or
area = (SELECT max(area) FROM world WHERE continent in ('South America'))
or
area = (SELECT max(area) FROM world WHERE continent in ('Europe'))
or
area = (SELECT max(area) FROM world WHERE continent in ('North America'))
or
area = (SELECT max(area) FROM world WHERE continent in ('Africa'))
or
area = (SELECT max(area) FROM world WHERE continent in ('Asia'))
or
area = (SELECT max(area) FROM world WHERE continent in ('Caribbean'))
or
area = (SELECT max(area) FROM world WHERE continent in ('Eurasia'))

go

-- 8) List each continent and the name of the country that comes first alphabetically.

SELECT continent, name
FROM world 
WHERE name = (SELECT min(name)FROM world WHERE continent in ('Oceania'))
or
name = (SELECT min(name) FROM world WHERE continent in ('South America'))
or
name = (SELECT min(name) FROM world WHERE continent in ('Europe'))
or
name = (SELECT min(name) FROM world WHERE continent in ('North America'))
or
name = (SELECT min(name) FROM world WHERE continent in ('Africa'))
or
name = (SELECT min(name) FROM world WHERE continent in ('Asia'))
or
name = (SELECT min(name) FROM world WHERE continent in ('Caribbean'))
or
name = (SELECT min(name) FROM world WHERE continent in ('Eurasia'))

order by name

go

-- 9) Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.

SELECT name, continent, population 
FROM world w
WHERE NOT EXISTS (
   SELECT *
   FROM world nx
   WHERE nx.continent = w.continent
   AND nx.population > 25000000
   )

-- 10) Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.

SELECT x.name, x.continent
FROM world AS x
WHERE x.population / 3 > ALL (
  SELECT y.population
  FROM world AS y
  WHERE x.continent = y.continent
  AND x.name != y.name
  )