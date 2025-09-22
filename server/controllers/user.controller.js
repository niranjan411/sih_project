import UserService from "../services/user.services.js";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

class UserController {
  // ✅ Register User
  async createUser(req, res) {
    try {
      const { username, full_name, password, role} = req.body; // 👈 NEW
      if (!username || !full_name || !password) {
        return res
          .status(400)
          .json({ success: false, message: "Username, full_name and password are required" });
      }

      const user = await UserService.createUser(username, full_name, password, role);

      res.status(201).json({
        success: true,
        message: "User registered successfully",
        data: { id: user.id, username: user.username },
      });
    } catch (error) {
      res.status(400).json({ success: false, message: error.message });
    }
  }

  // ✅ Login User
  async loginUser(req, res) {
    try {
      const { username, password } = req.body; // 👈 NEW
      if (!username || !password) {
        return res
          .status(400)
          .json({ success: false, message: "Username and password are required" });
      }

      const user = await UserService.validateUser(username, password);

      // Generate Access Token
      const accessToken = jwt.sign(
        { id: user.id, username: user.username },
        process.env.JWT_SECRET,
        { expiresIn: process.env.JWT_EXPIRES_IN || "15m" }
      );

      // Generate Refresh Token
      const refreshToken = jwt.sign(
        { id: user.id, username: user.username },
        process.env.REFRESH_SECRET,
        { expiresIn: process.env.REFRESH_EXPIRES_IN || "7d" }
      );

      res.json({
        success: true,
        message: "Login successful",
        accessToken,
        refreshToken,
      });
    } catch (error) {
      res.status(401).json({ success: false, message: error.message });
    }
  }

  // ✅ Refresh Access Token
  async refreshToken(req, res) {
    try {
      const { token } = req.body;
      if (!token)
        return res.status(401).json({ success: false, message: "Refresh token required" });

      jwt.verify(token, process.env.REFRESH_SECRET, (err, user) => {
        if (err)
          return res.status(403).json({ success: false, message: "Invalid refresh token" });

        const newAccessToken = jwt.sign(
          { id: user.id, username: user.username },
          process.env.JWT_SECRET,
          { expiresIn: process.env.JWT_EXPIRES_IN || "15m" }
        );

        res.json({ success: true, accessToken: newAccessToken });
      });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  }
}

export default new UserController();
