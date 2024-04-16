//IMPORTS FROM THIRD PARTY PACKAGES
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

//IMPORTS FROM OTHER FOLDERS
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");

//INT
const app = express();
const PORT = 3000;
//don't give password in any pecial character
const DB =
  "mongodb+srv://ritupancha05:ritu12345@ritupanchal.eirjcyt.mongodb.net/?retryWrites=true&w=majority&appName=ritupanchal";

//MIDDLEWARES
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(cors({ origin: "*" }));

app.use(cors());

//Connecitons
mongoose
  .connect(DB)
  .then(() => {
    console.log("connected");
  })
  .catch((e) => {
    console.log(e);
  });

// const ipAddress = addresses[0];
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server is running on ${PORT}`);
});
