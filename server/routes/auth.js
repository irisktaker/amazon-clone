const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

// Create Router
const authRouter = express.Router();

// authRouter.get("/auth", (req, res) => {
//     res.json({msg: "Naser"});
// });

// ------- SingUp -------
authRouter.post("/api/singup", async function (req, res) {
  try {
    const { name, email, password } = req.body; // short hand
    // {name: "name", email: "email", password: "password"}

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email is already exist" });
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

// ------- Sing In Route -------
authRouter.post("/api/singin", async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email is not exist!" });
    }

    // compare exact password with that we hashed
    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
    // { ...user
    // -> 'token':  'token_something'
    //    'name':   'Naser',
    //    'email':  'example@gmail.com'
    // }
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    
    const verified = jwt.verify(token, "passwordKey");
    if (!verified) return res.json(false);
    
    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get user data
authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

// this tells that authRouter now is not private and we can access it out side this file
// {export multi as map}
module.exports = authRouter;
