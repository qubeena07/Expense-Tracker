import 'package:flutter/material.dart';

class TotalBalanceCard extends StatelessWidget {
  final String balance;
  final String incomeBalance;
  final String expensesBalance;

  const TotalBalanceCard(
      {super.key,
      required this.balance,
      required this.incomeBalance,
      required this.expensesBalance});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[300],
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(4.0, 4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                  const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4.0, -4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                ]),
            width: double.infinity,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "B A L A N C E",
                  style: TextStyle(color: Colors.grey[500], fontSize: 16),
                ),
                Text(
                  'Rs.$balance',
                  style: TextStyle(color: Colors.grey[800], fontSize: 40),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_drop_up,
                            size: 30,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Income"),
                            Text(
                              'Rs.$incomeBalance',
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_drop_down,
                            size: 30,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Expense"),
                            Text('Rs.$expensesBalance')
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
