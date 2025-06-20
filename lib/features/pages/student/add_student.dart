import 'package:flutter/material.dart';

class AddStudentPage extends StatelessWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Name')),
            TextField(decoration: InputDecoration(labelText: 'Email')),
            TextField(decoration: InputDecoration(labelText: 'Phone Number')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to add student
              },
              child: const Text('Add Student'),
            ),
          ],
        ),
      ),
    );
  }
}
