 -- name	age	occupation
-- Abby	34	biologist
-- Mu'nisah	26	NULL
-- Mirabelle	40	contractor
CREATE TABLE
  people (
    id integer GENERATED ALWAYS AS IDENTITY,
    name varchar(50),
    age int CHECK (age < 1000),
    occupation varchar(25)
  );

INSERT INTO
  people (name, age, occupation)
VALUES
  ('Abby', 34, 'biologist'),
  ('Mu''nisah', 26, NULL),
  ('Mirabelle', 40, 'contractor');

-- SELECT * FROM people
-- LIMIT 1
-- OFFSET 1;
-- SELECT * FROM people
-- WHERE id = 2;
-- SELECT * FROM people
-- WHERE name = 'Mu''nisah';
CREATE TABLE
  birds (
    name varchar(255),
    length decimal(4, 1),
    wingspan decimal(4, 1),
    family text,
    extinct boolean DEFAULT false
  );

INSERT INTO
  birds (name, length, wingspan, family, extinct)
VALUES
  ('Spotted Towhee', 21.6, 26.7, 'Emberizidae', false),
  ('American Robin', 25.5, 36.0, 'Turdidae', false),
  (
    'Greater Koa Finch',
    19.0,
    24.0,
    'Fringillidae',
    true
  ),
  ('Carolina Parakeet', 33.0, 55.8, 'Psittacidae', true),
  ('Common Kestrel', 35.5, 73.5, 'Falconidae', false);

-- SELECT name, family FROM birds
-- WHERE extinct = false
-- ORDER BY length DESC;
-- SELECT round(avg(wingspan), 2) AS round, min(wingspan), max(wingspan) FROM birds;
CREATE TABLE
  menu_items (
    item text,
    prep_time integer,
    ingredient_cost numeric(4, 2),
    sales integer,
    menu_price numeric(5, 2)
  );

INSERT INTO
  menu_items
VALUES
  ('omelette', 10, 1.50, 182, 7.99),
  ('tacos', 5, 2.00, 254, 8.99),
  ('oatmeal', 1, 0.50, 79, 5.99);

SELECT
  item,
  menu_price,
  ingredient_cost,
  round(13 * prep_time / 60.0, 2) AS labor,
  round(
    (
      menu_price - ((13.0 * (prep_time / 60.0)) + ingredient_cost)
    ),
    2
  ) AS profit
FROM
  menu_items
ORDER BY
  profit DESC;

-- SELECT
--   item,
--   (menu_price - ingredient_cost) AS profit_margin
-- FROM
--   menu_items
-- ORDER BY
--   profit_margin DESC
-- LIMIT
--   1;