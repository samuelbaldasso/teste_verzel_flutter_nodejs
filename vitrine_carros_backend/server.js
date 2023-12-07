const express = require('express');

const app = express();
const PORT = 3001;

app.use(express.json());

const cors = require("cors");
app.use(cors());

const {expressjwt} = require("express-jwt");

const secret = require("./config/secret");

const authenticateJWT = expressjwt({secret: secret, algorithms: ["HS256"],});

const swaggerUi = require('swagger-ui-express');
const swaggerDocument = require('./controllers/apiDocController');

const authRoutes = require('./routes/authRoutes');
const userRoutes = require("./routes/userRoutes");
const carRoutes = require("./routes/carRoutes");


app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));
app.use('/auth', authRoutes);
app.use('/users', userRoutes);
app.use("/carros", authenticateJWT, carRoutes);

app.use((err, req, res, next) => {
    if (err.name === 'UnauthorizedError') {
        if (err.message === "jwt expired") {
            return res.status(401).send('Token has expired');
        } else {
            return res.status(401).send('Unauthorized: ' + err.message);
        }
    }
    next(err);
});

app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({error: 'Erro interno do servidor.'});
});
app.listen(PORT, () => {
    console.log(`Servidor rodando em http://localhost:${PORT}`);
});
