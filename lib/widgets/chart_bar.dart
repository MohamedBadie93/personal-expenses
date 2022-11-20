import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  String dayTitle;
  double totalSpent;
  double allSpentAllDays;

  ChartBar(this.dayTitle, this.totalSpent, this.allSpentAllDays);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text('\$${totalSpent.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(220, 220, 220, 1),
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  alignment: Alignment.topCenter,
                  heightFactor:
                      totalSpent == 0.0 ? 0.0 : totalSpent / allSpentAllDays,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                dayTitle.substring(0, 1),
              ),
            ),
          ),
        ],
      );
    });
  }
}
