import 'package:employee_manage/utils/utils.dart';
import 'package:employee_manage/views/home/report/attendence_report.dart';
import 'package:flutter/material.dart';

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 80,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                border: Border.all(color: Colors.grey.shade100)),
            child: ListTile(
              onTap: () => navigatorKey.currentState!
                  .push(MaterialPageRoute(builder: (_) => AttendenceReport())),
              leading: Image.asset(
                'assets/images/attendance.png',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              title: const Text(
                "Attendence",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
            ),
          )
        ],
      )),
    );
  }
}
