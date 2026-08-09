import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/student.dart';

class GradesScreen extends StatefulWidget {
  @override
  _GradesScreenState createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
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
      appBar: AppBar(title: Text('الدرجات')),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (_, i) {
          Student s = Student.fromMap(students[i]);

          return Card(
            child: ListTile(
              title: Text(s.name),
              subtitle: Text("الدرجة: ${s.grade}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 60,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        s.grade = int.tryParse(val) ?? 0;
                        box.putAt(i, s.toMap());
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.attach_money),
                    onPressed: () {
                      s.isPaid = true;
                      box.putAt(i, s.toMap());

                      sendSMS(
                          s.parentPhone,
                          "تم استلام رسوم الطالب ${s.name}.\n𝓜𝓡. 𝒜𝒽𝓂𝑒𝒹 𝒜𝒷𝒅𝒐𝒐");

                      setState(() {});
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}