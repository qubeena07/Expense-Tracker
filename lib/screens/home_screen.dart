import 'dart:async';

import 'package:expense_tracker/api%20/google_sheets_api.dart';
import 'package:expense_tracker/screens/3d_screen.dart';
import 'package:expense_tracker/widgets/add_data.dart';
import 'package:expense_tracker/widgets/total_balance_card.dart';
import 'package:expense_tracker/widgets/transcation_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool timeStarted = false;
  void startLoading() {
    timeStarted = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {
          timer.cancel();
        });
      }
    });
  }

  final amountController = TextEditingController();
  final itemController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  void addIntoSpreadSheet() {
    GoogleSheetsApi.insert(
        itemController.text, amountController.text, _isIncome);
    setState(() {
      itemController.clear();
      amountController.clear();
      _isIncome = false;
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    itemController.dispose();

    super.dispose();
  }

  void newTrans() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return AlertDialog(
              title: const Text("ADD TRANSACTION"),
              content: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Expense"),
                          Switch(
                              value: _isIncome,
                              onChanged: (newValue) {
                                setState(() {
                                  _isIncome = newValue;
                                });
                              }),
                          const Text("Income")
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "Amount", hintText: "Enter the amount"),
                        controller: amountController,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                            labelText: "Purpose",
                            hintText: "Purpose of amount"),
                        controller: itemController,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.grey.shade600)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.grey.shade600)),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        addIntoSpreadSheet();

                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: "Transcation added");
                      }
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    if (GoogleSheetsApi.loading == true && timeStarted == false) {
      startLoading();
    }
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TotalBalanceCard(
              balance: (GoogleSheetsApi.calculateIncome() -
                      GoogleSheetsApi.calculateExpense())
                  .toString(),
              incomeBalance: GoogleSheetsApi.calculateIncome().toString(),
              expensesBalance: GoogleSheetsApi.calculateExpense().toString(),
            ),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: GoogleSheetsApi.loading == true
                        ? const Center(
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Colors.blueAccent,
                              ),
                            ),
                          )
                        : GoogleSheetsApi.currentTransccations.isEmpty
                            ? const Center(child: Text("No data founs"))
                            : ListView.builder(
                                itemCount:
                                    GoogleSheetsApi.currentTransccations.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: TranscationWidhget(
                                        incomeExpense: GoogleSheetsApi
                                            .currentTransccations[index][2],
                                        transAmount: GoogleSheetsApi
                                            .currentTransccations[index][1],
                                        transName: GoogleSheetsApi
                                            .currentTransccations[index][0]),
                                  );
                                }))
                // TranscationWidhget(
                //     incomeExpense: "expense",
                //     transAmount: "200",
                //     transName: "Office")
              ],
            )),
            AddData(onTap: newTrans)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ThreeDScreen()),
          );
        },
        child: const Icon(Icons.next_plan),
      ),
    );
  }
}
