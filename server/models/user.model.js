import bcrypt from "bcryptjs";

// User Model for Supabase PostgreSQL table
const UserModel = {
  table: "users", // Supabase table name

  // Hash password before storing
  hashPassword: async (password) => {
    const salt = await bcrypt.genSalt(10);
    return await bcrypt.hash(password, salt);
  },

  // Compare entered password with stored hash
  comparePassword: async (candidatePassword, hashedPassword) => {
    return bcrypt.compare(candidatePassword, hashedPassword);
  },

  // Table field reference for clarity
  fields: {
    id: "bigserial",          // auto-increment primary key
    username: "text",         // unique
    full_name: "text",        // required
    password: "text",         // hashed password
    role: "user_role",        // ENUM: 'root' | 'school_admin' | 'teacher'
    created_at: "timestamptz" // default NOW()
  }
};

export default UserModel;
