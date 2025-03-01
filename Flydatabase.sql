
CREATE TABLE Airlines (
    airlineid  VARCHAR(2) PRIMARY KEY,
    name       VARCHAR(255) NOT NULL
);

INSERT INTO Airlines (airlineid, name) VALUES ('DY', 'Norwegian');
INSERT INTO Airlines (airlineid, name) VALUES ('SK', 'SAS');
INSERT INTO Airlines (airlineid, name) VALUES ('WF', 'Widerøe');
