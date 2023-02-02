import 'dart:developer';

import 'package:employee_manage/controllers/attendenceReportcontroller.dart';
import 'package:employee_manage/services/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';

class AttendenceReport extends StatefulWidget {
  AttendenceReport({super.key});

  @override
  State<AttendenceReport> createState() => _AttendenceReportState();
}

class _AttendenceReportState extends State<AttendenceReport> {
  String year = "0";

  String month = "";
  @override
  void initState() {
    super.initState();
    context.read<AttendendceReportController>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Attendence report"),
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Consumer<AttendendceReportController>(
                          builder: (context, value, child) {
                        return TextField(
                          onTap: () async {
                            final selected = await showMonthYearPicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2019),
                              lastDate: DateTime(2023),
                            );
                            if (selected != null) {
                              context
                                  .read<AttendendceReportController>()
                                  .getMonthAndYear(selected);
                            }
                          },
                          textAlign: TextAlign.center,
                          readOnly: true,
                          decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          controller: TextEditingController(
                              text: value.year == ""
                                  ? "Select date"
                                  : "${value.monthName} ${value.year}"),
                        );
                      }),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                        flex: 2,
                        child: ElevatedButton(
                            onPressed: () async {
                              context
                                  .read<AttendendceReportController>()
                                  .onGet();
                            },
                            child: const Icon(Icons.search)))
                  ],
                ),
              ),

              Consumer<AttendendceReportController>(
                  builder: (context, value, child) {
                log(value.data.toString());
                return value.isLoading
                    ? const Expanded(
                        child: Center(
                          child: CupertinoActivityIndicator(
                            color: Color.fromARGB(255, 201, 33, 243),
                            radius: 10,
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        itemCount: value.data.length,
                        itemBuilder: (context, index) {
                          var current = value.data[index];
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              title: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Emp code : ${current.empCode}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "Name : ${current.name}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "Position : ${current.position}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                children: [
                                  Text("work hours : ${current.worktime}"),
                                  Text("over time : ${current.overtime}"),
                                ],
                              ),
                            ),
                          );
                        });
              })

              // Consumer<AttendendceReportController>(
              //     builder: (context, value, child) {
              //   return ListView.builder(
              //       shrinkWrap: true,
              //       padding: const EdgeInsets.symmetric(horizontal: 5),
              //       itemCount: value.data.length,
              //       itemBuilder: (context, index) {
              //         var current = value.data[index];
              //         return ListTile(
              //           title: Text("1"),
              //         );
              //       });
              // })
            ],
          ),
        ));
  }
}

// FutureBuilder(
//           future: ApiServices().getAllAttendenceReport("2023-01"),
//           builder: (context, AsyncSnapshot snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CupertinoActivityIndicator(
//                   color: Color.fromARGB(255, 201, 33, 243),
//                   radius: 10,
//                 ),
//               );
//             } else if (snapshot.connectionState == ConnectionState.done) {
//               if (snapshot.data == "!200") {
//                 return const Center(
//                   child: Text("!200"),
//                 );
//               } else if (snapshot.data == "error") {
//                 return const Center(
//                   child: Text("error"),
//                 );
//               } else if (snapshot.data == "noNetwork") {
//                 return const Center(
//                   child: Text("nonetwork"),
//                 );
//               } else {
//                 log(snapshot.data.toString());
//                 return Container();
//               }
//             } else {
//               return const Center(
//                 child: CupertinoActivityIndicator(
//                   color: Color.fromARGB(255, 201, 33, 243),
//                   radius: 10,
//                 ),
//               );
//             }
//           }),