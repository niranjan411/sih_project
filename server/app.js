import express from "express";
//import bodyParser from "body-parser"; // correct casing
import userRouter from "./routes/user.route.js";
import dotenv from "dotenv";
import cors from "cors";

dotenv.config();
// 🔹 Express App
const app = express();
app.use(cors({ origin: "*" }));
// Middleware to parse JSON
//app.use(bodyParser.json()); // ✅ need to call the function
app.use(express.json());    // optional if you already use bodyParser.json()

// Mount the user routes at /api/users
app.use("/api/users", userRouter);

// 🔹 Export the app
export default app;
