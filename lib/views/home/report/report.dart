import 'package:employee_manage/utils/utils.dart';
import 'package:employee_manage/views/home/report/attendence_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
          ListTile(
            onTap: () => navigatorKey.currentState!
                .push(MaterialPageRoute(builder: (_) => AttendenceReport())),
            title: const Text(
              "Attendence",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
            ),
          )
        ],
      )),
    );
  }
}
