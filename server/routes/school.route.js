import express from "express";
import SchoolController from "../controllers/school.controller.js";
import authMiddleware from "../middlewares/auth.middleware.js";


const schoolRouter = express.Router();

// ✅ Protected route to create school
schoolRouter.post("/createschool",  SchoolController.createSchool);

// ✅ Protected route to get school info by username
schoolRouter.get("/:username",  SchoolController.getSchool);
 
export default schoolRouter;