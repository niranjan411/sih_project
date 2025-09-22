import SchoolService from "../services/school.services.js";

class SchoolController {
  // ✅ Create school
  async createSchool(req, res) {
    try {
      const schoolData = { ...req.body };
      const school = await SchoolService.createSchool(schoolData);
      res.json({ success: true, data: school });
    } catch (err) {
      res.status(400).json({ success: false, message: err.message });
    }
  }

  // ✅ Get school by username
  async getSchool(req, res) {
    try {
      const { username } = req.params;
      const school = await SchoolService.getSchoolByUsername(username);
      res.json({ success: true, data: school });
    } catch (err) {
      res.status(404).json({ success: false, message: err.message });
    }
  }

  // ✅ Update school
  async updateSchool(req, res) {
    try {
      const { username } = req.params;
      const updateData = req.body;
      const school = await SchoolService.updateSchool(username, updateData);
      res.json({ success: true, data: school });
    } catch (err) {
      res.status(400).json({ success: false, message: err.message });
    }
  }
}

export default new SchoolController();
