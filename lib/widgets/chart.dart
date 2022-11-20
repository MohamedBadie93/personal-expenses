import 'package:flutter/material.dart';
import 'package:personal_expenses2/widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;
  Chart(this._recentTransactions);

  List<Map<String, Object>> get _groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;
      for (int i = 0; i < _recentTransactions.length; i++) {
        if (weekDay.day == _recentTransactions[i].date.day &&
            weekDay.month == _recentTransactions[i].date.month &&
            weekDay.year == _recentTransactions[i].date.year) {
          totalAmount += _recentTransactions[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalAmount};
    }).reversed.toList();
  }

  double get _allSpentAllDays {
    return _groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue += (element['amount']) as double;
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(_groupedTransactionValues);
    return Container(
      margin: EdgeInsets.all(20),
      child: Card(
        elevation: 7,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _groupedTransactionValues.map((tx) {
              return Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: ChartBar((tx['day']) as String, (tx['amount']) as double,
                    _allSpentAllDays),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
