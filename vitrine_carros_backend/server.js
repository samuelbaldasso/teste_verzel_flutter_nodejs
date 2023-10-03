const express = require('express');
const Carro = require('./models/carro');

const app = express();
const PORT = 3001;
const {json} = require("body-parser");

app.use(json());

const bcrypt = require('bcryptjs');
const Admin = require('./models/user');

const jwt = require('jsonwebtoken');

const crypto = require("crypto");

const secret = crypto.randomBytes(32).toString('hex');

const cors = require("cors");
const {expressjwt} = require("express-jwt");

app.use(cors());

const authenticateJWT = expressjwt({ secret: secret, algorithms: ["HS256"], });

app.post('/login', async (req, res) => {
    try {
        const { email, senha } = req.body;
        const admin = await Admin.findOne({ where: { email } });
        console.log(admin)

        if (!email || !senha) {
            return res.status(400).json({ error: 'E-mail ou senha não fornecidos.' });
        }

        if (!admin) {
            return res.status(400).json({ error: 'E-mail ou senha incorretos.' });
        }

        const isMatch = await bcrypt.compare(senha, admin.senha);
        if (!isMatch) {
            return res.status(400).json({ error: 'E-mail ou senha incorretos.' });
        }

        const token = jwt.sign({ id: admin.id }, secret, {
            expiresIn: '1h',
            algorithm: "HS256",
        });
        console.log(token);

        res.status(200).json({ token });

    } catch (error) {
        console.error(error.message);
        res.status(500).json({ error: 'Erro interno do servidor.' });
    }
});

app.get('/users', async (req, res) => {
    try {
        const users = await Admin.findAll({
            attributes: ['id', 'nome', 'email', 'imagem_url'] // evite retornar a senha
        });
        res.status(200).json(users);
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ error: 'Erro ao buscar usuários.' });
    }
});

app.post('/register', async (req, res) => {
    try {
        await Admin.create(req.body);
        console.log(req.body);
        res.status(201).json({ message: 'Admin registrado com sucesso!' });
    } catch (error) {
        res.status(500).json({ error: 'Erro ao registrar administrador.' });
    }
});

app.get('/users/:id', async (req, res) => {
    try {
        const user = await Admin.findByPk(req.params.id, {
            attributes: ['id', 'nome', 'email', 'imagem_url'] // evite retornar a senha
        });

        if (!user) {
            return res.status(404).json({ error: 'Usuário não encontrado.' });
        }

        res.status(200).json(user);
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ error: 'Erro ao buscar o usuário.' });
    }
});

app.put('/users/:id', async (req, res) => {
    try {
        const { nome, email, senha, imagem_url } = req.body;
        const user = await Admin.findByPk(req.params.id);

        if (!user) {
            return res.status(404).json({ error: 'Usuário não encontrado.' });
        }

        if (senha && senha.length >= 4 && senha.length <= 50) {
            const salt = await bcrypt.genSalt(10);
            user.senha = await bcrypt.hash(senha, salt);
        } else if (senha) {
            return res.status(400).json({ error: 'Senha deve ter entre 4 e 50 caracteres.' });
        }

        user.nome = nome || user.nome;
        user.email = email || user.email;
        user.imagem_url = imagem_url || user.imagem_url;
        user.senha = senha || user.senha

        await user.save();

        res.status(200).json({ message: 'Usuário atualizado com sucesso!' });
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ error: 'Erro ao atualizar o usuário.' });
    }
});

app.delete('/users/:id', async (req, res) => {
    try {
        const user = await Admin.findByPk(req.params.id);

        if (!user) {
            return res.status(404).json({ error: 'Usuário não encontrado.' });
        }

        await user.destroy();
        res.status(200).json({ message: 'Usuário excluído com sucesso!' });
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ error: 'Erro ao excluir o usuário.' });
    }
});

app.get('/carros', authenticateJWT, async (req, res) => {
    const carros = await Carro.findAll();
    res.status(200).json(carros);
});

app.post('/carros', authenticateJWT, async (req, res) => {
    try {
        const carro = await Carro.create(req.body);
        res.status(201).json(carro);
    } catch (error) {
        res.status(500).json({ error: 'Erro ao criar carro.' });
    }
});

app.get('/carros/:id', authenticateJWT, async (req, res) => {
    const id = req.params.id;
    const carro = await Carro.findByPk(id);
    if (carro) {
        res.status(200).json(carro);
    } else {
        res.status(404).json({ error: 'Carro não encontrado.' });
    }
});

app.put('/carros/:id', authenticateJWT, async (req, res) => {
    const id = req.params.id;
    try {
        const [updated] = await Carro.update(req.body, {
            where: { id: id }
        });
        if (updated) {
            const carroAtualizado = await Carro.findByPk(id);
            res.status(200).json(carroAtualizado);
        } else {
            res.status(404).json({ error: 'Carro não encontrado.' });
        }
    } catch (error) {
        res.status(500).json({ error: 'Erro ao atualizar carro.' });
    }
});

app.delete('/carros/:id', authenticateJWT, async (req, res) => {
    const id = req.params.id;
    try {
        const deleted = await Carro.destroy({
            where: { id: id }
        });
        if (deleted) {
            res.status(204).send("Carro deletado.");
        } else {
            res.status(404).json({ error: 'Carro não encontrado.' });
        }
    } catch (error) {
        res.status(500).json({ error: 'Erro ao excluir carro.' });
    }
});

app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({ error: 'Erro interno do servidor.' });
});

app.use((err, req, res, next) => {
    if (err.name === 'UnauthorizedError') {
        res.status(401).send('Token has expired');
    }
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
