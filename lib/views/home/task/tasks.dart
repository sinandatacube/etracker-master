import 'package:employee_manage/controllers/homecontroller.dart';
import 'package:employee_manage/utils/utils.dart';
import 'package:employee_manage/views/home/task/add_task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
            builder: (context) => const AddTask(),
          ));
        },
        backgroundColor: const Color.fromARGB(255, 201, 33, 243),
        child: const Icon(
          Icons.add_task,
          // color: Colors.black,
        ),
      ),
      body: FutureBuilder(
        future: context.read<HomeController>().getTasks(),
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
    return cntr.tasks.isEmpty
        ? const Center(
            child: Text("No Tasks Assigned"),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: cntr.tasks.length,
            itemBuilder: (context, index) {
              var data = cntr.tasks[index];
              return Container(
                // height: 200,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, blurRadius: 1)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceHeight(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            spaceWidth(10),
                            const Text(
                              "EmpCode: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                            Text(
                              data.empCode,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              // height: 20,
                              // width: 50,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              decoration: BoxDecoration(
                                  color: data.status == '1'
                                      ? Colors.green
                                      : Colors.red,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                data.status == "1" ? "Completed" : "Pending",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10),
                              ),
                            ),
                            spaceWidth(10)
                          ],
                        ),
                      ],
                    ),
                    spaceHeight(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            spaceWidth(10),
                            const Text(
                              "EmpName: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                            Text(
                              data.name,
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
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.bell,
                              size: 20,
                            ),
                            spaceWidth(5),
                            Text(
                              data.deadLine,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  // color: Color.fromARGB(255, 201, 33, 243),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            spaceWidth(10)
                          ],
                        )
                      ],
                    ),
                    spaceHeight(10),
                    Row(
                      children: [
                        spaceWidth(10),
                        const Icon(
                          CupertinoIcons.hourglass_bottomhalf_fill,
                          size: 20,
                          color: Colors.grey,
                        ),
                        const Text(
                          "Tasks",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                      ],
                    ),
                    spaceHeight(5),
                    Padding(
                      padding: const EdgeInsets.only(left: 23),
                      child: Column(
                        children: List.generate(
                            data.task.split(",").length,
                            (index) =>
                                Text("📝 ${data.task.split(",")[index]}")),
                      ),
                    ),
                    spaceHeight(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () => delete(context, data.id),
                            style:
                                TextButton.styleFrom(padding: EdgeInsets.zero),
                            child: const Text(
                              "Delete",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            )),
                        TextButton(
                          onPressed: () {
                            context.read<HomeController>().editTask(data);
                            navigatorKey.currentState!.push(MaterialPageRoute(
                              builder: (context) =>
                                  AddTask(isedit: true, id: data.id),
                            ));
                          },
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: const Text(
                            "Edit",
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          );

    // GridView.builder(
    //     physics: const BouncingScrollPhysics(),
    //     shrinkWrap: true,
    //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    //         maxCrossAxisExtent: 200,
    //         mainAxisExtent: 200,
    //         // maxCrossAxisExtent: 300,

    //         // mainAxisExtent: 200,
    //         crossAxisSpacing: 5,
    //         mainAxisSpacing: 5),
    //     itemCount: cntr.tasks.length,
    //     itemBuilder: (BuildContext ctx, index) {
    //       var data = cntr.tasks[index];
    //       return Container(
    //         height: 200,
    //         width: 140,
    //         padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    //         margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
    //         decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(8),
    //             boxShadow: const [
    //               BoxShadow(color: Colors.grey, blurRadius: 1)
    //             ]),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             // ClipRRect(
    //             //   borderRadius: const BorderRadius.only(
    //             //       topLeft: Radius.circular(8),
    //             //       topRight: Radius.circular(8)),
    //             //   child: Image.asset(
    //             //    "assets/images/dummylogo/${data['logo']}",
    //             //     height: 120,
    //             //     fit: BoxFit.cover,
    //             //   ),
    //             // ),
    //             spaceHeight(5),

    //             CircleAvatar(
    //               radius: 30,
    //               backgroundColor: Colors.grey[100],
    //             ),
    //             spaceHeight(10),
    // Row(
    //   children: [
    //     spaceWidth(10),
    //     const Text(
    //       "EmpCode: ",
    //       style: TextStyle(
    //           color: Colors.black,
    //           fontWeight: FontWeight.w500,
    //           fontSize: 10),
    //     ),
    //     Text(
    //       data.empCode,
    //       maxLines: 2,
    //       textAlign: TextAlign.center,
    //       overflow: TextOverflow.ellipsis,
    //       style: const TextStyle(
    //           color: Colors.grey,
    //           fontWeight: FontWeight.bold,
    //           fontSize: 12),
    //     ),
    //   ],
    // ),

    //             Row(
    //               children: [
    //                 spaceWidth(10),
    //                 const Text(
    //                   "EmpName: ",
    //                   style: TextStyle(
    //                       color: Colors.black,
    //                       fontWeight: FontWeight.w500,
    //                       fontSize: 10),
    //                 ),
    //                 Text(
    //                   data.name,
    //                   maxLines: 2,
    //                   textAlign: TextAlign.center,
    //                   overflow: TextOverflow.ellipsis,
    //                   style: const TextStyle(
    //                       color: Colors.grey,
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 12),
    //                 ),
    //               ],
    //             ),
    //             spaceHeight(10),

    //             Row(
    //               children: [
    //                 spaceWidth(10),
    //                 const Text(
    //                   "Status: ",
    //                   style: TextStyle(
    //                       color: Colors.black,
    //                       fontWeight: FontWeight.w500,
    //                       fontSize: 10),
    //                 ),
    // Container(
    //   // height: 20,
    //   // width: 50,
    //   padding: const EdgeInsets.symmetric(
    //       horizontal: 2, vertical: 2),
    //   decoration: BoxDecoration(
    //       color: data.status == '1' ? Colors.green : Colors.red,
    //       borderRadius: BorderRadius.circular(5)),
    //   child: Text(
    //     data.status == "1" ? "Completed" : "Pending",
    //     style: const TextStyle(
    //         color: Colors.white,
    //         fontWeight: FontWeight.bold,
    //         fontSize: 10),
    //   ),
    //                 )
    //               ],
    //             ),

    //             const Expanded(child: SizedBox()),
    //             Container(
    //               height: 20,
    //               width: 50,
    //               alignment: Alignment.center,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(5),
    //                 border: Border.all(
    //                   color: Colors.blue,
    //                 ),
    //               ),
    //               child: const Text(
    //                 "VIEW",
    //                 style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 10,
    //                     color: Colors.blue),
    //               ),
    //             ),
    //             const Expanded(child: SizedBox()),
    //           ],
    //         ),
    //       );
    //     });
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
          "Are you sure ,you want to Delete this from Tasks ?",
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
                          var res = await value.deleteTask(id: id);
                          navigatorKey.currentState!.pop();
                          Fluttertoast.showToast(msg: res['message']);
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
                        )))
        ],
      ),
    );
  }
}
