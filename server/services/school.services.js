import { supabase } from "../config/db.js";

class SchoolService {
  constructor() {
    this.table = "schools";
  }

  // ✅ Create a new school
  async createSchool(schoolData) {
    const { data, error } = await supabase
      .from(this.table)
      .insert([schoolData])
      .select()
      .single(); // returns the inserted row

    if (error) throw new Error(error.message);
    return data;
  }

  // ✅ Get school by username (foreign key)
  async getSchoolByUsername(username) {
    const { data, error } = await supabase
      .from(this.table)
      .select("*")
      .eq("username", username)
      .single();

    if (error) throw new Error(error.message);
    return data;
  }

  // ✅ Update school data by username
  async updateSchool(username, updateData) {
    const { data, error } = await supabase
      .from(this.table)
      .update(updateData)
      .eq("username", username)
      .select()
      .single();

    if (error) throw new Error(error.message);
    return data;
  }

  // Optional: Get all schools pending approval
  async getPendingSchools() {
    const { data, error } = await supabase
      .from(this.table)
      .select("*")
      .eq("is_approve", false);

    if (error) throw new Error(error.message);
    return data;
  }
}

export default new SchoolService();
