USE georgina_bartlett;

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
)
(
    'The Fifth Element'
    ,'Action'
    ,'1997/05/09'
    ,'Luc Besson'
    ,'Luc Besson'
    ,5
    ,'English'
    ,'https://www.imdb.com/title/tt0119116/'
    ,'In the colorful future, a cab driver unwittingly becomes the central figure in the search for a legendary cosmic weapon to keep Evil and Mr. Zorg at bay.'
    ,'1990/05/09'
);

SELECT * FROM film_table;

CREATE TABLE director (
    director_id INT IDENTITY (1, 1)
    ,director_name VARCHAR (70)
    ,film_id INT
    ,PRIMARY KEY (director_id)
    ,FOREIGN KEY (film_id) REFERENCES film_table (film_id)
    ,ON DELETE CASCADE
);

SELECT * FROM director;

INSERT INTO director (
    director_name
    ,film_id
)
VALUES 
('Luc Besson', 1)
,('Luc Besson', 2)
;