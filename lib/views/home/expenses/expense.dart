import 'dart:developer';

import 'package:employee_manage/controllers/expensecontroller.dart';
import 'package:employee_manage/models/expensemodel.dart';
import 'package:employee_manage/services/api/api_services.dart';
import 'package:employee_manage/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  @override
  void initState() {
    context.read<ExpenseController>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiServices().getAllExpensesReport(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(
                color: Color.fromARGB(255, 201, 33, 243),
                radius: 10,
              ),
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
            log(snapshot.data.toString(), name: "snapshot");
            var result = snapshot.data;
            AllExpenses data = AllExpenses.fromJson(result);
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Expenses"),
                ),
                body: buildBody(data));
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(
                color: Color.fromARGB(255, 201, 33, 243),
                radius: 10,
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildBody(AllExpenses data) {
    return data.expense.isEmpty
        ? const Center(
            child: Text(
              "No expenses found",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 3.0),
                    shrinkWrap: true,
                    itemCount: data.expense.length,
                    itemBuilder: (context, index) {
                      var current = data.expense[index];
                      return SizedBox(
                        child: Card(
                            child: ListTile(
                          title: Text(
                            "\nDate : " +
                                current.date.split(" ")[0] +
                                "\n" +
                                "Empcode : " +
                                current.empcode +
                                "\nName : " +
                                current.name +
                                "\n" +
                                current.description,
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          trailing: Column(
                            children: [
                              Text("Rs " + current.amount),
                              const SizedBox(
                                height: 10,
                              ),
                              current.status == "1"
                                  ? Container(
                                      height: 20,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.green,
                                      ),
                                      child: Text(
                                        "Paid",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 25,
                                      width: 100,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            _addExpensePopupField(
                                                context, current.id);
                                          },
                                          child: Text(
                                            "set paid",
                                            style: TextStyle(color: Colors.red),
                                          )),
                                    ),
                            ],
                          ),
                        )),
                      );
                    })
              ],
            ),
          );
  }

  Future<void> _addExpensePopupField(BuildContext context, String id) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Are you sure to set paid',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600, color: Colors.grey.shade700),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () => navigatorKey.currentState!.pop(),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Rubik"),
                  )),
              Consumer<ExpenseController>(builder: (context, value, child) {
                return ElevatedButton(
                    onPressed: () async {
                      var result =
                          await context.read<ExpenseController>().setPaid(id);
                      log(result.toString());
                      if (result["message"] == "updates successfully") {
                        navigatorKey.currentState!.pop();

                        setState(() {});
                        context.read<ExpenseController>().loadingState();
                      }
                    },
                    child: value.isloading
                        ? CupertinoActivityIndicator(
                            color: Color.fromARGB(255, 33, 177, 243),
                            radius: 10,
                          )
                        : const Text(
                            "Ok",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: "Rubik"),
                          ));
              }),
            ],
          );
        });
  }
}
