import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactsScreen(),
    );
  }
}

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final List<Map<String, String>> _contacts = [];

  void _addContact() {
    final name = _nameController.text;
    final phone = _phoneController.text;

    if (name.isEmpty || phone.isEmpty) {
      // Show a snackbar if validation fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Both fields are required')),
      );
      return;
    }

    setState(() {
      if (_contacts.length < 3) {
        _contacts.add({'name': name, 'phone': phone});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You can only add up to 3 contacts')),
        );
      }
      _nameController.clear();
      _phoneController.clear();
    });
  }

  void _deleteContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addContact,
              child: Text('Add Contact'),

            ),
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_contacts[index]['name']!),
                    subtitle: Text(_contacts[index]['phone']!),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteContact(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
