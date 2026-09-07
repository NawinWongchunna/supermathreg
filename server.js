const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
    console.log(`[${new Date().toISOString()}] Request received`);
    setTimeout(() => {
        res.status(200).json({ message: 'Launched' });
    }, 2000);
});

app.get('/slow', (req, res) => {
    setTimeout(() => {
        res.status(200).json({ message: 'Slow Launched' });
    }, 1000);
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});