-- Netflix Data Analysis

DROP TABLE IF EXISTS Movies_shows_Data;

CREATE TABLE Movies_shows_Data(
	show_id VARCHAR(7) NOT NULL,
	type VARCHAR(10) NOT NULL,	
	title VARCHAR(150) NOT NULL,	
	director VARCHAR(210) NULL,
	casts VARCHAR(800) NULL,
	country VARCHAR(150) NULL,
	date_added VARCHAR(50) NULL,
	release_year INT NOT NULL,
	rating VARCHAR(110) NULL,
	duration VARCHAR(10) NULL,
	listed_in VARCHAR(80) NOT NULL, 
	description VARCHAR(250) NOT NULL
);

SELECT * 
FROM movies_shows_data;

-- Checking if all the records were imported from the csv file (8807)
SELECT COUNT(*)
FROM movies_shows_data;

SELECT  DISTINCT type
FROM movies_shows_data;

-- 4528 ==> Since there are 8,807 movies and only 4,528 directors, it is likely that at least some directors have directed two or more movie.
-- Some directors likely directed more than one movie, but not necessarily that every director directed at least two.
SELECT  COUNT(DISTINCT director)
FROM movies_shows_data;

-- Oldest movie in the dataset released in 1925
-- Newest movie in the dataset released in 2021 so (1925 - 2021)
SELECT  MAX(release_year),
		MIN(release_year)
FROM movies_shows_data;

SELECT  COUNT(DISTINCT country)
FROM movies_shows_data;

-- 1
-- No. of Movies = 6131
-- No. of TV shows = 2676
SELECT COUNT(show_id)
FROM movies_shows_data
WHERE type = 'Movie';

SELECT COUNT(show_id)
FROM movies_shows_data
WHERE type = 'TV Show';


-- 2 
-- Generally ==> "TV-MA"	3207
-- Movies ==> "TV-MA"	2062
-- TV Shows ==> "TV-MA"	1145
SELECT DISTINCT rating
FROM movies_shows_data;

WITH diff_rating_count AS (
	SELECT  rating, 
			COUNT(rating)
	FROM movies_shows_data
	-- Movie or TV Show 
	WHERE type = 'TV Show'
	GROUP BY rating
)

SELECT  rating,
		count
FROM diff_rating_count
ORDER BY count DESC
LIMIT 1;


-- 3
-- Movies released in 2020
SELECT title
FROM movies_shows_data
WHERE release_year = 2020;

--4??????
SELECT  country,
		COUNT(title) AS "Content num"
FROM movies_shows_data
GROUP BY country
ORDER BY "Content num"
LIMIT 5;

--5
SELECT 
    MAX(CAST(REPLACE(duration, ' min', '') AS INTEGER)) AS duration_in_minutes
FROM 
    movies_shows_data
WHERE type = 'Movie';

SELECT 
		MAX(CAST(REPLACE(duration, ' Seasons', '')AS INTEGER))
FROM movies_shows_data
WHERE type = 'TV Show' 
AND duration LIKE '%Seasons';


--6
SELECT title, date_added
FROM movies_shows_data

SELECT 	title,
		CAST (string_to_array(date_added, ','))[2] AS INTEGER
FROM movies_shows_data;

SELECT (string_to_array(fruit_list, ','))[1] AS first_fruit
FROM fruits;

WITH Movies_date_added AS(
SELECT 
    title,
	type,
    CASE 
        WHEN (string_to_array(date_added, ','))[2] IS NOT NULL 
        THEN CAST(trim(both ' ' from (string_to_array(date_added, ','))[2]) AS INTEGER) 
        ELSE NULL 
    END AS year
FROM 
    movies_shows_data)

SELECT *
FROM Movies_date_added
WHERE year >= 2019 AND year <= 2021;

--7
SELECT  title,
		type
FROM movies_shows_data
WHERE director = 'Rajiv Chilaka';


--8
WITH TV_shows_duration AS
(SELECT 	title,
		type,
		CAST(REPLACE(duration, 'Seasons', '')AS INTEGER) AS SeasonsNo
FROM movies_shows_data
WHERE duration LIKE '%Seasons')

SELECT  title,
		SeasonsNo
FROM TV_shows_duration
WHERE SeasonsNo > 5;


--9
SELECT *
FROM movies_shows_data


WITH content_genre AS( 
SELECT 	title,
		trim(both ' ' FROM unnest(string_to_array(listed_in, ','))) AS genres
FROM movies_shows_data)

SELECT  genres,
		COUNT(title) AS ContentNo
FROM content_genre
GROUP BY genres
ORDER BY ContentNo DESC;


--10
WITH countries AS( 
SELECT 	title,
		trim(both ' ' FROM unnest(string_to_array(country, ','))) AS country,
		release_year
FROM movies_shows_data)

SELECT  country,
		ROUND(AVG(release_year), 0) AS "Average Release year"
FROM countries
GROUP BY country;

--11
WITH content_genre AS( 
SELECT 	title,
		type,
		trim(both ' ' FROM unnest(string_to_array(listed_in, ','))) AS genres
FROM movies_shows_data
where type = 'Movie')

SELECT  title,
		genres
FROM content_genre
WHERE genres = 'Documentaries';


--12
SELECT  title,
		type
FROM movies_shows_data
WHERE director IS NULL;

--13

WITH content_actor AS(
SELECT 	title,
		release_year AS year,
		trim(both ' ' FROM unnest(string_to_array(casts, ','))) AS actor
FROM movies_shows_data)

SELECT  COUNT(title)
FROM content_actor
WHERE actor = 'Salman Khan'
AND year >= 2011 AND year <= 2021;

--14
