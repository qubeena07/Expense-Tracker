import 'package:flutter/material.dart';

class TranscationWidhget extends StatelessWidget {
  final String transName;
  final String transAmount;
  final String incomeExpense;
  const TranscationWidhget(
      {super.key,
      required this.incomeExpense,
      required this.transAmount,
      required this.transName});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.grey[200],
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(transName),
            const SizedBox(
              width: 5,
            ),
            Text(
              '${incomeExpense == "expense" ? '- ' : '+'}Rs.$transAmount',
              style: TextStyle(
                  color: incomeExpense == "expense"
                      ? Colors.red
                      : Colors.greenAccent),
            )
          ],
        ),
      ),
    );
  }
}
