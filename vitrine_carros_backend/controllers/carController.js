const Carro = require("../models/carro");

exports.getAllCarros = async (req, res, next) => {
    try {
            const carros = await Carro.findAll();
            res.status(200).json(carros);
    } catch (err) {
            next(err);
    }
};

exports.postCarro = async (req, res, next) => {
    try {
            const carro = await Carro.create(req.body);
            res.status(201).json(carro);
    }
    catch (err) {
            next(err);
    }
};

exports.getCarro = async (req, res, next) => {
    try {
            const id = req.params.id;
            const carro = await Carro.findByPk(id);
            if (carro) {
                res.status(200).json(carro);

    }}
    catch (err) {
            next(err);
    }
};

exports.putCarro = async (req, res, next) => {
    try {
            const id = req.params.id;
                const [updated] = await Carro.update(req.body, {
                    where: { id: id }
                });
                if (updated) {
                    const carroAtualizado = await Carro.findByPk(id);
                    res.status(200).json(carroAtualizado);
                } else {
                    res.status(404).json({error: 'Carro não encontrado.'});
                }}
    catch (err) {
                next(err);
    }};

exports.deleteCarro = async (req, res, next) => {
    try {
                const id = req.params.id;
                const deleted = await Carro.destroy({
                    where: { id: id }
                });
                if (deleted) {
                    res.status(204).send("Carro deletado.");
                } else {
                    res.status(404).json({ error: 'Carro não encontrado.' });
                }
        }
    catch (err) {
                next(err);
    }};