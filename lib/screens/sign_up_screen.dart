import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/app_header.dart';
import '../widgets/app_footer.dart';
import 'register_school_screen.dart'; // import your school registration screen

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  String language = 'English';
  bool _loading = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  
  String? get username => null;

  _openLanguagePicker() async {
    final chosen = await showDialog<String>(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text('Choose language'),
        children: [
          SimpleDialogOption(child: Text('English'), onPressed: () => Navigator.pop(context, 'English')),
          SimpleDialogOption(child: Text('हिन्दी'), onPressed: () => Navigator.pop(context, 'हिन्दी')),
          SimpleDialogOption(child: Text('मराठी'), onPressed: () => Navigator.pop(context, 'मराठी')),
        ],
      ),
    );
    if (chosen != null) setState(() => language = chosen);
  }

  Future<void> _registerUser() async {
    final url = Uri.parse('http://localhost:3000/api/users/signup'); // replace with your backend URL
    setState(() => _loading = true);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': _usernameController.text.trim(),
          'full_name': _fullNameController.text.trim(),
          'password': _passwordController.text,
        }),
      );

      final data = json.decode(response.body);

      if (data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registered successfully!')),
        );
        // Navigate to RegisterSchoolScreen after successful signup
        Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (_) => RegisterSchoolScreen(username: _usernameController.text.trim())),
);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Registration failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _fullNameController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: "Register",
        leading: IconButton(
          icon: Icon(Icons.language),
          onPressed: _openLanguagePicker,
          tooltip: 'Change Language',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Language: $language", style: TextStyle(color: Colors.black54)),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter username' : null,
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(labelText: 'Full Name'),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter full name' : null,
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password (min 6 chars)',
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    obscureText: _obscurePassword,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Enter password';
                      if (v.length < 6) return 'Password must be at least 6 chars';
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _confirmController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirm ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                      ),
                    ),
                    obscureText: _obscureConfirm,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Confirm your password';
                      if (v != _passwordController.text) return 'Passwords do not match';
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  _loading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          child: Text('Register'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _registerUser(); // After signup, goes to RegisterSchoolScreen
                            }
                          },
                        ),
                  SizedBox(height: 12),
                  TextButton(
                    child: Text('Already have an account? Login'),
                    onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                  ),
                ],
              ),
            ),
            Spacer(),
            AppFooter(),
          ],
        ),
      ),
    );
  }
}
