import 'dart:developer';
import 'package:employee_manage/controllers/notificationcontroller.dart';
import 'package:employee_manage/utils/utils.dart';
import 'package:employee_manage/views/home/notifications/add_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          IconButton(
              onPressed: () {
                navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
                  builder: (context) => AddNotification(),
                ));
              },
              icon: const Icon(
                Icons.notification_add,
                color:  Color.fromARGB(255, 201, 33, 243),
              ))
        ],
      ),
      body: FutureBuilder(
        future: context.read<NotificationController>().fetchNotifications(),
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
            } else if (snapshot.data == "ok") {
              return Consumer<NotificationController>(
                builder: (context, value, child) => body(context, value),
              );
            } else {
              return Center(
                child: Text(snapshot.data.toString()),
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

  Widget body(context, NotificationController cntr) {
    return cntr.notifications.isEmpty
        ? const Center(
            child: Text("Notifications is empty"),
          )
        : ListView.builder(
            itemCount: cntr.notifications.length,
            itemBuilder: (context, index) {
              var data = cntr.notifications[index];
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
                        children: [
                          const Text(
                            "Date :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                          spaceWidth(4),
                          Text(
                            data.date,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Title :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                          spaceWidth(4),
                          Text(
                            data.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      spaceHeight(2),
                      const Text(
                        "🔔 Message",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                      spaceHeight(2),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          data.message,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      spaceHeight(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              log(data.id);
                              // cntr.deleteNotification(id: data.id);
                              delete(context, data.id);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text(
                                "Delete",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          spaceWidth(5)
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
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
          "Are you sure ,you want to Delete this Notification from ETracker ?",
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
          Consumer<NotificationController>(
            builder: (context, value, child) => TextButton(
              onPressed: value.isDelete
                  ? () {}
                  : () async {
                      var result = await value.deleteNotification(id: id);
                      navigatorKey.currentState!.pop();
                      Fluttertoast.showToast(msg: result['message']);
                    },
              child: value.isDelete
                  ? const CupertinoActivityIndicator(
                      radius: 10,
                      color: Colors.red,
                    )
                  : const Text(
                      "Yes",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Colors.red),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
