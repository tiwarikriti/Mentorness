LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Corona Virus Dataset.csv" INTO TABLE corona_virus
  FIELDS TERMINATED BY ',' ENCLOSED BY '"'
  LINES TERMINATED BY '\r\n'
  IGNORE 1 LINES;
  
  
  -- Write a code to check NULL values
  Select count(*) as null_values from corona_virus 
  where Province is null or
  Country is null or
  Latitude is null or 
  Longitude is null or
  Duration is null or 
  Confirmed is null or 
  Deaths is null or
  Recovered is null;
  
ALTER TABLE corona_virus 
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;
Select count(*) from corona_virus;

-- If NULL values are present, update them with zeros for all columns. 
UPDATE corona_virus
SET Province = COALESCE(Province, 0),
Country = COALESCE(Country, 0),
Latitude = COALESCE(Latitude, 0),
Longitude = COALESCE(Longitude, 0),
Duration = COALESCE(Duration, 0),
Confirmed = COALESCE(Confirmed, 0),
Deaths = COALESCE(Deaths, 0),
Recovered = COALESCE(Recovered, 0)
Where id > 0;

-- check total number of rows
Select count(*) AS total_rows from corona_virus;

-- Check what is start_date and end_date
select min(duration) as start_date,
max(duration) as end_date from corona_virus;

-- Number of month present in dataset
Select count(distinct(month(duration))) from corona_virus;

-- Find monthly average for confirmed, deaths, recovered
Select avg(confirmed), avg(deaths), avg(recovered) from corona_virus group by month(duration);

-- Find most frequent value for confirmed, deaths, recovered
select distinct confirmed, count(Confirmed) as frequent from `corona_virus` group by confirmed order by count(Confirmed) desc limit 1;
select distinct deaths, count(deaths) as frequent from `corona_virus` group by deaths order by count(deaths) desc limit 1;
select distinct recovered, count(recovered) as frequent from `corona_virus` group by recovered order by count(recovered) desc limit 1;

-- Find minimum values for confirmed, deaths, recovered per year
Select year(duration), min(confirmed), min(deaths), min(recovered) from corona_virus group by year(duration);

-- Find maximum values of confirmed, deaths, recovered per year 
Select year(duration), max(confirmed), max(deaths), max(recovered) from corona_virus group by year(duration);

-- The total number of case of confirmed, deaths, recovered each month
Select year(duration), month(duration), sum(confirmed), sum(deaths), sum(recovered) from corona_virus group by year(duration), month(duration) order by year(duration), month(duration);

-- Check how corona virus spread out with respect to confirmed case
select sum(confirmed), round(avg(confirmed),2) , round(stddev(confirmed),2), round(variance(confirmed),2) from corona_virus;

-- Check how corona virus spread out with respect to death case per month
select year(duration), month(duration), sum(deaths), avg(deaths), stddev(deaths), variance(deaths) from corona_virus group by year(duration), month(duration) order by year(duration), month(duration);

-- Check how corona virus spread out with respect to recovered case
select sum(recovered), avg(recovered), stddev(recovered), variance(recovered) from corona_virus;

-- Find Country having highest number of the Confirmed case
select country from corona_virus where confirmed = (select max(confirmed) from corona_virus);

-- Find Country having lowest number of the death case
select distinct(country) from corona_virus where deaths = (select min(deaths) from corona_virus);

-- Find top 5 countries having highest recovered case
select distinct(country), recovered from corona_virus order by recovered desc limit 5;


