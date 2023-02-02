import 'dart:io';

import 'package:employee_manage/controllers/employeecontroller.dart';
import 'package:employee_manage/models/employemodel.dart';
import 'package:employee_manage/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeDetails extends StatelessWidget {
  final EmployeeClass data;
  const EmployeeDetails({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    List tabs = ["Tasks", "Attendence", "Over Time"];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee Details"),
      ),
      body: FutureBuilder(
        future:
            context.read<EmployeeController>().fetchTasksEmp(id: data.empCode),
        builder: (context, snapshot) {
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
                child: Text("nonetwork"),
              );
            } else {
              return body(context, tabs);
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

  SingleChildScrollView body(BuildContext context, List<dynamic> tabs) {
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 3,
                surfaceTintColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SizedBox(
                  // height: 400,
                  width: sW(context) - 40,
                  child: Column(
                    children: [
                      spaceHeight(5),
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[200],
                      ),
                      spaceHeight(5),
                      tile(txt: "EmpCode", content: data.empCode),
                      tile(
                          txt: "EmpName",
                          content: data.userName + data.lastName),
                      tile(txt: "Position", content: data.role, isRole: true),
                      tile(txt: "Phone", content: data.number),
                      tile(txt: "Age", content: data.age),
                    ],
                  ),
                ),
              ),
            ],
          ),
          spaceHeight(5),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.grey[100],
            child: Row(
              children: List.generate(
                  tabs.length,
                  (index) => Consumer<EmployeeController>(
                        builder: (context, value, child) => GestureDetector(
                          onTap: () {
                            value.setIndex(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  tabs[index],
                                  style: TextStyle(
                                    fontWeight: value.seletedTabIndex == index
                                        ? FontWeight.bold
                                        : FontWeight.w400,
                                    fontSize: value.seletedTabIndex == index
                                        ? 13
                                        : 12,
                                    color: value.seletedTabIndex == index
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                                spaceHeight(2),
                                Container(
                                  height: 2,
                                  width: 15,
                                  decoration: BoxDecoration(
                                      color: value.seletedTabIndex == index
                                          ? const Color.fromARGB(
                                              255, 135, 238, 104)
                                          : null,
                                      borderRadius: BorderRadius.circular(5)),
                                )
                              ],
                            ),
                          ),
                        ),
                      )).toList(),
            ),
          ),
          spaceHeight(2),
          Consumer<EmployeeController>(
              builder: (context, value, child) => Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                        columnWidths: const {
                          0: IntrinsicColumnWidth(),
                          1: FlexColumnWidth(1.0),
                          2: IntrinsicColumnWidth(),
                          3: IntrinsicColumnWidth(), // i want this one to take the rest available space
                        },
                        border: TableBorder.all(color: Colors.black),
                        children: value.seletedTabIndex == 0
                            ? [
                                header(),
                                for (int i = 0;
                                    i < value.employeeTasks.length;
                                    i++)
                                  TableRow(children: [
                                    val(value.employeeTasks[i].initialDate
                                        .split(" ")[0]),
                                    val("# ${value.employeeTasks[i].task.split(",").join("\n # ")}",
                                        isHead: true),
                                    val(value.employeeTasks[i].deadLine
                                        .split(" ")[0]),
                                    val(
                                        value.employeeTasks[i].status == "0"
                                            ? "Pending"
                                            : "Completed",
                                        isStatus: true,
                                        cl: value.employeeTasks[i].status == "0"
                                            ? "Pending"
                                            : "Completed"),
                                  ])
                              ]
                            : value.seletedTabIndex == 1
                                ? [
                                    header2(),
                                    for (int i = 0;
                                        i < value.employeeAttendence.length;
                                        i++)
                                      TableRow(children: [
                                        // val(value
                                        //     .employeeAttendence[i].empCode),
                                        val(i + 1),
                                        val(value.employeeAttendence[i].indate
                                            .split(" ")[0]),
                                        val(" ${value.employeeAttendence[i].indate.split(" ")[0]}\n${value.employeeAttendence[i].indate.split(" ")[1].split(".")[0]} "),
                                        val(" ${value.employeeAttendence[i].outdate.split(" ")[0]}\n${value.employeeAttendence[i].outdate.split(" ")[1].split(".")[0]} "),

                                        val(
                                            value.employeeAttendence[i]
                                                .inlocation,
                                            isButton: true,
                                            navigate: () => navigateTo(
                                                double.parse(value
                                                    .employeeAttendence[i]
                                                    .inlocation
                                                    .split(",")[0]),
                                                double.parse(value
                                                    .employeeAttendence[i]
                                                    .inlocation
                                                    .split(",")[1]))),
                                        val(
                                            value.employeeAttendence[i]
                                                .outlocation,
                                            isButton: true,
                                            navigate: () => navigateTo(
                                                double.parse(value
                                                    .employeeAttendence[i]
                                                    .outlocation
                                                    .split(",")[0]),
                                                double.parse(value
                                                    .employeeAttendence[i]
                                                    .outlocation
                                                    .split(",")[1]))),
                                        // val(value
                                        //     .employeeAttendence[i].outlocation),
                                      ])
                                  ]
                                : [
                                    header3(),
                                    for (int i = 0;
                                        i < value.employeeAttendence.length;
                                        i++)
                                      TableRow(children: [
                                        // val(value
                                        //     .employeeAttendence[i].empCode),
                                        val(i + 1),
                                        val(value.employeeAttendence[i].indate
                                            .split(" ")[0]),
                                        val(value
                                            .employeeAttendence[i].workhours),
                                        val(value
                                            .employeeAttendence[i].overtime),
                                      ])
                                  ]),
                  ))
        ],
      ),
    );
  }

  InkWell val(txt,
      {isHead = false,
      isStatus = false,
      cl = "",
      isButton = false,
      Function()? navigate = null}) {
    return InkWell(
      onTap: isButton ? navigate : null,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Text(
          txt.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: cl == "Pending"
                  ? Colors.red
                  : cl == "Completed"
                      ? Colors.green
                      : null,
              fontWeight: isHead
                  ? FontWeight.w600
                  : isStatus
                      ? FontWeight.bold
                      : FontWeight.w400,
              fontSize: 12),
        ),
      ),
    );
  }

  TableRow header() {
    return const TableRow(children: [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('SDate',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            )),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Tasks',
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
          'DeadLine',
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
          'Status',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ]);
  }

  TableRow header2() {
    return const TableRow(children: [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Sl no',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            )),
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
          'In\nlocation',
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
          'Out\nlocation',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ]);
  }

  TableRow header3() {
    return const TableRow(children: [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Sl no',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            )),
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
          'Work hours',
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
          'Overtime',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ]);
  }

  Padding tile({required txt, required content, isRole = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  "$txt :",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    content,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: isRole
                            ? const Color.fromARGB(255, 10, 17, 75)
                            : Colors.grey),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  navigateTo(double lat, double lng) async {
    Uri uri;
    if (Platform.isAndroid) {
      // https://www.google.com/maps/search/?api=1&query=$latitude,$longitude
      // uri = Uri.parse("geo:$lat,$lng?z=15");
      uri = Uri.parse(
          "https://www.google.com/maps/search/?api=1&query=$lat,$lng");
    } else {
      uri = Uri.parse("https://maps.apple.com/?q=$lat,$lng");
    }
    // var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }
}
