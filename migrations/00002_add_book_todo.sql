-- +goose Up
-- SQL in this section is executed when the migration is applied.

CREATE TABLE book_todo (
  id         SERIAL,
  book_id    INTEGER     NOT NULL,
  comment    TEXT        NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),

  PRIMARY KEY (id),
  FOREIGN KEY (book_id) REFERENCES book (id)
);


-- +goose Down
-- SQL in this section is executed when the migration is rolled back.

DROP TABLE book_todo;
