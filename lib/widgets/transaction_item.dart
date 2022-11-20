import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';

import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function removeTx;
  TransactionItem({Key? key, required this.transaction, required this.removeTx})
      : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color? itemBgColor;
  @override
  void initState() {
    //fetching data at the beginning
    const List<Color> bgColors = [Colors.red, Colors.blue, Colors.green];

    //data proccessing
    itemBgColor = bgColors[Random().nextInt(bgColors.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      elevation: 7,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: itemBgColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: FittedBox(
              child: Text('\$${widget.transaction.amount.toString()}'),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat.yMMMMd().format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                label: Text(
                  'Delete',
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
                onPressed: () {
                  widget.removeTx(widget.transaction.id);
                },
              )
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  widget.removeTx(widget.transaction.id);
                },
              ),
      ),
    );
  }
}
