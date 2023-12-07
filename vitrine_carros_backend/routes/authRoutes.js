const express = require('express');
const authController = require('../controllers/authController');

const router = express.Router();
/**
 * @swagger
 * /auth/login:
 *   post:
 *     summary: Retorna a autenticação de um usuário já registrado
 *     responses:
 *       200:
 *         description: Autenticação de usuário bem sucedida
 */
router.post('/login', authController.login);
/**
 * @swagger
 * /auth/register:
 *   post:
 *     summary: Retorna o registro de um novo usuário
 *     responses:
 *       200:
 *         description: Registro de usuário bem sucedido
 */
router.post('/register', authController.register);

module.exports = router;
