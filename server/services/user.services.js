import { supabase } from "../config/db.js";   // ✅ named import
import UserModel from "../models/user.model.js";

class UserService {
  // ✅ Register user
  async createUser(username, full_name, password, role) {
    console.log(role);
    // Check if username already exists
    const { data: existingUser, error: selectError } = await supabase
      .from(UserModel.table)
      .select("*")
      .eq("username", username)
      .single();

    if (existingUser) throw new Error("Username already exists");
    if (selectError && selectError.code !== "PGRST116") throw selectError; // ignore 'no rows' error

    // Hash password
    const hashedPassword = await UserModel.hashPassword(password);

    // Insert new user (⚡ include full_name)
    const { data, error } = await supabase
      .from(UserModel.table)
      .insert([{ username, full_name, password: hashedPassword, role: role || 'school_admin'}])
      .select()
      .single();

    if (error) throw new Error(error.message);

    return data; // { id, username, full_name, password, created_at }
  }

  // ✅ Validate user credentials
  async validateUser(username, password) {
    const { data: user, error } = await supabase
      .from(UserModel.table)
      .select("*")
      .eq("username", username)
      .single();

    if (error || !user) throw new Error("Invalid username or password");

    const isMatch = await UserModel.comparePassword(password, user.password);
    if (!isMatch) throw new Error("Invalid username or password");

    return user;
  }
}

export default new UserService();
