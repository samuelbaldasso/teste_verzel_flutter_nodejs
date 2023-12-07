const express = require('express');
const carController = require('../controllers/carController');

const router = express.Router();
/**
 * @swagger
 * /carros/carros:
 *   post:
 *     summary: Retorna a criação de um novo item de carro
 *     responses:
 *       200:
 *         description: Criação de carro bem sucedida
 */
router.post('/carros', carController.postCarro);
/**
 * @swagger
 * /carros/carros/:id:
 *   put:
 *     summary: Retorna a atualização de um item de carro pelo seu identificador numérico
 *     responses:
 *       200:
 *         description: Atualização de carro bem sucedida
 */
router.put('/carros/:id', carController.putCarro);
/**
 * @swagger
 * /carros/carros:
 *   get:
 *     summary: Retorna uma lista de todos os carros registrados
 *     responses:
 *       200:
 *         description: Listagem de carros bem sucedida
 */
router.get("/carros", carController.getAllCarros);
/**
 * @swagger
 * /carros/carros/:id:
 *   get:
 *     summary: Retorna um item de carro pelo seu identificador numérico
 *     responses:
 *       200:
 *         description: Busca de carro bem sucedida
 */
router.get("/carros/:id", carController.getCarro);
/**
 * @swagger
 * /carros/carros/:id:
 *   delete:
 *     summary: Retorna a exclusão de um item de carro pelo seu identificador numérico
 *     responses:
 *       200:
 *         description: Exclusão de carro bem sucedida
 */
router.delete("/carros/:id", carController.deleteCarro);

module.exports = router;
