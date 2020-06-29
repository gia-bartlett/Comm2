--single line comments--
/*multi
line
comments*/

--Alt Shift multiline select--

--Relational databases coined by Edgar F. Codd--

/*
-DROP
-CREATE
-USE
-INSERT
-SELECT
-ALTER
-FROM
-UPDATE
*/

--DELETE A DATABASE--
DROP DATABASE georgina_bartlett;

--CREATE A NEW DATABASE--
CREATE DATABASE georgina_bartlett;

--USE A DATABASE--
USE georgina_bartlett;

DROP TABLE film_table

--CREATING A NEW TABLE--
CREATE TABLE film_table (
    film_id INT IDENTITY (1,1) PRIMARY KEY
    ,film_name VARCHAR (70)
    ,film_type VARCHAR (50)
    ,date_of_release DATE
    ,director VARCHAR (50)
    ,writer VARCHAR (50)
    ,star DECIMAL (2, 1)
    ,film_language VARCHAR (50)
    ,official_website VARCHAR (70)
    ,plot_summary VARCHAR (200)
    ,release_date DATE
);

--INSERT DETAILES INTO TABLE--
INSERT INTO film_table (
    film_name
    ,film_type
    ,date_of_release
    ,director
    ,writer
    ,star
    ,film_language
    ,official_website
    ,plot_summary
    ,release_date
)
VALUES (
    'La Femme Nikita'
    ,'Thriller'
    ,'1990/02/17'
    ,'Luc Besson'
    ,'Luc Besson'
    ,5
    ,'French'
    ,'https://www.imdb.com/title/tt0100263/'
    ,'A teen who robs a pharmacy and shoots a policeman is sentenced to life in prison.'
    ,'1990/02/17'
);

SELECT * FROM film_table;

--ALTERING A TABLE--
ALTER TABLE film_table ADD film_id INT IDENTITY PRIMARY KEY;

INSERT INTO film_table(
    film_name, film_type, release_date, director, writer, star, film_language, official_website, plot_summary
)
VALUES
(
    'SQL', 'Romance', '2000-02-20', 'Neil Armstrong', 'Anais', 4.5, 'japanese', 'www.sql.com', 'a very painful journey into DevOps'
),
(
    'Python', 'Drama', '1993-12-20', 'Bill Gates', 'Shane', 3, 'french', 'www.python.com', 'a very useful programming language'
),
(
    'HTML', 'Family', '2015-06-20', 'Hans Carl', 'Tipee', 5, 'swahili', 'www.html.com', 'the basics of coding'
);


SELECT * FROM film_table;

--CREATING A SECOND TABLE--
DROP TABLE director;

CREATE TABLE director (
    director_id INT IDENTITY (1, 1)
    ,director_name VARCHAR (70)
    ,film_id INT
    ,PRIMARY KEY (director_id)
    ,FOREIGN KEY (film_id) REFERENCES film_table (film_id)
    ,ON DELETE CASCADE
);

INSERT INTO director (
    director_name
    ,film_id
)
VALUES 
('Luc Besson', 1)
,('Peter Jackson', 2)
;


SELECT * FROM director;

--ON DELETE CASCADE--
/*Creating a foreign key with cascade delete.
It specifies that the child data is deleted when the parent data is deleted.*/

/*Why is this not working Auto and manual way??*/

/*SOLUTION*/
UPDATE director SET director_name= 'Jamie' where film_id = 2

ALTER TABLE director
ADD CONSTRAINT film_id
FOREIGN KEY (film_id) 
REFERENCES film_table (film_id) ON DELETE CASCADE

DELETE FROM film_table WHERE film_id =1;

SELECT * FROM director;






