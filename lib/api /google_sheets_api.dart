import 'dart:developer';

import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  static const _credentails = r'''
 {
  "type": "service_account",
  "project_id": "flutter-gsheets-393109",
  "private_key_id": "ef1c7b3373b92002282613240bcbed2cf4a8bf77",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDko+U90hCrHvB3\nBHqZAkjSxg7BDTH9UWXc2UwL2bBu/lQjg/TLZa2/Mvya6zGTy/RjRif3B2hYQpAw\neIYEFaahyZocD3lh2r86VQD+kdsBsmlkf8QqcOMj66mrO5tARYq/v5pR+xcxaLcn\nwQinNGmcKpA76uKHZcDYL3ps8dEyIXTnCHbqZKUssCzwiGvUuA52eKC1vtr+jD/h\n6oyjsGaHxf9pek4ecezlFbUmgEqpCVwLfJ+RMIACZvruIwFYYYWvlqwIGf2OfXPu\nrzUoEmKW7w/jCtgkwoH+D+U9dYaUd/C89WwFbATEMhHp1Ej1bJ2s8/Vwy0gsbvIu\n0NnZGRePAgMBAAECggEAPwaEzy1ERf9x1sUHzHzKOTu6XnH2OTeCZkYKBew8i+QU\nqnOZ+6VsJxv1cPjrQiwDEoiIxLoog8fZelsGykJzm/54OkrzsUs80mYTL5liLw4Q\nqlDj8LUMj97K9vYn3igtTp0Q+49E/ew5LL6z1W+HuzIqbzHYvu0IIy+3RifEfFYi\nP5PgNt6UrWcw8DbJ4sudcmXaSCxVvLcvQoXKgkBClMfTUKzkyWXod/EOfYaCLO0g\nbyQpfGI1xPaqhGMX94dOrFv4GvbI0Rj1FyrGSqzFiQUmfZa0COHxrrnq+28EMiWB\nvet6DghfQO5Qm1Umx8NJI31BFrzao5fjFJtwrtgwuQKBgQD1gzNxoAb0RISJvtXp\ntaOgfac8pRxJ/u12w7q7p5F+TLeOBXW/Ke9lprUE5OZL5/hLPcdT8FXrkEm2ZIHB\nPROEo+QX9JA2Xcb+4BYD+VCiKphZ0QxkiS0PrH668nAE3W4D25Stv9h0qZeDYxku\nmb3qSwPeeu326PqRO2MH7Hwk+QKBgQDuaDAVkbCWtnKOiN847cQSSaECfEfgHqJD\nzfV5rcgSXdbxM/Kuw5x71qJK4qMMHjaTzOYrEELA1wgVNsXBj5tCeCEhnSE3Rlcg\n6r+hb6v2FyYw08oC5nRp8PxK2/zC9iNJCH//Ot1LvYl3Zc8L62EIYaCrTIh3HTNX\nC7IpNiOqxwKBgDQtNfmn8NJo3WII1J1epO+uxKP20xRGwWDEKCNJcXpOA5SDRIrj\n9qS70SzBGNB49CPJdVs5cIknmQLSSWEwAb3mtssAhsWHGIuCRCuECMbuFoLAEsoq\n/RCfsC865uOhy4e2WtqyMuZYRIL/xJJKyjnIx4G4zmnzCY1j+Z/telTBAoGAc96X\nYCRK2zUZQEUtmJGWtfyrEHYuyLKa0rGLGPRpROPuz5Qb4uyXZWjPv+2eqQkWJYd0\nZoGkr+zStNzGCGkvYILaN2gS+LZrKkhtkpyfyx89JIYKrJYtBkBlnkyE8IyIYbqL\n2xRU8bbQ1QLaOkTQCC7K0/aCbMH4bdn1YSo684kCgYByWSPhTc0VWFYEoYt2b+Ac\nPuNJ46KLE2RuqngR+xWrRIXnOREECPYuUgN8UfcU13OQxaR1Kpf+GOXczxmLqx+p\nY9YS0HRL1jTUA+jWLBDhf7fON7I83/JjitLqb5ixEf8gxSZ2l1I6TRu5oN7saLSA\n37EzRCNy4aBkhrQIqqTmWA==\n-----END PRIVATE KEY-----\n",
  "client_email": "expensetracker@flutter-gsheets-393109.iam.gserviceaccount.com",
  "client_id": "117428627977367133427",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/expensetracker%40flutter-gsheets-393109.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

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
