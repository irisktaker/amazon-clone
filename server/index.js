console.log("Hello, World");

// import the package
const express = require("express"); // in dart import 'package:path/name.dart'
const mongoose = require("mongoose");

// import from other files
const authRouter = require("./routes/auth");

// initializations
const app = express();
const PORT = 3000;
const DB = "mongodb+srv://Naser:helloMeJSPythonJ_1.618@cluster0.honjz8j.mongodb.net/?retryWrites=true&w=majority";

// middleware
// CLIENT(Flutter) -> middleware -> SERVER -> CLIENT(Flutter)
app.use(express.json());
app.use(authRouter);

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

// ex: 1 on get request
// app.get('/', (req, res) => {
//     res.json({
//         'key': 'value'
//     });
// });

// ex: 2 on get request
// app.get('/my-name', (req, res) => {
//     res.send('Naser');
// });

// Connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connections Successful");
  })
  .catch((e) => {
    console.log(e);
  });

// listen means basicity it's binds itself with the host we are going to specify and listen for any other connections
app.listen(PORT, "0.0.0.0", () => {
  // console.log("Connected at port " + PORT); in dart ("Connected at port $PORT")
  console.log(`Connected at port ${PORT}`); // in JS >_-
});
