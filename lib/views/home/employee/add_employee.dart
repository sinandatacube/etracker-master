import 'package:employee_manage/utils/utils.dart';
import 'package:employee_manage/views/home/employee/employe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../controllers/homecontroller.dart';

class AddEmployee extends StatelessWidget {
  const AddEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    final name1Cntr = TextEditingController();
    final name2Cntr = TextEditingController();
    final codeCntr = TextEditingController();
    final pswCntr = TextEditingController();
    final ageCntr = TextEditingController();
    final numCntr = TextEditingController();
    final roleCntr = TextEditingController();
    final salaryCntr = TextEditingController();
    final fkey = GlobalKey<FormState>();

    return WillPopScope(
      onWillPop: ()async{
        navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context) => const AllEmployees(),));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Employee"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Form(
              key: fkey,
              child: Column(
                children: [
                  fields(Cntr: name1Cntr, hint: " username", ic: Icons.person),
                  spaceHeight(10),
                  fields(Cntr: name2Cntr, hint: "last name", ic: Icons.person),
                  spaceHeight(10),
                  fields(
                      Cntr: codeCntr, hint: " Empcode", ic: Icons.assignment_ind),
                  spaceHeight(10),
                  fields(Cntr: pswCntr, hint: "password", ic: Icons.key),
                  spaceHeight(10),
                  fields(
                      Cntr: ageCntr,
                      hint: " Age",
                      ic: Icons.child_care,
                      isNumber: true),
                  spaceHeight(10),
                  fields(
                      Cntr: numCntr,
                      hint: "Number",
                      ic: Icons.phone,
                      isNumber: true),
                  spaceHeight(10),
                  fields(Cntr: roleCntr, hint: "Role", ic: Icons.security),
                  spaceHeight(10),
                  fields(Cntr: salaryCntr, hint: "Basic Salary", ic: Icons.monetization_on_outlined,isNumber: true),
    
                  spaceHeight(20),
                  Consumer<HomeController>(
                      builder: (context, value, child) => ElevatedButton(
                          onPressed: value.isLoading
                              ? () {}
                              : () async {
                                if (fkey.currentState!.validate()) {
                                   var res = await value.addEmployee(
                                      name: name1Cntr.text,
                                      age: ageCntr.text,
                                      code: codeCntr.text,
                                      last: name2Cntr.text,
                                      number: numCntr.text,
                                      psw: pswCntr.text,
                                      role: roleCntr.text,
                                      salary: salaryCntr.text,
                                      );
    
                                  if (res['status'] == 'ok') {
                                    name1Cntr.text = '';
                                    name2Cntr.text = '';
                                    ageCntr.text = '';
                                    numCntr.text = '';
                                    codeCntr.text = '';
                                    pswCntr.text = '';
                                    roleCntr.text = '';
                                    salaryCntr.text = "";
    
                                    Fluttertoast.showToast(
                                        msg: "Employee successfully added..");
                                  } else {
                                    Fluttertoast.showToast(msg: res['message']);
                                  }
                                }
                                 
                                },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:const Color.fromARGB(255, 201, 33, 243),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              fixedSize: const Size(100, 20),
                              foregroundColor: Colors.white),
                          child: value.isLoading
                              ? const Center(
                                  child: CupertinoActivityIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text("Submit")))
                ],
              ),
            ),
          ),
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
          
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hintText: hint,
          hintStyle:const TextStyle(
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
