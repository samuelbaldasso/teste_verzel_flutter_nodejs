const { Sequelize, Model, DataTypes } = require('sequelize');
const sequelize = new Sequelize('postgres://postgres:admin@localhost:5432/vitrine_carros');
const bcrypt = require('bcryptjs');

class User extends Model {}

User.init({
    nome: {
        type: DataTypes.STRING,
        allowNull: false,
        validate: {
            notEmpty: true
        }
    },
    email: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true,
        validate: {
            isEmail: true,
            notEmpty: true
        }
    },
    senha: {
        type: DataTypes.STRING,
        allowNull: false,
        validate: {
            notEmpty: true,
            len: [4, 50]
        }
    },
    imagem_url: DataTypes.STRING,
}, {
    sequelize,
    modelName: 'usuarios',
    timestamps: false,
    hooks: {
        beforeCreate: async (user) => {
            const salt = await bcrypt.genSalt(10);
            user.senha = await bcrypt.hash(user.senha, salt);
        }
    }
});

sequelize.authenticate()
    .then(() => {
        console.log('Conexão estabelecida com sucesso.');
        return User.sync();
    })
    .then(() => {
        console.log('Tabela User criada com sucesso.');
    })
    .catch(err => {
        console.error('Erro ao conectar ao banco de dados:', err);
    });


module.exports = User;
