const jwt = require("jsonwebtoken");
const User = require("../models/user");

const admin = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res
        .statuc(401)
        .json({ msg: "You're unauthorized, access denied" });

    const verified = jwt.verify(token, "passwordKey");
    if (!verified)
      return res
        .status(401)
        .json({ msg: "Token verification failed, authorization failed" });

    const user = await User.findById(verified.id);
    if (user.type == "user" || user.type == "seller") {
      return res.status(401).json({ msg: "You are unauthorized" });
    }
    req.user = verified.id;
    req.token = token;
    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

//get products

module.exports = admin;
