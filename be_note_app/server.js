const express = require('express');
require('dotenv').config();

const connectDB = require('./src/models/db');
const noteRoutes = require('./src/routes/noteRoutes');

const app = express();
const port = process.env.PORT || 3000;


//  Middleware nhận JSON từ Flutter
app.use(express.json());

//  Connect MongoDB
connectDB();  

//  Routes
app.use('/api/notes', noteRoutes);


app.get('/', (req, res) => {
  res.send('Note API running');
});


app.listen(port, () => {
  console.log(`🚀 Server running on port ${port}`);
});