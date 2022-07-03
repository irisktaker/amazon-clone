console.log("Hello, World");

// import the package
const express = require('express'); // in dart import 'package:path/name.dart'
const app = express(); // initialize 
const PORT = 3000;

// CREATE API -> GET, PUT, POST, DELETE, UPDATE - CRUD
// GET = CREATE
// http://<youripaddress>/hello-world
// app.get('/hello-world', (req, res) => {
//     // send -> will send a basic format
//     // json -> will send as a json format
//     res.send()
// })

// CREATE API USING NODE.JS with express package
// callback function () => {} || function () {} NOT () {} as in Dart 
// localhost only local // IP: ADDRESS can access with others

app.get('/my-name', (req, res) => {
    res.json('Naser');
});

// listen means basicity it's binds itself with the host we are going to specify and listen for any other connections
app.listen(PORT, "0.0.0.0", () => {
    // console.log("Connected at port " + PORT); in dart ("Connected at port $PORT") 
    console.log(`Connected at port ${PORT}`); // in JS >_-
});
