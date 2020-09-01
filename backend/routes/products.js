var express = require('express');
var router = express.Router();

var Product = require("../models/Product");

// Get one product, depending in ID
router.get('/', function(req, res, next) {
  res.send('Getting one product');
});

// Get all products
router.get('/all', function(req, res, next) {
  res.send(Product.all());
});

// Add a product
router.post('/', function(req, res, next) {
  res.send('Adding one product');
});

// Update a product
router.put('/', function(req, res, next) {
  res.send('Updating one product');
});




router.delete('/', function(req, res, next) {
  res.send('Deelting one product');
});

module.exports = router;
