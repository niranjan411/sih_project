import '../utils/api_constants.dart'; 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';


import '../widgets/app_header.dart';
import '../widgets/app_footer.dart';
import 'school_approve_pending.dart'; // ✅ Make sure this file exists

class RegisterSchoolScreen extends StatefulWidget {
  final String username; // ✅ Logged-in username

  const RegisterSchoolScreen({super.key, required this.username});

  @override
  State<RegisterSchoolScreen> createState() => _RegisterSchoolScreenState();
}

class _RegisterSchoolScreenState extends State<RegisterSchoolScreen> {
  final _form = GlobalKey<FormState>();

  String schoolName = '';
  String udise = '';
  String address = '';
  String district = '';
  String stateName = '';
  String schoolType = 'Government';
  String principalName = '';
  String principalContact = '';
  String email = '';
  String phone = '';
  String? uploadedPath;
  bool _loading = false;

  /// ✅ Pick document
  Future<void> _pickDocument() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() => uploadedPath = result.files.first.name);
    }
  }

  /// ✅ Submit school details to backend
  Future<void> _submitSchool() async {
    if (!_form.currentState!.validate()) return;
    _form.currentState!.save();

    final url = Uri.parse('https://${ApiConstants.baseUrl}/api/schools/createschool'); // ✅ Your backend endpoint
    setState(() => _loading = true);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'school_name': schoolName,
          'udise': udise,
          'address': address,
          'district': district,
          'state': stateName,
          'school_type': schoolType,
          'principal_name': principalName,
          'principal_contact': principalContact,
          'email': email,
          'phone': phone,
          'document': uploadedPath ?? '',
          'username': widget.username, // ✅ foreign key
          'is_approve': false
        }),
      );

      final data = json.decode(response.body);
      if (data['success'] == true) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('School registration submitted!')),
        );
        // ✅ Redirect to School Approve Pending screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SchoolApprovePendingScreen()),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Registration failed')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: "Register School"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'School name'),
                        validator: (v) => (v == null || v.isEmpty)
                            ? 'Enter school name'
                            : null,
                        onSaved: (v) => schoolName = v!,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'UDISE code'),
                        onSaved: (v) => udise = v ?? '',
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Address'),
                        onSaved: (v) => address = v ?? '',
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(labelText: 'District'),
                              onSaved: (v) => district = v ?? '',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(labelText: 'State'),
                              onSaved: (v) => stateName = v ?? '',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: schoolType,
                        items: ['Government', 'Private', 'Aided']
                            .map((s) =>
                                DropdownMenuItem(value: s, child: Text(s)))
                            .toList(),
                        onChanged: (v) => setState(() => schoolType = v!),
                        decoration: const InputDecoration(labelText: 'School type'),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Principal name'),
                        onSaved: (v) => principalName = v ?? '',
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Principal contact'),
                        onSaved: (v) => principalContact = v ?? '',
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        onSaved: (v) => email = v ?? '',
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Phone'),
                        onSaved: (v) => phone = v ?? '',
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: _pickDocument,
                            child: const Text('Upload Document'),
                          ),
                          const SizedBox(width: 12),
                          if (uploadedPath != null)
                            Flexible(
                              child: Text(
                                uploadedPath!,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _loading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: _submitSchool,
                              child: const Text('Submit'),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            AppFooter(),
          ],
        ),
      ),
    );
  }
}

