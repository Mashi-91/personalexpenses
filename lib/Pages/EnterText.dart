import 'package:flutter/material.dart';

class TextEnter extends StatelessWidget {
  Function addNewTxt;
  final _tileController = TextEditingController();
  final _amountController = TextEditingController();

  TextEnter(this.addNewTxt);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        controller: _tileController,

      ),
      TextField(
        controller: _amountController,
        keyboardType: TextInputType.number,
      ),
      ElevatedButton(onPressed: () {
        addNewTxt(_tileController.text, double.parse(_amountController.text));
      },
          child: Text("Add Transaction")),
    ]
    );
  }
}