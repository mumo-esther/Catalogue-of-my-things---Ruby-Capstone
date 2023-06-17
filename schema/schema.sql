CREATE DATABASE catalog;

CREATE TABLE items (
  id BIGINT PRIMARY KEY,
  genre_id BIGINT NOT NULL,
  author_id BIGINT NOT NULL,
  label_id BIGINT NOT NULL,
  publish_date DATE NOT NULL,
  archived BOOLEAN NOT NULL,
  FOREIGN KEY (genre_id) REFERENCES genres(id),
  FOREIGN KEY (author_id) REFERENCES authors(id),
  FOREIGN KEY (label_id) REFERENCES labels(id)
);

CREATE TABLE music_albums (
  id BIGINT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  item_id BIGINT NOT NULL,
  on_spotify BOOLEAN NOT NULL,
  FOREIGN KEY (item_id) REFERENCES items(id)
);

CREATE TABLE games (
  id BIGINT PRIMARY KEY,
  item_id BIGINT NOT NULL,
  multiplayer BOOLEAN NOT NULL,
  last_played_at DATE NOT NULL,
  FOREIGN KEY (item_id) REFERENCES items(id)
);

-- Create the books table
CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  item_id BIGINT NOT NULL,
  title VARCHAR(255) NOT NULL,
  publisher VARCHAR(255) NOT NULL,
  cover_state VARCHAR(255) NOT NULL
  FOREIGN KEY (item_id) REFERENCES items(id)
);

CREATE TABLE authors (
  id BIGINT PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  item_id BIGINT NOT NULL,
  FOREIGN KEY (item_id) REFERENCES items(id)
);

CREATE TABLE genres (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  item_id BIGINT NOT NULL,
  name VARCHAR(255),
  FOREIGN KEY (item_id) REFERENCES items(id)
);

-- Create the labels table
CREATE TABLE labels (
  id SERIAL PRIMARY KEY,
  item_id BIGINT NOT NULL,
  title VARCHAR(255) NOT NULL,
  color VARCHAR(255) NOT NULL,
  FOREIGN KEY (item_id) REFERENCES items(id)
);