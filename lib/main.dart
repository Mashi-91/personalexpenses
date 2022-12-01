import 'dart:ffi';

import 'package:flutter/material.dart';

import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> tx = [
    // Transaction(DateTime.now().toString(), 'New', 299.9, DateTime.now())
  ];

  void addTransaction(String txtile, double amount) {
    final newTx =
    Transaction(DateTime.now().toString(), txtile, amount, DateTime.now());
    setState(() {
      tx.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            TextEnter(addTransaction),
            Tiles(tx)
          ],
        )
      ),
    );
  }
}

class Tiles extends StatelessWidget {
  var tx;
  Tiles(this.tx);
  get gettx => tx;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: gettx.length,
          itemBuilder: (ctx, index) {
            return ListTile(
              leading: Text(gettx[index].amount),
              title: Text(gettx[index].title),
              subtitle: Text(gettx[index].dateTime.toString()),
            );
          }),
    );
  }
}

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
      ),
      ElevatedButton(onPressed: addNewTxt(_tileController.text, double.parse(_amountController.text)),
          child: Text("Add Transaction")),
    ]
    );
  }
}
