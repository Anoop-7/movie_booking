-- Create a new database called 'DatabaseName'
-- CREATE DATABASE movie_booking;

--\c movie_booking --into the movie_booking
CREATE TABLE users(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(255),
    password VARCHAR(255),
    role VARCHAR(100)
);

CREATE TABLE cities(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(255)
);

CREATE TABLE theatres(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(255),
    city_id int  REFERENCES cities(id)
);

CREATE TABLE screens(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(255),
    theatre_id int  REFERENCES theatres(id),
    capacity int
);

CREATE TABLE movies(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(255),
    duration int, --in minutes
);

CREATE TABLE screenings(
    id SERIAL PRIMARY KEY NOT NULL,
    start_time TIMESTAMP,
    screen_id int  REFERENCES screens(id),
    movie_id int  REFERENCES movies(id),
    price int
);

CREATE TABLE tickets(
    id SERIAL PRIMARY KEY NOT NULL,
    creation_date TIMESTAMP,
    user_id int  REFERENCES users(id),
    screening_id int  REFERENCES screenings(id),
    no_of_seats int,
    status VARCHAR(255)
);
