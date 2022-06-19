-- Create a new database called 'DatabaseName'
-- CREATE DATABASE movie_booking;

--\c movie_booking --into the movie_booking
-- DROP TABLE IF EXISTS users;
-- DROP TABLE IF EXISTS cities;
-- DROP TABLE IF EXISTS theatres;
-- DROP TABLE IF EXISTS screens;
-- DROP TABLE IF EXISTS seats;
-- DROP TABLE IF EXISTS movies;
-- DROP TABLE IF EXISTS screenings;
-- DROP TABLE IF EXISTS tickets;
-- DROP TABLE IF EXISTS show_tickets;


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

CREATE TABLE seats(
    id SERIAL PRIMARY KEY NOT NULL,
    seat_no VARCHAR(100),
    screen_id int  REFERENCES screens(id)
);

CREATE TABLE movies(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(255),
    description VARCHAR(255),
    genre VARCHAR(255),
    duration int, --in minutes
    rating int, -- stars
    language VARCHAR(255)
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
    no_of_seats int
);

CREATE TABLE show_tickets(
    id SERIAL PRIMARY KEY NOT NULL,
    ticket_id int  REFERENCES tickets(id),
    seat_id int  REFERENCES seats(id),
    status VARCHAR(255)
);

select scr.id, scr.capacity,scr.name
from screenings as sc, screens as scr,theatres as t
where sc.id = req.body.screening_id and sc.screen_id=scr.id and scr.theatre_id=t.id;

-- select sc.id, sum(sc.price) as "summaryProfit"
-- from show_tickets as sh ,screenings as sc,tickets as t, seats as se
-- where sh.ticket_id=t.id and se.id=sh.seat_id and sc.id=t.screening_id
-- GROUP BY sc.id;

select SUM(no_of_seats) AS "booked_seats"
from tickets
where screening_id= req.body.screening_id

select ()