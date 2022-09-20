CREATE TABLE devices (
  id serial PRIMARY KEY,
  name text NOT NULL,
  created_at timestamp default now()
);

CREATE TABLE parts (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  part_number integer UNIQUE NOT NULL,
  device_id integer REFERENCES devices(id)
);

ALTER TABLE parts
ADD CHECK (part_number BETWEEN 0 AND 10000);

INSERT INTO devices (name)
  VALUES  ('Accelerometer'),
          ('Gyroscope');

INSERT INTO parts (device_id, part_number)
  VALUES  (1, 4234),
          (1, 5435),
          (1, 31),
          (2, 234),
          (2, 15),
          (2, 3),
          (2, 3445),
          (2, 3388);
INSERT INTO parts (part_number)
  VALUES  (33),
          (44),
          (55);

SELECT name, part_number 
  FROM devices INNER JOIN parts 
  ON parts.device_id = devices.id;

-- SELECT * FROM parts WHERE part_number::text LIKE '3%';
-- SELECT * FROM parts WHERE position('3' IN part_number::text) = 1;

-- SELECT * FROM parts WHERE left(part_number::text, 2) = '31';

-- SELECT devices.name, count(devices.name)
--   FROM devices LEFT OUTER JOIN parts
--   ON devices.id = parts.device_id
--   GROUP BY devices.name
--   ORDER BY count DESC;

-- SELECT part_number, device_id FROM parts WHERE device_id IS NOT NULL;
-- SELECT part_number, device_id FROM parts WHERE device_id IS NULL;

INSERT INTO devices(name) VALUES ('Magnetometer');
INSERT INTO parts (part_number, device_id) VALUES (42, 3);

UPDATE parts
SET device_id = 1
WHERE
part_number = (SELECT min(part_number) FROM parts);

ALTER TABLE parts
  DROP CONSTRAINT parts_device_id_fkey,
  ADD FOREIGN KEY (device_id) REFERENCES devices(id) ON DELETE CASCADE;

SELECT * FROM DEVICES WHERE name = 'Accelerometer';
DELETE FROM devices WHERE name = 'Accelerometer';