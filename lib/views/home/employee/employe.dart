import 'package:employee_manage/controllers/homecontroller.dart';
import 'package:employee_manage/utils/utils.dart';
import 'package:employee_manage/views/home/employee/add_employee.dart';
import 'package:employee_manage/views/home/employee/employee_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AllEmployees extends StatelessWidget {
  const AllEmployees({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Employees"),
        actions: [
          IconButton(
            onPressed: () {
              navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
                builder: (context) => const AddEmployee(),
              ));
            },
            icon: const Icon(
              CupertinoIcons.person_badge_plus,
              color: Color.fromARGB(255, 201, 33, 243),
            ),
          ),
          spaceWidth(10)
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     navigatorKey.currentState!.push(MaterialPageRoute(
      //       builder: (context) => const AddEmployee(),
      //     ));
      //   },
      //   backgroundColor: Colors.white,
      //   child: const Icon(
      //     CupertinoIcons.person_badge_plus,
      //     color: Color.fromARGB(255, 135, 238, 104),
      //   ),
      // ),
      body: FutureBuilder(
        future: context.read<HomeController>().getEmployees(),
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
              return Consumer<HomeController>(
                builder: (context, value, child) => body(context, value),
              );
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

  Widget body(context, HomeController cntr) {
    return cntr.employees.isEmpty
        ? const Center(
            child: Text("No Employess Found!"),
          )
        : GridView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .8,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            itemCount: cntr.employees.length,
            itemBuilder: (BuildContext ctx, index) {
              var data = cntr.employees[index];
              return Container(
                height: 200,
                width: 140,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, blurRadius: 1)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // ClipRRect(
                    //   borderRadius: const BorderRadius.only(
                    //       topLeft: Radius.circular(8),
                    //       topRight: Radius.circular(8)),
                    //   child: Image.asset(
                    //    "assets/images/dummylogo/${data['logo']}",
                    //     height: 120,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    spaceHeight(5),

                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[100],
                    ),
                    spaceHeight(10),
                    Row(
                      children: [
                        spaceWidth(10),
                        const Text(
                          "EmpCode: ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 10),
                        ),
                        Text(
                          data.empCode,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    spaceHeight(10),

                    Row(
                      children: [
                        spaceWidth(10),
                        const Text(
                          "EmpName: ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 10),
                        ),
                        Expanded(
                          child: Text(
                            data.userName,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),

                    spaceHeight(10),

                    Row(
                      children: [
                        spaceWidth(10),
                        const Text(
                          "Role: ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 10),
                        ),
                        Container(
                          // height: 20,
                          // width: 50,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 2),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 152, 195, 230),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            data.role,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),

                    const Expanded(child: SizedBox()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            navigatorKey.currentState!.push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    EmployeeDetails(data: data),
                              ),
                            );
                          },
                          child: Container(
                            height: 20,
                            width: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.blue,
                              ),
                            ),
                            child: const Text(
                              "VIEW",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            delete(context, data.id);
                          },
                          child: Container(
                            height: 20,
                            width: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.red,
                              ),
                            ),
                            child: const Text(
                              "DELETE",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Expanded(child: SizedBox()),
                  ],
                ),
              );
            });
  }

  delete(context, id) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Row(
          children: [
            const Text(
              "Delete",
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w600, fontSize: 20),
            ),
            spaceWidth(2),
            const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ],
        ),
        content: const Text(
          "Are you sure ,you want to Delete this Employee from ETracker ?",
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
          Consumer<HomeController>(
            builder: (context, value, child) => TextButton(
                onPressed: value.isDeleteLoading
                    ? () {}
                    : () async {
                        var result = await value.deleteEmployee(id: id);
                        navigatorKey.currentState!.pop();
                        Fluttertoast.showToast(msg: result['message']);
                      },
                child: value.isDeleteLoading
                    ? const CupertinoActivityIndicator(
                        color: Colors.red,
                        radius: 10,
                      )
                    : const Text(
                        "Yes",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.red),
                      )),
          )
        ],
      ),
    );
  }
}
