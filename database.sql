DROP TABLE IF EXISTS Animal;
DROP TABLE IF EXISTS Bird;
DROP TABLE IF EXISTS Bug;
DROP TABLE IF EXISTS Insect;
DROP TABLE IF EXISTS Spider;
CREATE TABLE Animal (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    weight REAL NOT NULL,
    legs INTEGER NOT NULL
);
CREATE TABLE Bird (
    id INTEGER PRIMARY KEY,
    animal_id INTEGER NOT NULL UNIQUE,
    nest_type TEXT NOT NULL,
    FOREIGN KEY (animal_id) REFERENCES Animal(id) ON DELETE CASCADE
);
CREATE TABLE Bug (
    id INTEGER PRIMARY KEY,
    animal_id INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (animal_id) REFERENCES Animal(id) ON DELETE CASCADE
);
CREATE TABLE Insect (
    id INTEGER PRIMARY KEY,
    bug_id INTEGER NOT NULL UNIQUE,
    has_wings INTEGER NOT NULL,
    FOREIGN KEY (bug_id) REFERENCES Bug(id) ON DELETE CASCADE
);
CREATE TABLE Spider (
    id INTEGER PRIMARY KEY,
    bug_id INTEGER NOT NULL UNIQUE,
    toxin_type TEXT NOT NULL,
    FOREIGN KEY (bug_id) REFERENCES Bug(id) ON DELETE CASCADE
);
INSERT INTO Animal
VALUES (1, 'Centipede', 0.1, 100),
    (2, 'Millipede', 0.1, 1000),
    (3, 'Black Widow', 0.04, 8),
    (4, 'Wasp', 0.02, 6),
    (5, 'Bald Eagle', 12, 2),
    (6, 'Emperor Penguin', 20, 2),
    (7, 'Bee', 0.018, 6),
    (8, 'Brown Recluse', 0.06, 8),
    (9, 'Sydney Funnel-web', 1.03, 8),
    (10, 'Sand Spider', 0.7, 8),
    (11, 'Peregrine Falcon', 6, 2),
    (12, 'Puffin', 4, 2);
INSERT INTO Bug
VALUES (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 7),
    (6, 8),
    (7, 9),
    (8, 10);
INSERT INTO Insect
VALUES (1, 1, 0),
    (2, 2, 0),
    (3, 4, 1),
    (4, 5, 1);
INSERT INTO Spider
VALUES (1, 3, 'neurotoxin'),
    (2, 6, 'necrotic'),
    (3, 7, 'neurotoxin'),
    (4, 8, 'necrotic');
INSERT INTO Bird
VALUES (1, 5, 'stick'),
    (2, 6, 'rock'),
    (3, 11, 'stick'),
    (4, 12, 'rock');