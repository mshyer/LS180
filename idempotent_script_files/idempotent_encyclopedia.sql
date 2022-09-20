CREATE TABLE continents (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  continent_name varchar(50) UNIQUE
);

INSERT INTO continents (continent_name)
  VALUES  ('Africa'),
          ('Antarctica'),
          ('Asia'),
          ('Australia'),
          ('Europe'),
          ('North America'),
          ('South America');

CREATE TABLE countries (
  id int GENERATED ALWAYS AS IDENTITY,
  name varchar(50) UNIQUE NOT NULL,
  capital varchar(50) NOT NULL,
  population integer,
  continent_id INT,
  FOREIGN KEY (continent_id) REFERENCES continents(id)
      ON DELETE CASCADE
);

INSERT INTO countries (name, capital, population, continent_id)
  VALUES  ('Brazil', 'Brasilia', 208385000, 7),
          ('Egypt', 'Cairo', 96308900, 1),
          ('France', 'Paris', 67158000, 5),
          ('Germany', 'Berlin', 82349400, 5),
          ('Japan', 'Tokyo', 126672000, 3),
          ('USA', 'Washington D.C.', 325365189, 6);

CREATE TABLE celebrities (
  id int GENERATED ALWAYS AS IDENTITY,
  name varchar(100) NOT NULL,
  occupation varchar(150),
  date_of_birth varchar(50),
  deceased boolean DEFAULT false
);

CREATE TABLE animals (
  id int GENERATED ALWAYS AS IDENTITY,
  name varchar(100) NOT NULL,
  binomial_name varchar(100) NOT NULL,
  max_weight_kg decimal(8, 3),
  max_age_years integer,
  conservation_status char(2)
);


ALTER TABLE celebrities RENAME COLUMN name TO first_name;
ALTER TABLE celebrities ALTER COLUMN first_name TYPE varchar(80);

-- SELECT singers.first_name, singers.last_name, albums.album_name, albums.released
--   FROM singers INNER JOIN albums
--     ON singers.id = albums.singer_id
--   WHERE singers.deceased = false AND
--         date_part('year', albums.released) BETWEEN 1980 AND 1989
--     ORDER BY singers.date_of_birth DESC;

-- SELECT singers.first_name, singers.last_name
-- FROM singers LEFT JOIN albums
--   ON singers.id = albums.singer_id
--   WHERE albums.singer_id IS NULL;

-- SELECT s.first_name, s.last_name FROM singers s
--   WHERE s.id NOT IN (
--     SELECT a.singer_id FROM albums a
--   );

-- SELECT o.order_id, p.product_name
--   FROM order_items o INNER JOIN products p
--   ON o.product_id = p.id;

-- SELECT o.*, p.*
--   FROM orders o JOIN order_items oi
--   ON oi.order_id = o.id
--     JOIN products p
--     ON oi.product_id = p.id;

-- SELECT DISTINCT c.customer_name AS "Customers who like fries"
--   FROM orders o JOIN order_items oi
--   ON o.id = oi.order_id
--   JOIN products p
--   ON oi.product_id = p.id
--     JOIN customers c
--     ON o.customer_id = c.id
--   WHERE p.product_name = 'Fries';


-- SELECT sum(products.product_cost) AS "Natasha O'Shea Total Orders Cost"
-- FROM order_items
--   INNER JOIN orders
--   ON orders.id = order_items.order_id
--     INNER JOIN products
--     ON products.id = order_items.product_id
--       INNER JOIN customers
--       ON orders.customer_id = customers.id
--         WHERE customers.customer_name ILIKE '%Natasha%';
-- SELECT products.product_name, count(order_items.id)
-- FROM orders
--   INNER JOIN order_items
--   ON orders.id = order_items.order_id
--     INNER JOIN products
--     ON order_items.product_id = products.id
--     GROUP BY products.product_name
--     ORDER BY products.product_name ASC;

-- SELECT orders.id, products.product_name
-- FROM orders
--   INNER JOIN order_items
--   ON orders.id = order_items.order_id
--     INNER JOIN products
--     ON order_items.product_id = products.id;