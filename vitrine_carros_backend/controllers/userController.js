const Admin = require("../models/user");
const bcrypt = require("bcryptjs");

exports.getAllUsers = async (req, res) => {
    try {
        const users = await Admin.findAll({
            attributes: ['id', 'nome', 'email', 'imagem_url'] // evite retornar a senha
        });
        res.status(200).json(users);
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ error: 'Erro ao buscar usuários.' });
    }
};

exports.getUser = async (req, res) => {
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
};

exports.putUser = async (req, res) => {
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
};

exports.deleteUser = async (req, res) => {
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
};
