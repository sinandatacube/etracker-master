import 'dart:developer';

import 'package:employee_manage/services/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../models/employeeAttendenceModel.dart';

class Attendence extends StatelessWidget {
  const Attendence({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendence"),
      ),
      body: FutureBuilder(
        future: ApiServices().getAllAttendence(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(
                color: Color.fromARGB(255, 201, 33, 243),
                radius: 10,
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == "!200") {
              return const Center(
                child: Text("!200"),
              );
            } else if (snapshot.data == "error") {
              return const Center(
                child: Text("error"),
              );
            } else if (snapshot.data == "noNetwork") {
              return const Center(
                child: Text("no network"),
              );
            } else {
              var res = snapshot.data;
              var attendenceResult = AllEmployeeAttendenceModel.fromJson(res);

              return body(attendenceResult);
            }
          } else {
            return const Center(
              child: CupertinoActivityIndicator(
                color: Color.fromARGB(255, 201, 33, 243),
                radius: 10,
              ),
            );
          }
        },
      ),
    );
  }

  SingleChildScrollView body(AllEmployeeAttendenceModel attendenceResult) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Table(
            textBaseline: TextBaseline.alphabetic,
            columnWidths: const {
              // 0: IntrinsicColumnWidth(),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(1.4),
              // 2: IntrinsicColumnWidth(),
              // 3: IntrinsicColumnWidth(), // i want this one to take the rest available space
            },
            border: TableBorder.all(color: Colors.black),
            children: [
              header(),
              for (int i = 0; i < attendenceResult.data.length; i++)
                TableRow(children: [
                  val(text: attendenceResult.data[i].empCode),
                  val(text: attendenceResult.data[i].name),
                  val(text: attendenceResult.data[i].indate.split(" ")[0]),
                  val(
                      text: attendenceResult.data[i].indate
                          .split(" ")[1]
                          .split(".")[0]),
                  val(
                      text: attendenceResult.data[i].outdate
                          .split(" ")[1]
                          .split(".")[0]),
                  val(
                      text: attendenceResult.data[i].status.toString(),
                      isStatus: true),
                ])
            ],
          )
        ],
      ),
    );
  }

  TableRow header() {
    return const TableRow(children: [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Emp\ncode',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            )),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Name',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Date',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'In',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Out',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Punch status',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ]);
  }

  Text val({required String text, isStatus = false}) {
    return Text(
      isStatus
          ? text == "1"
              ? "In"
              : "Out"
          : text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: isStatus
              ? text == "0"
                  ? Colors.red
                  : Colors.green
              : Colors.black),
    );
  }
}
