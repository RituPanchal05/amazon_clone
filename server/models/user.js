const mongoose = require("mongoose");
const { productSchema, Product } = require("./product");

//it is just structure of user
const userSCchema = mongoose.Schema({
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
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      message: "Please enter a valid email address",
    },
  },
  password: {
    required: true,
    type: String,
  },
  address: {
    type: String,
    default: "",
  },
  type: {
    type: String,
  },
  cart: [
    {
      product : productSchema,
      quantity : {
        type : Number,
        required: true, 
      }
    },
  ],
});

//creating model for uerschema
const User = mongoose.model("User", userSCchema);

module.exports = User;
