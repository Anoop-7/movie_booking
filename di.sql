INSERT INTO users(name,password) values('John',(crypt('12345678',gen_salt('bf'))));
INSERT INTO users(name,password) values('Adam',(crypt('12345678',gen_salt('bf'))));



INSERT INTO cities(name) values('Banglore');
INSERT INTO cities(name) values('Hydrabad');
INSERT INTO cities(name) values('Goa');

INSERT INTO theatres(name,city_id) values('Nucleus',1);
INSERT INTO theatres(name,city_id) values('Inox',1);


INSERT INTO screens(name,theatre_id,capacity) values('S1',1,200);
INSERT INTO screens(name,theatre_id,capacity) values('S2',1,150);

INSERT INTO screens(name,theatre_id,capacity) values('S1',2,200);
INSERT INTO screens(name,theatre_id,capacity) values('S2',2,150);

INSERT INTO seats(seat_no,screen_id) values('A1',1);
INSERT INTO seats(seat_no,screen_id) values('A2',1);
INSERT INTO seats(seat_no,screen_id) values('B1',1);
INSERT INTO seats(seat_no,screen_id) values('B2',1);
INSERT INTO seats(seat_no,screen_id) values('C1',1);
INSERT INTO seats(seat_no,screen_id) values('C2',1);
INSERT INTO seats(seat_no,screen_id) values('D1',1);
INSERT INTO seats(seat_no,screen_id) values('D2',1);

INSERT INTO seats(seat_no,screen_id) values('A1',2);
INSERT INTO seats(seat_no,screen_id) values('A2',2);
INSERT INTO seats(seat_no,screen_id) values('B1',2);
INSERT INTO seats(seat_no,screen_id) values('B2',2);
INSERT INTO seats(seat_no,screen_id) values('C1',2);
INSERT INTO seats(seat_no,screen_id) values('C2',2);
INSERT INTO seats(seat_no,screen_id) values('D1',2);
INSERT INTO seats(seat_no,screen_id) values('D2',2);

INSERT INTO seats(seat_no,screen_id) values('A1',3);
INSERT INTO seats(seat_no,screen_id) values('A2',3);
INSERT INTO seats(seat_no,screen_id) values('B1',3);
INSERT INTO seats(seat_no,screen_id) values('B2',3);
INSERT INTO seats(seat_no,screen_id) values('C1',3);
INSERT INTO seats(seat_no,screen_id) values('C2',3);
INSERT INTO seats(seat_no,screen_id) values('D1',3);
INSERT INTO seats(seat_no,screen_id) values('D2',3);

INSERT INTO seats(seat_no,screen_id) values('A1',4);
INSERT INTO seats(seat_no,screen_id) values('A2',4);
INSERT INTO seats(seat_no,screen_id) values('B1',4);
INSERT INTO seats(seat_no,screen_id) values('B2',4);
INSERT INTO seats(seat_no,screen_id) values('C1',4);
INSERT INTO seats(seat_no,screen_id) values('C2',4);
INSERT INTO seats(seat_no,screen_id) values('D1',4);
INSERT INTO seats(seat_no,screen_id) values('D2',4);

INSERT INTO movies(name,duration) values('Avengers', 150);
INSERT INTO movies(name,duration) values('KGF 2', 120);
INSERT INTO movies(name,duration) values('Drishyam 2', 90);
INSERT INTO movies(name,duration) values('Agnipath', 60);

INSERT INTO screenings(start_time,screen_id,movie_id,price) values('2022-06-19 09:15:00',1,7,450);
INSERT INTO screenings(start_time,screen_id,movie_id,price) values('2022-06-19 09:15:00',2,7,450);
INSERT INTO screenings(start_time,screen_id,movie_id,price) values('2022-06-19 13:15:00',1,7,550);
INSERT INTO screenings(start_time,screen_id,movie_id,price) values('2022-06-19 13:15:00',2,7,650);


select SUM(no_of_seats) AS "booked_seats"
from tickets
where screening_id= req.body.screening_id


select th.name, sc.name, scr.start_time, scr.price
from theatres as th, screens as sc, screenings as scr
where scr.movie_id=7 and th.id = sc.theatre_id and sc.id = scr.screen_id;

select date_part('month',t.creation_date) as months, sum(t.no_of_seats*s.price) as summaryProfits from tickets as t,screenings as s where t.status = 'booked' and t.screening_id = s.id and t.creation_date between '2022-04-01'::timestamp and '2022-06-29'::timestamp group by date_part('month',t.creation_date);

