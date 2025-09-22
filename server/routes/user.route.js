import express from "express";
import UserController from "../controllers/user.controller.js";
import authMiddleware from "../middlewares/auth.middleware.js";

const router = express.Router();

// Public Routes
router.post("/signup", (req, res) => UserController.createUser(req, res));
router.post("/login", (req, res) => UserController.loginUser(req, res));
router.post("/refresh", (req, res) => UserController.refreshToken(req, res));


// Protected Route
router.get("/profile", authMiddleware, (req, res) => {
  res.json({
    success: true,
    message: "Welcome to your profile!",
    user: req.user,
  });
});

export default router;
