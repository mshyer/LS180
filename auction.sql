CREATE TABLE bidders (
  id SERIAL PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text NOT NULL,
  initial_price numeric(6,2) NOT NULL CHECK (initial_price BETWEEN 0.01 AND 1000),
  sales_price numeric(6,2) CHECK (sales_price BETWEEN 0.01 AND 1000)
);

CREATE TABLE bids (
  id SERIAL PRIMARY KEY,
  bidder_id integer NOT NULL REFERENCES bidders(id) ON DELETE CASCADE,
  item_id integer NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  amount numeric(6,2) NOT NULL CHECK(amount BETWEEN 0.01 AND 1000)
);
CREATE INDEX ON bids (bidder_id, item_id);
COPY bidders FROM '/Users/michaelshyer/LaunchSchool/LS180/bidders.csv' WITH HEADER CSV;
COPY items FROM '/Users/michaelshyer/LaunchSchool/LS180/items.csv' HEADER CSV;
COPY bids FROM '/Users/michaelshyer/LaunchSchool/LS180/bids.csv' WITH HEADER CSV;

SELECT DISTINCT name AS "Bid on Items" FROM items JOIN bids
ON items.id = bids.item_id;

SELECT name AS "Bid on Items" FROM items
WHERE items.id IN (SELECT item_id FROM bids);

SELECT name AS "Not Bid On" FROM items
WHERE items.id NOT IN (SELECT item_id FROM bids);

SELECT DISTINCT bidders.name FROM bids INNER JOIN bidders ON bidders.id = bids.bidder_id;

SELECT bidders.name FROM bidders
WHERE EXISTS (SELECT * FROM bids WHERE bids.bidder_id = bidders.id);

SELECT MAX(bid_counts.count) 
FROM (SELECT count(bids.bidder_id) AS count 
        FROM bids GROUP BY bidder_id
      ) AS bid_counts;

--     name      | count
-- --------------+-------
-- Video Game    |     4
-- Outdoor Grill |     1
-- Painting      |     8
-- Tent          |     4
-- Vase          |     9
-- Television    |     0

SELECT name, (SELECT count(item_id)
                    FROM bids WHERE items.id = item_id)
FROM items;

SELECT name, (SELECT COUNT(item_id)
                     FROM bids WHERE item_id = items.id)
FROM items;

SELECT items.name, count(bids.id)
FROM items LEFT OUTER JOIN bids
ON bids.item_id = items.id
GROUP BY items.name;

SELECT id FROM items
WHERE ROW(name, initial_price, sales_price) = ROW('Painting', 100.00, 250);

EXPLAIN SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

EXPLAIN ANALYZE SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);