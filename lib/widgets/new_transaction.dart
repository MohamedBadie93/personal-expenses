import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTx;

  NewTransaction(this._addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? choosenDate;

  void submitData() {
    final enteredTitle = _titleController.text;
    final eneterdAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || eneterdAmount <= 0 || choosenDate == null)
      return;

    widget._addTx(enteredTitle, eneterdAmount, choosenDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        choosenDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              top: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                //onChanged: (value) => titleInput = value,
                controller: _titleController,
                onSubmitted: (_) {
                  submitData();
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'amount'),
                keyboardType: TextInputType.number,
                //onChanged: (value) => amountInput = value,
                controller: _amountController,
                onSubmitted: (_) {
                  submitData();
                },
              ),
              Container(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(choosenDate == null
                          ? 'No Date  Picked !'
                          : 'Picked Date: ${DateFormat.yMMMd().format(choosenDate!)}'),
                    ),
                    FlatButton(
                      child: Text(
                        'Pick Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        _presentDatePicker();
                      },
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text(
                  'Add Transaction',
                ),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).buttonColor,
                onPressed: () {
                  submitData();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
