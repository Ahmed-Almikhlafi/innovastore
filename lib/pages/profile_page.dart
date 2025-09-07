import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'product_list_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isProfileCreated', true);
      await prefs.setString('userName', _name);
      await prefs.setString('userEmail', _email);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ProductListPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Your Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Welcome! Please enter your details',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
                onSaved: (value) => _name = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your email' : null,
                onSaved: (value) => _email = value!,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Save Profile'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
