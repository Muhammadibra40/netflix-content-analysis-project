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