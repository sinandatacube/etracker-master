import 'dart:developer';

import 'package:employee_manage/controllers/authcontroller.dart';
import 'package:employee_manage/utils/utils.dart';
import 'package:employee_manage/views/home/attendence/attendence.dart';
import 'package:employee_manage/views/home/employee/add_employee.dart';
import 'package:employee_manage/views/home/employee/employe.dart';
import 'package:employee_manage/views/home/expenses/expense.dart';
import 'package:employee_manage/views/home/leaves/leaves_screen.dart';
import 'package:employee_manage/views/home/notifications/notifications.dart';
import 'package:employee_manage/views/home/report/report.dart';
import 'package:employee_manage/views/home/task/add_task.dart';
import 'package:employee_manage/views/home/task/tasks.dart';
import 'package:employee_manage/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../controllers/homecontroller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map> content = [
    {
      "txt": 'Employees',
      "subtxt": "Add & View employess",
      "clr": Colors.blue,
      "ic": Icons.perm_contact_cal_sharp,
    },
    {
      "txt": 'Task',
      "subtxt": "Assign & View taks",
      "clr": Colors.grey,
      "ic": Icons.task,
    },
    {
      "txt": 'Leaves',
      "subtxt": "Manage leave requests",
      "clr": Colors.green,
      "ic": Icons.leave_bags_at_home,
    },
    {
      "txt": 'Expenses',
      "subtxt": "Employee expenses",
      "clr": Colors.red,
      "ic": Icons.money,
    },
    {
      "txt": 'Attendence',
      "subtxt": "View employees attendence",
      "clr": Colors.amber,
      "ic": Icons.work_history,
    },
    {
      "txt": 'Report',
      "subtxt": "View reports",
      "clr": Colors.red,
      "ic": Icons.person,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          await exit(context);
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: const Text(
              "Admin Panel",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            backgroundColor: Colors.white,
            actions: [
              PopupMenuButton<int>(
                itemBuilder: (context) => [
                  // PopupMenuItem 1
                  PopupMenuItem(
                    value: 1,

                    onTap: () async {
                      await Future.delayed(
                          const Duration(milliseconds: 10),
                          () =>
                              navigatorKey.currentState!.push(MaterialPageRoute(
                                builder: (context) => const Notifications(),
                              )));
                    },
                    // row with 2 children
                    child: Row(
                      children: [
                        const Icon(
                          Icons.notification_add,
                          color: Colors.red,
                        ),
                        spaceWidth(10),
                        const Text("Notification")
                      ],
                    ),
                  ),
                  // PopupMenuItem 1
                  PopupMenuItem(
                    value: 1,
                    onTap: () async {
                      var res = await context.read<AuthController>().logout();
                      res == 1
                          ? navigatorKey.currentState!.pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const SplashScreen(),
                              ),
                              (route) => false)
                          : Fluttertoast.showToast(
                              msg: "some error occurred !");
                    },
                    // row with 2 children
                    child: Row(
                      children: [
                        const Icon(
                          Icons.power_settings_new_rounded,
                          color: Colors.red,
                        ),
                        spaceWidth(10),
                        const Text("Logout")
                      ],
                    ),
                  ),
                ],
                offset: Offset(0, 10),
                color: Colors.white,
                elevation: 2,
                // on selected we show the dialog box
                onSelected: (value) {
                  // // if value 1 show dialog
                  // if (value == 1) {
                  //   _showDialog(context);
                  //   // if value 2 show dialog
                  // } else if (value == 2) {
                  //   _showDialog(context);
                  // }
                },
              ),
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
              child: GridView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                controller: ScrollController(),
                itemCount: content.length,
                padding: const EdgeInsets.only(bottom: 5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // childAspectRatio: 3 / 2,
                  childAspectRatio: 1, //1/2
                  mainAxisExtent: 180,
                  crossAxisSpacing: 10, // 5,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  var current = content[index];
                  //var id = content[index]["id"];//
                  return _buildTile(
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Material(
                                color: index == 0
                                    ? Colors.blue
                                    : index == 1
                                        ? Colors.grey
                                        : index == 2
                                            ? const Color.fromARGB(
                                                255, 91, 231, 95)
                                            : index == 3
                                                ? const Color.fromARGB(
                                                    255, 244, 54, 54)
                                                : index == 5
                                                    ? Colors.grey[200]
                                                    : Colors.amber,
                                shape: const CircleBorder(),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(current['ic'],
                                      color: Colors.white, size: 20.0),
                                )),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 16.0)),
                            Text(current['txt'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0)),
                            Text(
                              current['subtxt'],
                              style: const TextStyle(color: Colors.black45),
                            ),
                          ]),
                    ),
                    onTap: () {
                      log(index.toString());
                      index == 0
                          ? navigatorKey.currentState!.push(MaterialPageRoute(
                              builder: (context) => const AllEmployees(),
                            ))
                          //onPunchClick()
                          : index == 1
                              ? navigatorKey.currentState!
                                  .push(MaterialPageRoute(
                                  builder: (context) => const Tasks(),
                                )) // Navigator.of(context)
                              //.pushNamed(ConfigGlobal.leavesTag)
                              : index == 2
                                  ? navigatorKey.currentState!
                                      .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const LeavesScreen(),
                                    ))
                                  : index == 3
                                      ? navigatorKey.currentState!
                                          .push(MaterialPageRoute(
                                          builder: (context) =>
                                              const Expenses(),
                                        ))
                                      : index == 4
                                          ? navigatorKey.currentState!
                                              .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  const Attendence(),
                                            ))
                                          : navigatorKey.currentState!
                                              .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  const Report(),
                                            ));
                    },
                  );
                },
              )),
        ));
  }

  Widget _buildTile(Widget child, {Function()? onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: const Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }

  Future<dynamic> exit(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Row(
          children: [
            const Text(
              "Exit",
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w600, fontSize: 20),
            ),
            spaceWidth(2),
            const Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
          ],
        ),
        content: const Text(
          "Are you sure ,you want to leave from ETracker ?",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              navigatorKey.currentState!.pop();
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(40, 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                backgroundColor: const Color.fromARGB(255, 201, 33, 243),
                foregroundColor: Colors.white),
            child: const Text(
              "No",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
          TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text(
                "Yes",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.red),
              ))
        ],
      ),
    );
  }
}
