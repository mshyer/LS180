CREATE TABLE users (
  id int GENERATED ALWAYS AS IDENTITY,
  username varchar(25) not null,
  enabled BOOLEAN DEFAULT true
);

ALTER TABLE users
  RENAME COLUMN username TO full_name;
ALTER TABLE users
  ALTER COLUMN enabled SET NOT NULL;
ALTER TABLE users
  ADD COLUMN last_login timestamp without time zone DEFAULT now();

INSERT INTO users (full_name, enabled)
VALUES
('John Smith', false),
('Jane Smith', true),
('Harry Potter', true),
('Harry Potter', true),
('Jane Smith', true);

UPDATE users SET enabled = false;

UPDATE users SET enabled = true
WHERE full_name = 'Harry Potter'
OR full_name = 'Jane Smith';

UPDATE users SET full_name = 'Alice Walker' WHERE id = 2;
-- DELETE FROM users 
-- WHERE full_name = 'Harry Potter' AND id = 3;
-- DELETE FROM users;
ALTER TABLE users
ADD PRIMARY KEY (id);

CREATE TABLE addresses (
  user_id int, -- Both a primary and foreign key
  street varchar(30) NOT NULL,
  city varchar(30) NOT NULL,
  state varchar(30) NOT NULL,
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id)
      REFERENCES users (id)
      ON DELETE CASCADE
);

INSERT INTO addresses
         (user_id, street, city, state)
VALUES   (1, '1 Market Street', 'San Francisco', 'CA'),
         (2, '2 Elm Street', 'San Francisco', 'CA'),
         (3, '3 Main Street', 'Boston', 'MA');

CREATE TABLE books (
  id INT GENERATED ALWAYS AS IDENTITY,
  title varchar(100) NOT NULL,
  author varchar(100) NOT NULL,
  published_date timestamp NOT NULL,
  isbn char(12),
  PRIMARY KEY (id),
  UNIQUE (isbn)
);

CREATE TABLE reviews (
  id INT GENERATED ALWAYS AS IDENTITY,
  book_id INT NOT NULL,
  reviewer_name varchar(255),
  content varchar(255),
  rating integer,
  published_date timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (book_id)
    REFERENCES books(id)
    ON DELETE CASCADE
);

INSERT INTO books (title, author, published_date, isbn)
VALUES
    ('My First SQL Book', 'Mary Parker',
        '2012-02-22 12:08:17.320053-03',
        '981483029127'),
    ('My Second SQL Book', 'John Mayer',
        '1972-07-03 09:22:45.050088-07',
        '857300923713'),
    ('My First SQL Book', 'Cary Flint',
        '2015-10-18 14:05:44.547516-07',
        '523120967812');

INSERT INTO reviews
  (book_id, reviewer_name, content, rating,
       published_date)
  VALUES
    (1, 'John Smith', 'My first review', 4,
        '2017-12-10 05:50:11.127281-02'),
    (2, 'John Smith', 'My second review', 5,
        '2017-10-13 15:05:12.673382-05'),
    (2, 'Alice Walker', 'Another review', 1,
        '2017-10-22 23:47:10.407569-07');
CREATE TABLE checkouts (
  id serial,
  user_id int NOT NULL,
  book_id int NOT NULL,
  checkout_date timestamp,
  return_date timestamp,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id)
                        ON DELETE CASCADE,
  FOREIGN KEY (book_id) REFERENCES books(id)
                        ON DELETE CASCADE
);
INSERT INTO checkouts
  (user_id, book_id, checkout_date, return_date)
  VALUES
    (1, 1, '2017-10-15 14:43:18.095143-07',
              NULL),
    (1, 2, '2017-10-05 16:22:44.593188-07',
              '2017-10-13 13:0:12.673382-05'),
    (2, 2, '2017-10-15 11:11:24.994973-07',
              '2017-10-22 17:47:10.407569-07'),
    (5, 3, '2017-10-15 09:27:07.215217-07',
              NULL);