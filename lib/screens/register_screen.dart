import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/app_footer.dart';
import 'package:file_picker/file_picker.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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

  _pickDocument() async {
    // uses file_picker
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() => uploadedPath = result.files.first.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: "Register School"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(decoration: InputDecoration(labelText: 'School name'), validator: (v)=> v==null||v.isEmpty ? 'Enter' : null, onSaved: (v)=>schoolName=v!),
                    TextFormField(decoration: InputDecoration(labelText: 'UDISE code'), onSaved: (v)=>udise=v ?? ''),
                    TextFormField(decoration: InputDecoration(labelText: 'Address'), onSaved: (v)=>address=v ?? ''),
                    Row(children: [
                      Expanded(child: TextFormField(decoration: InputDecoration(labelText: 'District'), onSaved: (v)=>district=v ?? '')),
                      SizedBox(width: 10),
                      Expanded(child: TextFormField(decoration: InputDecoration(labelText: 'State'), onSaved: (v)=>stateName=v ?? '')),
                    ]),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: schoolType,
                      items: ['Government', 'Private', 'Aided']
                          .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                          .toList(),
                      onChanged: (v) => setState(()=>schoolType = v!),
                      decoration: InputDecoration(labelText: 'School type'),
                    ),
                    SizedBox(height: 8),
                    TextFormField(decoration: InputDecoration(labelText: 'Principal name'), onSaved: (v)=>principalName=v ?? ''),
                    TextFormField(decoration: InputDecoration(labelText: 'Principal contact'), onSaved: (v)=>principalContact=v ?? ''),
                    TextFormField(decoration: InputDecoration(labelText: 'Email'), onSaved: (v)=>email=v ?? ''),
                    TextFormField(decoration: InputDecoration(labelText: 'Phone'), onSaved: (v)=>phone=v ?? ''),
                    SizedBox(height: 12),
                    Row(children: [
                      ElevatedButton(onPressed: _pickDocument, child: Text('Upload Document')),
                      SizedBox(width: 12),
                      if (uploadedPath != null) Flexible(child: Text(uploadedPath!, overflow: TextOverflow.ellipsis)),
                    ]),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_form.currentState!.validate()) {
                          _form.currentState!.save();
                          // submit to backend...
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration submitted')));
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AppFooter(),
        ]),
      ),
    );
  }
}
