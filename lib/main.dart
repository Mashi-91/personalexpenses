import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Pages/Chart.dart';
import 'Pages/EnterText.dart';
import 'Pages/Tiles.dart';
import 'model.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? const CupertinoApp(
            debugShowCheckedModeBanner: false,
            title: 'Expenses',
            theme: CupertinoThemeData(
              primaryColor: Colors.amber,
            ),
            // darkTheme: ThemeData(
            //   brightness: Brightness.dark
            // ),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Expenses',
            theme: ThemeData(
              primarySwatch: Colors.amber,
            ),
            // darkTheme: ThemeData(
            //   brightness: Brightness.dark
            // ),
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

  List<Transaction> get _recentTransaction {
    return tx.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  // Adding Transactions
  void addTransaction(String txtile, double amount, DateTime chooseDate) {
    final newTx =
        Transaction(DateTime.now().toString(), txtile, amount, chooseDate);
    setState(() {
      tx.add(newTx);
    });
  }

  void removetx(int index) {
    setState(() {
      tx.removeAt(index);
    });
  }

  // BottomSheet
  void bottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Color(0xFFFFCF53),
        context: context,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: TextEnter(addTransaction),
          );
        });
  }

  bool _showGraph = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: bottomSheet,
                )
              ],
            ),
          )
        : AppBar(
            centerTitle: true,
            title: Text('Expenses'),
            elevation: 0,
            actions: [
              Platform.isAndroid
                  ? Container()
                  : IconButton(onPressed: bottomSheet, icon: Icon(Icons.add))
            ],
          );
    final tiles = SizedBox(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: Tiles(removetx, tx));
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ShowChart',
                    style: TextStyle(fontSize: 20),
                  ),
                  Switch.adaptive(
                    activeColor: Theme.of(context).primaryColor,
                    value: _showGraph,
                    onChanged: (val) {
                      setState(() {
                        _showGraph = val;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
                  child: Chart(_recentTransaction)),
            if (!isLandscape) tiles,
            if (isLandscape)
              _showGraph
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransaction))
                  : tiles
          ],
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: appBar,
      body: Platform.isIOS
          ? CupertinoPageScaffold(
              child: pageBody,
              navigationBar: appBar,
            )
          : pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              onPressed: bottomSheet,
              child: Icon(Icons.add),
            ),
    );
  }
}
