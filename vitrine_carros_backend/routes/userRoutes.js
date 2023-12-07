const express = require('express');
const userController = require('../controllers/userController');

const router = express.Router();
/**
 * @swagger
 * /users/users:
 *   get:
 *     summary: Retorna uma lista de todos os usuários registrados
 *     responses:
 *       200:
 *         description: Listagem de usuários bem sucedida
 */
router.get('/users', userController.getAllUsers);
/**
 * @swagger
 * /users/users/:id:
 *   put:
 *     summary: Retorna a atualização de um usuário de acordo com seu identificador numérico
 *     responses:
 *       200:
 *         description: Atualização de usuário bem sucedida
 */
router.put("/users/:id", userController.putUser);
/**
 * @swagger
 * /users/users/:id:
 *   get:
 *     summary: Retorna um usuário pelo seu identificador numérico
 *     responses:
 *       200:
 *         description: Busca de usuário bem sucedida
 */
router.get("/users/:id", userController.getUser);
/**
 * @swagger
 * /users/users/:id:
 *   delete:
 *     summary: Retorna a exclusão de um usuário pelo seu identificador numérico
 *     responses:
 *       200:
 *         description: Exclusão de usuário bem sucedida
 */
router.delete("/users/:id", userController.deleteUser);

module.exports = router;
