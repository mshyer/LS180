CREATE TABLE customers (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name text NOT NULL,
  payment_token char(8) UNIQUE NOT NULL CHECK (payment_token ~ '^[A-Z]{8}$')
);

CREATE TABLE services (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  description text NOT NULL,
  price numeric(10, 2) NOT NULL CHECK (price >= 0.00)
);

INSERT INTO customers (name, payment_token)
  VALUES  ('Pat Johnson', 'XHGOAHEQ'),
          ('Nancy Monreal', 'JKWQPJKL'),
          ('Lynn Blake', 'KLZXWEEE'),
          ('Chen Ke-Hua', 'KWETYCVX'),
          ('Scott Lakso', 'UUEAPQPS'),
          ('Jim Pornot', 'XKJEYAZA');
INSERT INTO services (description, price)
  VALUES  ('Unix Hosting', 5.95),
          ('DNS', 4.95),
          ('Whois Registration', 1.95),
          ('High Bandwidth', 15.00),
          ('Business Support', 250.00),
          ('Dedicated Hosting', 50.00),
          ('Bulk Email', 250.00),
          ('One-to-one Training', 999.00);

CREATE TABLE customers_services (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  customer_id integer NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
  service_id integer NOT NULL REFERENCES services(id),
  UNIQUE (customer_id, service_id)
);

INSERT INTO customers (name, payment_token)
  VALUES  ('John Joe', 'EYODHLCN');
INSERT INTO customers_services (customer_id, service_id)
  VALUES  (7, 1),
          (7, 2),
          (7, 3);

INSERT INTO customers_services (customer_id, service_id)
  VALUES  (1, 1), (1, 2), (1, 3),
          (3, 1), (3, 2), (3, 3), (3, 4), (3, 5),
          (4, 1), (4, 4),
          (5, 1), (5, 2), (5, 6),
          (6, 1), (6, 6), (6, 7);

SELECT distinct customers.* FROM customers INNER JOIN customers_services
  ON customers.id = customers_services.customer_id;

SELECT distinct customers.*, services.*
  FROM customers FULL JOIN customers_services
  ON customers.id = customers_services.customer_id
    FULL JOIN services
      ON services.id = customers_services.service_id
  WHERE customer_id IS NULL;

SELECT description FROM customers_services 
RIGHT OUTER JOIN services
    ON services.id = customers_services.service_id
WHERE service_id IS NULL;

SELECT name, string_agg(services.description, ', ') AS description
FROM customers
LEFT OUTER JOIN customers_services
  ON customers.id = customers_services.customer_id
  LEFT OUTER JOIN services
    ON services.id = customers_services.service_id
GROUP BY customers.id;


-- SELECT (
--         CASE 
--           WHEN lag(customers.name) OVER (PARTITION BY customers.name ORDER BY customers.name) ILIKE '%%'
--           THEN NULL
--         ELSE customers.name
--         END) AS weird, 
--         services.description
--   FROM customers LEFT OUTER JOIN customers_services
--     ON customers.id = customers_services.customer_id
--     LEFT OUTER JOIN services
--       ON services.id = customers_services.service_id
-- ORDER BY customers.name;
-- SELECT description, count(description) FROM services
-- JOIN customers_services
--   ON customers_services.service_id = services.id
-- GROUP BY description
-- Having count(description) >= 3;

-- SELECT sum(services.price) AS gross
-- FROM customers_services INNER JOIN services
--   ON services.id = customers_services.service_id;

-- SELECT sum(price) 
-- FROM customers_services INNER JOIN services
--   ON customers_services.service_id = services.id
--   WHERE price >= 100;

-- SELECT (count(id) * (SELECT sum(price) FROM services WHERE price >= 100)) AS sum FROM customers;

-- SELECT sum(price) AS tofu FROM customers CROSS JOIN services
--   WHERE price >= 100;

DELETE FROM customers_services 
  WHERE service_id = (SELECT id FROM services WHERE description = 'Bulk Email');

-- DELETE FROM customers_services WHERE service_id = 7;
SELECT * FROM services WHERE description = 'Bulk Email';
DELETE FROM services WHERE description = 'Bulk Email';

DELETE FROM customers
WHERE name = 'Chen Ke-Hua';