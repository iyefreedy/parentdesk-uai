import 'package:flutter/material.dart';

String getCurrencySymbol(String text) {
  return 'Rp. ${text}';
}

bool isEven(int i) {
  return i % 2 == 0;
}

void alert(String msg, BuildContext context) async {
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Perhatian"),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
  );
}