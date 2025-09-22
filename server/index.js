import app from "./app.js";   // Import the exported app
import connectDB from "./config/db.js";
import UserModel from "./models/user.model.js";
import dotenv from "dotenv";
dotenv.config();


const PORT = 3000;
connectDB();
// Example route
app.get("/", (req, res) => {
  res.send("Hello World!");
});

console.log(process.env.JWT_SECRET)
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
