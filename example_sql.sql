DROP TABLE IF EXISTS public.films;
CREATE TABLE films (title varchar(255), "year" integer, genre varchar(100));

INSERT INTO films(title, "year", genre) VALUES ('Die Hard', 1988, 'action');  
INSERT INTO films(title, "year", genre) VALUES ('Casablanca', 1942, 'drama');  
INSERT INTO films(title, "year", genre) VALUES ('The Conversation', 1974, 'thriller');  

ALTER TABLE films
  ADD COLUMN director varchar(255),
  ADD COLUMN duration integer;

UPDATE films  
    SET director = 'John McTiernan', 
        duration = 132 
    WHERE title = 'Die Hard';
UPDATE films
    SET director = 'Michael Curtiz', 
        duration = 102 
    WHERE title = 'Casablanca';
UPDATE films  
    SET director = 'Francis Ford Coppola',
        duration = 113 
    WHERE title = 'The Conversation';

INSERT INTO films
  VALUES  ('1984', 1956, 'scifi', 'Michael Anderson', 90),
          ('Tinker Tailor Soldier Spy', 2011, 'espionage', 'Tomas Alfredson', 127),
          ('The Birdcage', 1996, 'comedy', 'Mike Nichols', 118);

-- SELECT title,
--        (date_part('year', date(now())) - year) AS age 
--   FROM films
--   ORDER BY age;

SELECT title FROM films
ORDER BY duration DESC
LIMIT 1;


----


-- SELECT count(state) FROM people;


-- SELECT  
--       DISTINCT split_part(email, '@', 2) AS domain,
--       count(id)
--   FROM people
--   GROUP BY domain;

-- SELECT split_part(email, '@', 2) FROM people LIMIT 5;

-- SELECT count(email ILIKE (split_part(email, '@', 2))) FROM people;

-- SElECT DISTINCT substring(email from (position('@' in email)) + 1) AS domain,
--        count(id)
--   FROM people
--   GROUP BY domain
--   ORDER BY count DESC;

-- DELETE FROM people
-- WHERE id = 3399;

-- DELETE FROM people
-- WHERE state = 'CA';

-- UPDATE people
-- SET given_name = upper(given_name)
-- WHERE email LIKE '%teleworm.us'

-- DELETE FROM people;


-- DROP TABLE IF EXISTS public.employees;
-- CREATE TABLE employees (
--     first_name character varying(100),
--     last_name character varying(100),
--     department character varying(100),
--     vacation_remaining integer
-- );

-- INSERT INTO employees VALUES ('Leonardo', 'Ferreira', 'finance', 14);
-- INSERT INTO employees VALUES ('Sara', 'Mikaelsen', 'operations', 14);
-- INSERT INTO employees VALUES ('Lian', 'Ma', 'marketing', 13);
-- ALTER TABLE employees ALTER COLUMN vacation_remaining SET NOT NULL;
-- ALTER TABLE employees ALTER COLUMN vacation_remaining SET DEFAULT 0;

-- INSERT INTO employees (first_name, last_name) VALUES ('Haiden', 'Smith');
-- ALTER TABLE employees ALTER COLUMN department SET DEFAULT 'Unassigned';
-- UPDATE employees
-- SET department = 'Unassigned'
-- WHERE department IS NULL;

--     date    | low | high
-- ------------+-----+------
--  2016-03-01 | 34  | 43
--  2016-03-02 | 32  | 44
--  2016-03-03 | 31  | 47
--  2016-03-04 | 33  | 42
--  2016-03-05 | 39  | 46
--  2016-03-06 | 32  | 43
--  2016-03-07 | 29  | 32
--  2016-03-08 | 23  | 31
--  2016-03-09 | 17  | 28
DROP TABLE IF EXISTS public.temperatures;
CREATE TABLE temperatures (
  date date NOT NULL,
  low integer NOT NULL,
  high integer NOT NULL
);

INSERT INTO temperatures
VALUES  ('2016-03-01', 34, 43),
        ('2016-03-02', 32, 44),
        ('2016-03-03', 31, 47),
        ('2016-03-04', 33, 42),
        ('2016-03-05', 39, 46),
        ('2016-03-06', 32, 43),
        ('2016-03-07', 29, 32),
        ('2016-03-08', 23, 31),
        ('2016-03-09', 17, 28);

SELECT round((low + high)/2.0, 1) AS average_temp FROM temperatures
WHERE date BETWEEN '2016-03-02' AND '2016-03-08';

ALTER TABLE temperatures
ADD COLUMN rainfall int DEFAULT 0;


DROP TABLE IF EXISTS public.films;
CREATE TABLE films (title varchar(255), year integer, genre varchar(100), director varchar(255), duration integer);

INSERT INTO films(title, year, genre, director, duration) VALUES ('Die Hard', 1988, 'action', 'John McTiernan', 132);  
INSERT INTO films(title, year, genre, director, duration) VALUES ('Casablanca', 1942, 'drama', 'Michael Curtiz', 102);  
INSERT INTO films(title, year, genre, director, duration) VALUES ('The Conversation', 1974, 'thriller', 'Francis Ford Coppola', 113);  
INSERT INTO films(title, year, genre, director, duration) VALUES ('1984', 1956, 'scifi', 'Michael Anderson', 90);  
INSERT INTO films(title, year, genre, director, duration) VALUES ('Tinker Tailor Soldier Spy', 2011, 'espionage', 'Tomas Alfredson', 127);  
INSERT INTO films(title, year, genre, director, duration) VALUES ('The Birdcage', 1996, 'comedy', 'Mike Nichols', 118);

ALTER TABLE films
ALTER COLUMN title
SET NOT NULL;

ALTER TABLE films
ADD CONSTRAINT title_unique UNIQUE (title);

ALTER TABLE films
DROP CONSTRAINT title_unique;

-- ALTER TABLE films
-- ADD CHECK (length(title) > 0);
ALTER TABLE films
ADD CONSTRAINT check_title_length CHECK(length(title) > 0);

ALTER TABLE films
DROP CONSTRAINT check_title_length;

ALTER TABLE films
ALTER COLUMN year
SET NOT NULL;

ALTER TABLE films
ALTER COLUMN genre
SET NOT NULL;

ALTER TABLE films
ALTER COLUMN director
SET NOT NULL;

ALTER TABLE films
ALTER COLUMN duration
SET NOT NULL;

ALTER TABLE films
ADD CONSTRAINT check_year_film CHECK(year BETWEEN 1900 AND 2100);

ALTER TABLE films
ADD CONSTRAINT check_director CHECK(length(director) > 3 AND position(' ' in director) > 0);


-- INSERT INTO films(title, year, genre, director, duration) VALUES ('', 1988, 'action', 'John McTiernan', 132);  

DROP TABLE if EXISTS public.films;
DROP TABLE if EXISTS public.temperatures;
DROP TABLE if EXISTS public.weather;
DROP TABLE if EXISTS public.employees;

