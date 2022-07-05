const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");

// Create Router
const authRouter = express.Router();  

// authRouter.get("/auth", (req, res) => {
//     res.json({msg: "Naser"});
// });

// SingUp
authRouter.post("/api/singup", async function (req, res) {
  
  try {
    const { name, email, password } = req.body; // short hand
    // {name: "name", email: "email", password: "password"}  
  
    const existingUser = await User.findOne({ email });
  if(existingUser) {
    return res.status(400).json({ msg: "User with same email is already exist" });
  }

  const hashPassword = await bcryptjs.hash(password, 8);

  let user = new User({
    name,
    email,
    password: hashPassword,
  });

  user = await user.save();
  res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }

});

// this tells that authRouter now is not private and we can access it out side this file
// {export multi as map}
module.exports = authRouter;
