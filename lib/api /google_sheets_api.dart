import 'dart:developer';

import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  static const _credentails = r'''
 add your api credentails here through  google sheets api

  ''';

  static const _spreadsheetId = '1KQ74Z_B9lozk_X5DYK822rtezDpDRQLe4zptGg6dehQ';
  static final _gsheets = GSheets(_credentails);
  static Worksheet? _worksheet;

  //some variable to keep track of

  static int numberOfTransations = 0;
  static List<List<dynamic>> currentTransccations = [];
  static bool loading = true;

  // initialize the spreadsheet
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle("ExpenseTracker");
    countRows();
  }

  //count number of notes
  static Future countRows() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOfTransations + 1)) !=
        '') {
      numberOfTransations++;
    }
    loadTransactions();
  }

  //load existing motes from spreadsheet
  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransations; i++) {
      final String transName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transType =
          await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransccations.length < numberOfTransations) {
        currentTransccations.add([transName, transAmount, transType]);
      }
    }
    print(currentTransccations);
    log(currentTransccations.toString(), name: "current transcations");
    loading = false;
  }

  //insert a transcation into spread sheet
  static Future insert(String name, String amount, bool isIncome) async {
    if (_worksheet == null) return;
    numberOfTransations++;
    currentTransccations
        .add([name, amount, isIncome == true ? 'income' : 'expense']);
    await _worksheet!.values.appendRow([
      name,
      amount,
      isIncome == true ? 'income' : 'expense',
    ]);
  }

  //for total income
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransccations.length; i++) {
      if (currentTransccations[i][2] == 'income') {
        totalIncome += double.parse(currentTransccations[i][1]);
      }
    }
    return totalIncome;
  }

  //for total expense
  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransccations.length; i++) {
      if (currentTransccations[i][2] == 'expense') {
        totalExpense += double.parse(currentTransccations[i][1]);
      }
    }
    return totalExpense;
  }
}
