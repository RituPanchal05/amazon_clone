const express = require("express");
const productRouter = express.Router();
const auth = require("../middleware/auth");
const { Product } = require("../models/product");

productRouter.get("/api/products/", auth, async (req, res) => {
  try {
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  try {
    const products = await Product.find({
      name: { $regex: req.params.name, $options: "i" },
    });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

productRouter.post("/api/rate-products", auth, async (req, res) => {
  try {
    const { id, rating } = req.body;
    let product = await Product.findById(id);

    for (let i = 0; i < product.rating.length; i++) {
      if (product.rating[i].userId == req.user) {
        product.rating.splice(i, 1);
        break;
      }
    }

    console.log("added!!");
    const ratingSchema = {
      userId: req.user,
      rating: rating,
    };
    product.rating.push(ratingSchema);
    product.rating = await product.save();
    res.json(product);
  } catch {}
});

productRouter.get("/api/deal-of-day", auth, async (req, res) => {
  try {
    let products = await Product.find({});

    products = products.sort((a, b) => {
      let aSum = 0;
      let bSum = 0;

      for (let i = 0; i < a.rating.length; i++) {
        aSum += a.rating[i].rating;
      }

      for (let i = 0; i < b.rating.length; i++) {
        bSum += b.rating[i].rating;
      }
      return aSum < bSum ? 1 : -1;
    });

    res.json(products[0]);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
