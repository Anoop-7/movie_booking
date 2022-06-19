require('dotenv').config()

const express = require("express");
const jwt = require("jsonwebtoken");
const bcrypt = require('bcrypt')
const app = express();
const pool = require("./db");
const { Sequelize } = require('sequelize');
const sequelize = new Sequelize('movie_booking', 'postgres', '12345678', {
    host: 'localhost',
    dialect: 'postgres'
});



app.listen(3000)
//our app can handle json authentication
app.use(express.json())

function print_now(s){
    console.log(s)
}

const User = sequelize.define(
    "users",
    {
        name: Sequelize.STRING,
        password: Sequelize.STRING,
        role: Sequelize.STRING,
    },
    {
        timestamps: false,
    }
    );

app.get('/users', (req, res) => {
    res.json(users)
})

app.post('/users', async (req, res) => {
    try {
        const hashedPassword = await bcrypt.hash(req.body.password, 10)
        const create_user = await pool.query("INSERT INTO users(name,password,role) values($1,$2,$3) returning *", [req.body.name,hashedPassword,req.body.role]);
        res.status(201).json(create_user)
    } catch(error) {
        console.log(error)
        res.status(500).send()
    }
})

app.post('/users/login', async (req, res) => {
    const user = await User.findOne({
        where: { name:req.body.name},
    });
    if (user == null) {
        return res.status(400).send('Cannot find user')
    }
    try {
        if(await bcrypt.compare(req.body.password,  user.password)) {
        // if(req.body.password == user.password) {
            console.log("DONE");
            const accessToken = jwt.sign(user.name, process.env.ACCESS_TOKEN_SECRET)
            console.log(accessToken)
            res.send({accessToken : accessToken})
        } else {
            res.send({ message: "Incorrect Password!"})
        }
    } catch (error){
        console.log(error);
        res.status(500).json(error)
    }
})
//login auth for users


function authenticateToken(req, res, next) {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
    var is_admin= false;
    if (token == null) return res.sendStatus(401)

    jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, async (err, user) => {
        if (err) return res.sendStatus(403)
        const user_obj = await User.findOne({
            where: { name:user}
        });
        req.user = user_obj
        if (user_obj.role === 'admin')
        {
            is_admin= true;
        };
        req.is_admin = is_admin;
        next()
    })
}

app.get('/all-movies', authenticateToken, async (req, res) => {
    try {
        const all_movies = await pool.query("SELECT * FROM movies");
        res.json(all_movies.rows);
    } catch (error) {
        res.json(error.message);
    }
})

app.post('/show-timings', authenticateToken, async (req, res) => {
    try {
        const screening = await pool.query("select scr.id as id, c.name as city, th.name as theatre_name, sc.name as screen, scr.start_time, scr.price from cities as c, theatres as th, screens as sc, screenings as scr where th.id = sc.theatre_id and sc.id = scr.screen_id and c.id=th.city_id and scr.movie_id = $1 ",[req.body.movie_id]);
        res.json(screening.rows);
    } catch (error) {
        res.json(error.message);
    }
})


app.post('/book-ticket', authenticateToken, async(req, res) =>{
    try {
        const booked_seats = await pool.query("select sum(t.no_of_seats) as no_of_seats from tickets as t where screening_id = $1 and status = $2",[req.body.screening_id,"booked"])
        const capacity = await pool.query("select scr.id, scr.capacity,scr.name from screenings as sc, screens as scr,theatres as t where sc.id = $1 and sc.screen_id=scr.id and scr.theatre_id=t.id;",[req.body.screening_id])
        const available_seats= capacity.rows[0]["capacity"]-booked_seats.rows[0]["no_of_seats"]
        if(available_seats>=req.body.no_of_seats){
            const book_ticket = await pool.query("INSERT INTO tickets(creation_date,user_id,screening_id,no_of_seats,status) values($1,$2,$3,$4,$5) returning *", [req.body.creation_date,req.user.id,req.body.screening_id,req.body.no_of_seats,"booked"]);
            res.json(book_ticket.rows[0]['id']);
        }
        else{
            res.json("Sorry! requested seats not available!")
        }
    } catch (error) {
        res.json(error.message);
    }
})

app.post('/update-booking',authenticateToken, async(req, res) =>{
    try {
        const update_booking = await pool.query("update tickets set status = $1 where id = $2", ["cancelled", req.body.booking_id]);
        res.status(200).json("Tickets cancelled successfully!")
    } catch (error) {
        res.json(error.message);
    }
})

app.post('/add-show-timing',authenticateToken, async(req, res) =>{
    try {
        console.log(req.is_admin)
        if (req.is_admin)
        {
            const add_screenings = await pool.query("INSERT INTO screenings(start_time,screen_id,movie_id,price) values($1,$2,$3,$4) returning *", [req.body.start_time,req.body.screen_id,req.body.movie_id,req.body.price]);
            return res.json({message:"Screening data added successfully", data: add_screenings.rows[0]['id']})
        }
        return res.status(403).json("not authorized!")
    } catch (error) {
        res.json(error.message);
    }
})


