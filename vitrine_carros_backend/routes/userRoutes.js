const express = require('express');
const userController = require('../controllers/userController');

const router = express.Router();

router.get('/users', userController.getAllUsers);
router.put("/users/:id", userController.putUser);
router.get("/users/:id", userController.getUser);
router.delete("/users/:id", userController.deleteUser);

module.exports = router;
