import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/app_footer.dart';
import 'package:file_picker/file_picker.dart'; // optional if you use file picker

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String fullName = '';
  String password = '';
  String language = 'English';

  // NOTE: password min length set to 6 to match your requested requirement.
  // For better security change to >= 8.

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
              child: Column(children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Full name'),
                  validator: (v) => (v==null || v.trim().isEmpty) ? 'Enter full name' : null,
                  onSaved: (v) => fullName = v!.trim(),
                ),
                SizedBox(height: 12),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password (min 6 chars)'),
                  obscureText: true,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter password';
                    if (v.length < 6) return 'Password must be at least 6 chars';
                    return null;
                  },
                  onSaved: (v) => password = v ?? '',
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      child: Text('Login'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Simulate login - in real app call backend
                          Navigator.pushReplacementNamed(context, '/dashboard');
                        }
                      },
                    ),
                    SizedBox(width: 12),
                    TextButton(
                      child: Text('Register first'),
                      onPressed: () => Navigator.pushNamed(context, '/register'),
                    )
                  ],
                ),
              ]),
            ),
            Spacer(),
            AppFooter(),
          ],
        ),
      ),
    );
  }
}
