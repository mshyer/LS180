DROP TABLE IF EXISTS birds;
CREATE TABLE birds (
  id serial PRIMARY KEY,
  name varchar(25),
  age integer,
  species varchar(15)
);

INSERT INTO birds (name, age, species)
  VALUES  ('Charlie', 3, 'Finch'),
          ('Allie', 5, 'Owl'),
          ('Jennifer', 3, 'Magpie'),
          ('Jamie', 4, 'Owl'),
          ('Roy', 8, 'Crow');

SELECT * FROM birds WHERE age < 5;

UPDATE birds
SET species = 'Raven'
WHERE species = 'Crow';

UPDATE birds
SET species = 'Hawk'
WHERE name = 'Jamie';

SELECT * FROM birds
WHERE species = 'Finch' AND age = 3;

DELETE FROM birds
WHERE species = 'Finch' AND age = 3;

-- ALTER TABLE birds
-- ADD CHECK (age >= 0);

ALTER TABLE birds
ADD CONSTRAINT check_age CHECK(age >= 0);
-- DROP TABLE birds;

ALTER TABLE birds
ADD COLUMN fun integer,
ADD COLUMN yuns integer;
ALTER TABLE birds
DROP COLUMN fun,
DROP COLUMN yuns;