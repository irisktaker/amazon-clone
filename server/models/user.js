const mongoose = require("mongoose");

// schema means a structure
const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            }, 
            message: 'Enter a valid email address',
        },
    },
    password: {
        required: true,
        type: String,
        validate: (value) => {
            return value.length > 6;
        },
        message: 'Password is to short',
    },
    address: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: 'user',
    },
    // cart
});

const User = mongoose.model('User', userSchema);
module.exports = User;