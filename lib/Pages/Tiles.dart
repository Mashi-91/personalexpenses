import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model.dart';

class Tiles extends StatelessWidget {
  List<Transaction> tx;
  Function remove;

  Tiles(this.remove, this.tx);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tx.length,
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Material(
                borderRadius: BorderRadius.circular(30),
                elevation: 5,
                child: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                    child: FittedBox(
                        fit: BoxFit.cover,
                        child: Text("\$${tx[index].amount.toString()}"))),
              ),
              title: Text(tx[index].title),
              subtitle: Text(DateFormat.yMMMd().format(tx[index].date)),
              trailing: IconButton(onPressed: () => remove(index), icon: Icon(Icons.delete)),
            ),
          );
        });
  }
}
