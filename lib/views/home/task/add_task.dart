import 'dart:developer';

import 'package:employee_manage/controllers/homecontroller.dart';
import 'package:employee_manage/utils/utils.dart';
import 'package:employee_manage/views/home/task/tasks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddTask extends StatelessWidget {
  final bool isedit;
  final String id;
  const AddTask({this.id = "", this.isedit = false, super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
          builder: (context) => const Tasks(),
        ));
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Assign task"),
          ),
          body: FutureBuilder(
            future: isedit
                ? Future.delayed(const Duration(seconds: 1))
                : context.read<HomeController>().getEmployees(),
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
                  return body(context, context.read<HomeController>(), isedit);
                }
              } else {
                return const Center(
                  child:  CupertinoActivityIndicator(
            color: Color.fromARGB(255, 201, 33, 243),
            radius: 10,
          ),
                );
              }
            },
          )),
    );
  }

  Widget body(context, HomeController cntr, bool isedit) {
    final taskCntr =
        TextEditingController(text: isedit ? cntr.editTasks : null);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => selectEmployee(context),
              child: Container(
                // alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                height: 40,
                width: sW(context),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Consumer<HomeController>(
                  builder: (context, value, child) => value.employeeName.isEmpty
                      ? const Text(
                          "Select the employee",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        )
                      : Text(
                          value.employeeName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                ),
              ),
            ),
            spaceHeight(20),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text(
                      "EmpCode",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    spaceHeight(2),
                    Container(
                      height: 40,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                          )
                        ],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Consumer<HomeController>(
                        builder: (context, value, child) =>
                            value.employeeCode.isEmpty
                                ? const Text(
                                    "Null",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: Colors.grey),
                                  )
                                : Text(
                                    value.employeeCode,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 11),
                                  ),
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                Column(
                  children: [
                    const Text(
                      "DeadLine",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    spaceHeight(2),
                    GestureDetector(
                      onTap: () async {
                        startDatePicker(context);
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 11),
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                              )
                            ],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: Consumer<HomeController>(
                            builder: (context, value, child) =>
                                value.selectedDate.isEmpty
                                    ? const Text(
                                        "Select Date",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        value.selectedDate,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                            fontSize: 11),
                                      ),
                          )),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
            spaceHeight(10),
            Row(
              children: const [
                Text(
                  "Tasks",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
            spaceHeight(10),
            SizedBox(
              height: 400,
              width: sW(context) - 50,
              child: TextFormField(
                maxLines: 15,
                controller: taskCntr,
                // cursorColor: mainclrDark,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 5),
                  hintText: " write your Task?",
                  // isDense: true,
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    // borderSide: BorderSide(color: Colors.grey[200]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  // focusedBorder: Border
                ),
              ),
            ),
            spaceHeight(10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Consumer<HomeController>(
                  builder: (context, value, child) => ElevatedButton(
                    onPressed: value.isTaskLoading
                        ? () {}
                        : () async {
                            if (isedit) {
                              var res = await value.updateTask(
                                  id: id, cntr: taskCntr.text);
                              switch (res) {
                                case "!200":
                                  Fluttertoast.showToast(
                                      msg: "some error occured !200!!");

                                  break;
                                case "noNetwork":
                                  Fluttertoast.showToast(
                                      msg: "No internet connection!!");

                                  break;
                                case "error":
                                  Fluttertoast.showToast(
                                      msg: "some server error occured!!");

                                  break;
                                case "ok":
                                  Fluttertoast.showToast(
                                      msg: "Task updated successfully");

                                  taskCntr.text = "";
                                  cntr.clearTaskCache();

                                  break;

                                default:
                              }
                            } else {
                              if (taskCntr.text.isNotEmpty) {
                                var res =
                                    await value.addTask(taskCntr.text.trim());
                                switch (res) {
                                  case "emp empty":
                                    Fluttertoast.showToast(
                                        msg: "select employee !!");

                                    break;
                                  case "date empty":
                                    Fluttertoast.showToast(
                                        msg: "select date !!");

                                    break;
                                  case "!200":
                                    Fluttertoast.showToast(
                                        msg: "some error occured !200!!");

                                    break;
                                  case "noNetwork":
                                    Fluttertoast.showToast(
                                        msg: "No internet connection!!");

                                    break;
                                  case "error":
                                    Fluttertoast.showToast(
                                        msg: "some server error occured!!");

                                    break;
                                  case "ok":
                                    Fluttertoast.showToast(
                                        msg: "Task assigned successfully");

                                    taskCntr.text = "";
                                    cntr.clearTaskCache();

                                    break;

                                  default:
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Task is required !!");
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:const Color.fromARGB(255, 201, 33, 243),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: value.isTaskLoading
                        ? const CupertinoActivityIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Submit",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  SizedBox fields(
      {required TextEditingController Cntr,
      required String hint,
      required ic,
      isNumber = false}) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        controller: Cntr,
        keyboardType: isNumber ? TextInputType.number : null,
        validator: (value) {
          if (value!.isEmpty) {
            return "*Required";
          } else {
            return null;
          }
        },
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 2),
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 12,
          ),
          suffixIcon: Icon(
            ic,
            color: Colors.grey,
          ),
          filled: true,
          fillColor: Colors.grey[100],
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Future<dynamic> selectEmployee(BuildContext context) {
    return showModalBottomSheet(
      context: context,

      isScrollControlled: true, // democat.length > 5 ? true : false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => Consumer<HomeController>(
        builder: (context, value, child) => Container(
            height:
                value.employees.isNotEmpty ? sH(context) - 80 : sH(context) / 2,
            padding: const EdgeInsets.all(8),
            child: value.employees.isEmpty
                ? const Center(
                    child: Text("No Employees Found !"),
                  )
                : ListView.builder(
                    itemCount: value.employees.length,
                    itemBuilder: (context, index) {
                      var data = value.employees[index];
                      return ListTile(
                        onTap: () {
                          log(data.toString());
                          value.setEmployee(data);
                          navigatorKey.currentState!.pop();
                        },
                        leading: const Icon(
                          Icons.security_rounded,
                          color: Colors.grey,
                        ),
                        title: Text(data.empCode),
                        subtitle: Text(data.userName),
                      );
                    },
                  )),
      ),
    );
  }

  startDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    log(picked.toString());
    if (picked != null) {
      log(picked.toString());
      context.read<HomeController>().setDate(picked.toString());
    }
  }
}
