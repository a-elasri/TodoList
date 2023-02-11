const express = require('express');
const taskRouter= require('./routes/taskRoutes');
const app = express();

app.use(express.json());

app.use('/api/v1/tasks',taskRouter);


module.exports= app;
