CREATE TABLE stars (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name varchar(25) UNIQUE NOT NULL,
  distance integer NOT NULL CHECK (distance > 0),
  -- spectral_type char(1) CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
  spectral_type char(1),
  companions integer NOT NULL CHECK (companions >= 0)
);

INSERT INTO stars VALUES  (default, 'Alpha Centaaaki', 33333, 'Z', 1),
                          (default, 'Alpha Pudaki', 22, 'A', 1);

CREATE TABLE planets (
  id serial PRIMARY KEY,
  star_id integer NOT NULL REFERENCES stars(id) ON DELETE CASCADE,
  designation char(1) UNIQUE,
  mass integer
);

INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Alpha Centauri B', 4, 'K', 3);

ALTER TABLE stars
  ALTER COLUMN name
  TYPE varchar(50);

ALTER TABLE stars
  ALTER COLUMN distance
  TYPE numeric;

DELETE FROM stars
  WHERE spectral_type NOT IN ('O', 'B', 'A', 'F', 'G', 'K', 'M');

ALTER TABLE stars
  ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
  ALTER COLUMN spectral_type
    SET NOT NULL;

CREATE TYPE spectral_type_enum AS enum ('O', 'B', 'A', 'F', 'G', 'K', 'M');

ALTER TABLE stars
  DROP CONSTRAINT stars_spectral_type_check,
  ALTER COLUMN spectral_type
  TYPE spectral_type_enum USING spectral_type::spectral_type_enum;

ALTER TABLE planets
  ADD CHECK (mass >= 0.0),
  ALTER COLUMN mass TYPE numeric,
  ALTER COLUMN mass SET NOT NULL,
  ALTER COLUMN designation SET NOT NULL;

ALTER TABLE planets
ADD COLUMN semi_major_axis numeric NOT NULL default 0;

CREATE TABLE moons (
  id serial PRIMARY KEY,
  planet_id integer NOT NULL REFERENCES planets(id) ON DELETE CASCADE,
  designation integer NOT NULL CHECK (designation > 0),
  semi_major_axis numeric CHECK (semi_major_axis > 0.0),
  mass numeric CHECK (mass > 0.0)
);