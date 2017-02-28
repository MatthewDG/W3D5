CREATE TABLE dogs (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  breed VARCHAR(255) NOT NULL,
  owner_id INTEGER,

  FOREIGN KEY(owner_id) REFERENCES human(id)
);

CREATE TABLE humans (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  house_id INTEGER,

  FOREIGN KEY(house_id) REFERENCES human(id)
);

CREATE TABLE houses (
  id INTEGER PRIMARY KEY,
  town VARCHAR(255) NOT NULL
);

INSERT INTO
  houses (id, town)
VALUES
  (1, "Middletown"),
  (2, "New York City");

INSERT INTO
  humans (id, name, house_id)
VALUES
  (1, "Matt", 2),
  (2, "Emily", 2),
  (3, "Rhonda", 1),
  (4, "Steven", 1);

INSERT INTO
  dogs (id, name, breed, owner_id)
VALUES
  (1, "Scooter", "Greyhound", 4),
  (2, "Ginger", "Greyhound", 4),
  (3, "Gabby", "Greyhound", 3),
  (4, "Dusty", "Greyhound", 3),
  (5, "Stella", "German Shepherd", 1),
  (6, "Rex", "Husky", 2),
  (7, "Independent Puppy", "Mixed Breed", NULL);
