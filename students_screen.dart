import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/student.dart';

class StudentsScreen extends StatefulWidget {
  @override
  _StudentsScreenState createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final box = Hive.box('studentsBox');

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void addStudent() {
    if (nameController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty) return;

    Student s = Student(
      name: nameController.text,
      parentPhone: phoneController.text,
    );

    box.add(s.toMap());

    nameController.clear();
    phoneController.clear();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List students = box.values.toList();

    return Scaffold(
      appBar: AppBar(title: Text('الطلاب')),
      floatingActionButton: FloatingActionButton(
        onPressed: addStudent,
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'اسم الطالب',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: 'رقم ولي الأمر',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          Text("عدد الطلاب: ${students.length}"),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (_, i) {
                Student s = Student.fromMap(students[i]);
                return Card(
                  child: ListTile(
                    title: Text(s.name),
                    subtitle: Text(s.parentPhone),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        box.deleteAt(i);
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}