import 'package:flutter/material.dart';

class TextEnter extends StatelessWidget {
  Function addNewTxt;
  final _tileController = TextEditingController();
  final _amountController = TextEditingController();

  TextEnter(this.addNewTxt);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
            child: Container(
              height: 200,
                width: 200,
                child: Image.asset("assets/images/expenses.jpg")),
          ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          onChanged: (val) => _tileController.text,
          controller: _tileController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.title_rounded, color: Colors.grey,),
              prefixIconColor: Colors.black,
              filled: true,
              labelStyle: TextStyle(color: Colors.grey),
              labelText: 'Title',
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
          ),
        ),
      ),
      SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
              onChanged: (val) => _amountController.text,
          controller: _amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.attach_money_rounded,
            color: Colors.grey,),
              filled: true,
              fillColor: Colors.white,
              labelText: 'Amount',
              labelStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
          backgroundColor: Colors.redAccent),
            onPressed: () {
              addNewTxt(
                  _tileController.text, double.parse(_amountController.text));
            },
            child: Text(
              "Add Transaction",
              style: TextStyle(color: Colors.white),
            )),
      ),
    ]);
  }
}
