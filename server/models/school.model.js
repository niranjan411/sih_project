import { supabase } from "../config/db.js";

const SchoolModel = {
  table: "schools",

  fields: {
    id: "bigserial",
    school_name: "text",
    udise: "text",
    address: "text",
    district: "text",
    state: "text",
    school_type: "text",
    principal_name: "text",
    principal_contact: "text",
    email: "text",
    phone: "text",
    document: "text",
    username: "text", // foreign key reference to users(username)
    is_approve: "boolean"   
  }
};

export default SchoolModel;
