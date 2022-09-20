--  id | customer_name  |         burger          |    side     |      drink      |     customer_email      | customer_loyalty_points | burger_cost | side_cost | drink_cost
-- ----+----------------+-------------------------+-------------+-----------------+-------------------------+-------------------------+-------------+-----------+------------
--   3 | Natasha O'Shea | LS Double Deluxe Burger | Onion Rings | Chocolate Shake | natasha@osheafamily.com |                      42 |        6.00 |      1.50 |       2.00
--   2 | Natasha O'Shea | LS Cheeseburger         | Fries       |                 | natasha@osheafamily.com |                      18 |        3.50 |      1.20 |       0.00
--   1 | James Bergman  | LS Chicken Burger       | Fries       | Lemonade        | james1998@email.com     |                      28 |        4.50 |      1.20 |       1.50
--   4 | Aaron Muller   | LS Burger               | Fries       |                 |                         |                      13 |        3.00 |      1.20 |       0.00
CREATE TABLE customers (
  id INT GENERATED ALWAYS AS IDENTITY,
  customer_name varchar(50) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE email_addresses (
  customer_id integer PRIMARY KEY,
  customer_email varchar(200) UNIQUE NOT NULL,

  FOREIGN KEY (customer_id)
    REFERENCES customers(id)
    ON DELETE CASCADE
);

INSERT INTO customers (customer_name)
  VALUES  ('James Bergman'),
          ('Natasha O''Shea'),
          ('Aaron Muller');
INSERT INTO email_addresses (customer_id, customer_email)
  VALUES  (1, 'james1998@email.com'),
          (2, 'natasha@osheafamily.com');


-- Product Name	Product Cost	Product Type	Product Loyalty Points
    -- LS Burger	3.00	Burger	10
    -- LS Cheeseburger	3.50	Burger	15
    -- LS Chicken Burger	4.50	Burger	20
    -- LS Double Deluxe Burger	6.00	Burger	30
    -- Fries	1.20	Side	3
    -- Onion Rings	1.50	Side	5
    -- Cola	1.50	Drink	5
    -- Lemonade	1.50	Drink	5
    -- Vanilla Shake	2.00	Drink	7
    -- Chocolate Shake	2.00	Drink	7
    -- Strawberry Shake	2.00	Drink	7
CREATE TABLE products (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  product_name varchar(50) NOT NULL,
  product_cost decimal(4,2) NOT NULL,
  product_type varchar(50) NOT NULL,
  product_loyalty_points decimal(4,2) DEFAULT 0 NOT NULL

);
INSERT INTO products (product_name, product_cost, product_type, product_loyalty_points)
  VALUES  ('LS Burger', 3.00, 'Burger', 10 ),
          ('LS Cheeseburger', 3.50, 'Burger', 15 ),
          ('LS Chicken Burger', 4.50, 'Burger', 20 ),
          ('LS Double Deluxe Burger', 6.00, 'Burger', 30 ),
          ('Fries', 1.20, 'Side', 3 ),
          ('Onion Rings', 1.50, 'Side', 5 ),
          ('Cola', 1.50, 'Drink', 5 ),
          ('Lemonade', 1.50, 'Drink', 5 ),
          ('Vanilla Shake', 2.00, 'Drink', 7 ),
          ('Chocolate Shake', 2.00, 'Drink', 7 ),
          ('Strawberry Shake', 2.00, 'Drink', 7);

CREATE TABLE orders (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  customer_id INT,
  order_status varchar(25),
  FOREIGN KEY (customer_id)
    REFERENCES customers(id)
    ON DELETE CASCADE


);

CREATE TABLE order_items (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  FOREIGN KEY (order_id)
    REFERENCES orders(id)
    ON DELETE CASCADE,
  FOREIGN KEY (product_id)
    REFERENCES products(id)
    ON DELETE CASCADE
);

INSERT INTO orders (customer_id, order_status)
  VALUES  (1, 'In Progress'),
          (2, 'Placed'),
          (2, 'Complete'),
          (3, 'Placed');
INSERT INTO order_items (order_id, product_id)
  VALUES  (1, 3),
          (1, 5),
          (1, 6),
          (1, 8),
          (2, 2),
          (2, 5),
          (2, 6),
          (3, 4),
          (3, 2),
          (3, 5),
          (3, 5),
          (3, 6),
          (3, 10),
          (3, 11),
          (4, 1),
          (4, 5);

-- James has one order, consisting of a Chicken Burger, Fries, Onion Rings, and a Lemonade. It has a status of 'In Progress'.

-- Natasha has two orders. 
-- The first consists of a Cheeseburger, Fries, and a Cola, and has a status of 'Placed';
-- the second consists of a Double Deluxe Burger, a Cheeseburger, two sets of Fries, Onion Rings, a Chocolate Shake and a Vanilla Shake, and has a status of 'Complete'.

-- Aaron has one order, consisting of an LS Burger and Fries. It has a status of 'Placed'.

-- Assume that the order_status field of the orders table can hold strings of up to 20 characters.