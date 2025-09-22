import express from "express";
import dotenv from "dotenv";
import cors from "cors";

import userRouter from "./routes/user.route.js";
import  schoolRouter  from "./routes/school.route.js"; // ✅ named import
// ✅ Import school routes

dotenv.config();

// 🔹 Express App
const app = express();

// ✅ Enable CORS for all origins (adjust in production)
app.use(cors({ origin: "*" }));

// ✅ Middleware to parse JSON requests
app.use(express.json());

// 🔹 Mount routes
app.use("/api/users", userRouter);       // User routes
app.use("/api/schools", schoolRouter);   // School routes

// 🔹 Default route (optional)
app.get("/", (req, res) => {
  res.send("Welcome to the School Management API");
});

// 🔹 Export the app
export default app;
