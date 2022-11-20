import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _removeTx;
  TransactionsList(this._transactions, this._removeTx);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No Transactions available',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: constraints.maxHeight * 0.06),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(
                  key: ValueKey(_transactions[index].id),
                  transaction: _transactions[index],
                  removeTx: _removeTx);
            },
            itemCount: _transactions.length);
  }
}
