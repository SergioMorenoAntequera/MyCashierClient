var express = require('express');
var router = express.Router();

var Product = require("../models/Product");

// Get all products
router.get('/all', function(req, res, next) {
  Product.all((result) => {
    res.json(result);
  }); 
}); 

// Add a product
router.post('/create', function(req, res, next) {
  res.send('Adding one product');
});

// Get one product, depending in ID
router.get('/:id', function(req, res, next) {
  res.send('Getting one product');
});

// Update a product, depending in ID
router.put('/:id', function(req, res, next) {
  res.send('Updating one product');
});

// Deleting a product, depending in ID
router.delete('/:id', function(req, res, next) {
  res.send('Deelting one product');
});

module.exports = router;