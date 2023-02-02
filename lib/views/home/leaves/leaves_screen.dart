import 'package:employee_manage/controllers/leavecontroller.dart';
import 'package:employee_manage/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LeavesScreen extends StatelessWidget {
  const LeavesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Leaves"),
      ),
      body: FutureBuilder(
        future: context.read<LeaveController>().fetchAllLeaves(),
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
              return Consumer<LeaveController>(
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

  Widget body(context, LeaveController cntr) {
    List tabs = ["New", "Rejected", "Approved"];
    return Column(
      children: [
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: Colors.grey[100],
          child: Row(
            children: List.generate(
              tabs.length,
              (index) => Consumer<LeaveController>(
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
                            fontSize: value.seletedTabIndex == index ? 13 : 12,
                            color: value.seletedTabIndex == index
                                ? Colors
                                    .black // const Color.fromARGB(255, 201, 33, 243)
                                : Colors.grey,
                          ),
                        ),
                        spaceHeight(2),
                        Container(
                          height: 2,
                          width: 15,
                          decoration: BoxDecoration(
                              color: value.seletedTabIndex == index
                                  ? const Color.fromARGB(255, 135, 238, 104)
                                  : null,
                              borderRadius: BorderRadius.circular(5)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ).toList(),
          ),
        ),
        spaceHeight(5),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: cntr.seletedTabIndex == 0
                ? cntr.newleaves.length
                : cntr.seletedTabIndex == 1
                    ? cntr.rejectedleaves.length
                    : cntr.acceptedleaves.length,
            itemBuilder: (context, index) {
              var data = cntr.seletedTabIndex == 0
                  ? cntr.newleaves[index]
                  : cntr.seletedTabIndex == 1
                      ? cntr.rejectedleaves[index]
                      : cntr.acceptedleaves[index];
              return Card(
                elevation: 2,
                surfaceTintColor: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                  // height: 100,
                  width: sW(context),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "EmpId :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 10),
                              ),
                              spaceWidth(4),
                              Text(
                                data.empcode,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "LeaveDate:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 10),
                              ),
                              spaceWidth(4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 3),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 226, 224),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  data.leaveDate,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "EmpName :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                          spaceWidth(4),
                          Text(
                            data.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      spaceHeight(2),
                      const Text(
                        "-- Reason ?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                      spaceHeight(2),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          data.reason,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      spaceHeight(10),
                      data.status == "0"
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    var result = await cntr.updateLeave(
                                        id: data.id, status: 1, datas: data);
                                    if (result == "ok") {
                                      Fluttertoast.showToast(
                                          msg: "Leave Approved !!");
                                    } else {
                                      Fluttertoast.showToast(msg: result);
                                    }
                                  },
                                  child: const Text(
                                    "Approve",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    var result = await cntr.updateLeave(
                                        id: data.id, status: -1, datas: data);
                                    if (result == "ok") {
                                      Fluttertoast.showToast(
                                          msg: "Leave Approved !!");
                                    } else {
                                      Fluttertoast.showToast(msg: result);
                                    }
                                  },
                                  child: const Text(
                                    "Reject",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            )
                          : data.status == "-1"
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 2),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: const Text(
                                        "Rejected",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 2),
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: const Text(
                                        "Approved",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
