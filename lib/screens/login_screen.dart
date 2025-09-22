import '../utils/api_constants.dart'; 
import 'package:attendance_app1/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/app_header.dart';
import '../widgets/app_footer.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  String language = 'English';
  bool _loading = false;

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

  Future<void> _loginUser() async {
    final url = Uri.parse('https://${ApiConstants.baseUrl}/api/users/login'); // your backend URL
    setState(() => _loading = true);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      final data = json.decode(response.body);

      if (data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!')),
        );
        // Navigate to dashboard or home screen
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Login failed')),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: "Login",
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
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter username' : null,
                    onSaved: (v) => username = v!.trim(),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (v) => (v == null || v.isEmpty) ? 'Enter password' : null,
                    onSaved: (v) => password = v ?? '',
                  ),
                  SizedBox(height: 16),
                  _loading
                      ? CircularProgressIndicator()
                      : Row(
                          children: [
                            ElevatedButton(
                              child: Text('Login'),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  _loginUser(); // call backend
                                }
                              },
                            ),
                            SizedBox(width: 12),
                            TextButton(
                              child: Text('Register first'),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => SignUpScreen()),
                              ),
                            )
                          ],
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
