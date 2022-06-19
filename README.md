# movie_booking

>Basic requirements :
- postgres is installed
- nodejs is installed
- install nodemon with global scope

>clone the project
```
git clone https://github.com/Anoop-7/movie_booking.git
```

>move into project directory
```
cd movie_booking
```

>run the following to install all the required node packages
```
npm install
```

> Change user and password in the file db.js ( postgres database config file)

```
    user: "postgres", //update with your user
    password: "12345678", //update with your password
```

> create database with name 'movie_booking'
```
create database movie_booking
```
>use 'movie_booking_20220620.sql' file to restore database from databse dump, give dumpfile path
```
pg_dump -U postgres movie_booking < "path_of_dump_file"
```
>run project server (backend service)
```
npm run devStart
```
>Postman API Collection
>Import Movie Booking.postman_collection.json in postman 
>Authorization is set as Bearer in global scope update for other user roles if necessary

>Use the postman API collection to test API's
- create user
- login
- use token received after login as bearer tokens for API's as token authentication wherever indicated in the postman collection


