const mongoose = require('mongoose');

const connectDB = async () => {
  try {
    const dbUrl = process.env.MONGO_URL;
    await mongoose.connect(dbUrl);
    console.log(' MongoDB Connected...');
  } catch (err) {
    console.error(' Connection Failed:', err.message);
    process.exit(1); // Dừng app nếu kết nối thất bại
  }
};

module.exports = connectDB;