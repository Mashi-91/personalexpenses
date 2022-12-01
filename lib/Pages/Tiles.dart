import 'package:flutter/material.dart';

import '../model.dart';

class Tiles extends StatelessWidget {
  List<Transaction> tx;
  Tiles(this.tx);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: tx.length,
          itemBuilder: (ctx, index) {
            return ListTile(
              leading: Text(tx[index].amount.toString()),
              title: Text(tx[index].title),
              subtitle: Text(tx[index].dateTime.toString()),
            );
          }),
    );
  }
}