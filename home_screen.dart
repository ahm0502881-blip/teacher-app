import 'package:flutter/material.dart';
import 'students_screen.dart';
import 'attendance_screen.dart';
import 'grades_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('𝓜𝓡. 𝒜𝒽𝓂𝑒𝒹 𝒜𝒷𝒅𝒐𝒐'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          ListTile(
            leading: Icon(Icons.people),
            title: Text('الطلاب'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => StudentsScreen())),
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text('الحضور'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => AttendanceScreen())),
          ),
          ListTile(
            leading: Icon(Icons.grade),
            title: Text('الدرجات'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => GradesScreen())),
          ),
        ],
      ),
    );
  }
}