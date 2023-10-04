const express = require('express');
const carController = require('../controllers/carController');

const router = express.Router();

router.post('/carros', carController.postCarro);
router.put('/carros/:id', carController.putCarro);
router.get("/carros", carController.getAllCarros);
router.get("/carros/:id", carController.getCarro);
router.delete("/carros/:id", carController.deleteCarro);

module.exports = router;
