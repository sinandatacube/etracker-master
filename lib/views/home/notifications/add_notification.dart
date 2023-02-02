import 'package:employee_manage/controllers/notificationcontroller.dart';
import 'package:employee_manage/utils/utils.dart';
import 'package:employee_manage/views/home/notifications/notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddNotification extends StatelessWidget {
  AddNotification({super.key});
  final titleCntr = TextEditingController();
  final messageCntr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context) => const Notifications(),));
          return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Add Notification"),
        ),
        body: body(context),
      ),
    );
  }

  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ListView(
        children: [
          spaceHeight(20),
          fields(cntr: titleCntr, hint: "Enter the title", ic: Icons.inbox),
          // spaceHeight(10),
          // Row(
          //   children: const [
          //     Text(
          //       "Notification",
          //     ),
          //   ],
          // ),
          spaceHeight(10),
          SizedBox(
            height: 200,
            width: sW(context) - 50,
            child: TextFormField(
              maxLines: 10,
              controller: messageCntr,
              // cursorColor: mainclrDark,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                hintText: " write your Notification?",
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
          spaceHeight(20),
         Consumer<NotificationController>(builder: (context, value, child) =>  ElevatedButton(
            onPressed:value.isLoading?(){} : () async {
              if (titleCntr.text.isNotEmpty && messageCntr.text.isNotEmpty) {
                var res = await value
                    .createNotification(
                        title: titleCntr.text.trim(),
                        description: messageCntr.text.trim());
                Fluttertoast.showToast(msg: res['message']);
                messageCntr.text = '';
                titleCntr.text = "";
              } else {
                Fluttertoast.showToast(msg: "All fields are required !!");
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:const Color.fromARGB(255, 201, 33, 243),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child:value.isLoading? const CupertinoActivityIndicator(radius: 10,color: Colors.white,): const Text(
              "Submit",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
      )
        ],
      ),
    );
  }

  SizedBox fields(
      {required TextEditingController cntr,
      required String hint,
      required ic,
      isNumber = false}) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        controller: cntr,
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hintText: hint,
          hintStyle: TextStyle(
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
}
