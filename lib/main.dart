import 'package:flutter/material.dart';
import 'Pages/EnterText.dart';
import 'Pages/Tiles.dart';
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
      debugShowCheckedModeBanner: false,
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

  // Adding Transactions
  void addTransaction(String txtile, double amount) {
    final newTx =
        Transaction(DateTime.now().toString(), txtile, amount, DateTime.now());
    setState(() {
      tx.add(newTx);
    });
  }
  // BottomSheet
  void bottomSheet() {
    showModalBottomSheet(context: context, builder: (index) {
      return TextEnter(addTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [Tiles(tx)],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: bottomSheet,
        child: Icon(Icons.add),
      ),
    );
  }
}
