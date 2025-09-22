import { createClient } from "@supabase/supabase-js";
import dotenv from "dotenv";



dotenv.config();

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_KEY;

const supabase = createClient(supabaseUrl, supabaseKey);

const connectDB = async () => {
  try {
    const { data, error } = await supabase.from("users").select("*").limit(1);
    if (error) throw error;
    console.log("✅ Supabase/Postgres Connected...");
  } catch (err) {
    console.error("❌ Supabase Connection Error:", err.message);
    process.exit(1);
  }
};

// Default export
export default connectDB;

// Named export for supabase client
export { supabase };
