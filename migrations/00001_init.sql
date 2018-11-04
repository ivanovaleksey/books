-- +goose Up
-- SQL in this section is executed when the migration is applied.

CREATE EXTENSION ltree;

CREATE TABLE location (
  id    SERIAL,
  title TEXT  NOT NULL,
  path  LTREE NOT NULL,

  PRIMARY KEY (id)
);

CREATE INDEX location_path_u_idx
  ON location
  USING gist (path);


CREATE TABLE book (
  id    SERIAL,
  title TEXT NOT NULL,

  PRIMARY KEY (id)
);


CREATE TABLE book_location (
  id          SERIAL,
  book_id     INTEGER NOT NULL,
  location_id INTEGER NOT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (book_id) REFERENCES book (id),
  FOREIGN KEY (location_id) REFERENCES location (id)
);

CREATE UNIQUE INDEX book_location_book_id_u_idx
  ON book_location (book_id);


CREATE TABLE author (
  id         SERIAL,
  first_name TEXT NOT NULL,
  last_name  TEXT NOT NULL,

  PRIMARY KEY (id)
);

CREATE UNIQUE INDEX author_first_name_last_name_u_idx
  ON author (first_name, last_name);


CREATE TABLE writing (
  id    SERIAL,
  title TEXT NOT NULL,

  PRIMARY KEY (id)
);


CREATE TABLE authorship (
  author_id  INTEGER NOT NULL,
  writing_id INTEGER NOT NULL,

  PRIMARY KEY (author_id, writing_id),
  FOREIGN KEY (author_id) REFERENCES author (id),
  FOREIGN KEY (writing_id) REFERENCES writing (id)
);


CREATE TABLE book_writing (
  id         SERIAL,
  book_id    INTEGER NOT NULL,
  writing_id INTEGER NOT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (book_id) REFERENCES book (id),
  FOREIGN KEY (writing_id) REFERENCES writing (id)
);

CREATE UNIQUE INDEX book_writing_book_id_writing_id_u_idx
  ON book_writing (book_id, writing_id);


-- +goose Down
-- SQL in this section is executed when the migration is rolled back.

DROP TABLE book_location;
DROP TABLE book_writing;
DROP TABLE location;
DROP TABLE book;

DROP TABLE authorship;
DROP TABLE author;
DROP TABLE writing;

DROP EXTENSION ltree;
