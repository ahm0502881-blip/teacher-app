import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/student.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final box = Hive.box('studentsBox');

  void sendSMS(String phone, String message) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phone,
      queryParameters: {'body': message},
    );
    await launchUrl(smsUri);
  }

  @override
  Widget build(BuildContext context) {
    List students = box.values.toList();

    return Scaffold(
      appBar: AppBar(title: Text('الحضور')),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (_, i) {
          Student s = Student.fromMap(students[i]);

          return Card(
            child: ListTile(
              title: Text(s.name),
              subtitle: Text(s.isPresent ? "حاضر" : "غائب"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      s.isPresent = true;
                      box.putAt(i, s.toMap());

                      sendSMS(
                          s.parentPhone,
                          "تم حضور الطالب ${s.name} اليوم.\n𝓜𝓡. 𝒜𝒽𝓂𝑒𝒹 𝒜𝒷𝒅𝒐𝒐");

                      setState(() {});
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      s.isPresent = false;
                      box.putAt(i, s.toMap());

                      sendSMS(
                          s.parentPhone,
                          "نحيط علم سيادتكم أن الطالب ${s.name} قد تغيب.\n𝓜𝓡. 𝒜𝒽𝓂𝑒𝒹 𝒜𝒷𝒅𝒐𝒐");

                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}