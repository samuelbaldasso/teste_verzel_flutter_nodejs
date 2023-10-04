const Admin = require("../models/user");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const secret = require("../config/secret");

exports.login = async (req, res) => {
    try {
        const { email, senha } = req.body;
        const admin = await Admin.findOne({ where: { email } });

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

        res.status(200).json({ token });

    } catch (error) {
        console.error(error.message);
        res.status(500).json({ error: 'Erro interno do servidor.' });
    }
};

exports.register = async (req, res) => {
    try {
        await Admin.create(req.body);
        res.status(201).json({ message: 'Admin registrado com sucesso!' });
    } catch (error) {
        res.status(500).json({ error: 'Erro ao registrar administrador.' });
    }
};
