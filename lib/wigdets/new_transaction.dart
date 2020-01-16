// Widget that makes textfields to add transactions
import 'package:expense_planner/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _amountController = new TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    if(_amountController.text.isEmpty){
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTransaction(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()).then((pickedDate){
          if(pickedDate == null)
          {
              return;
          }
          else
            {
              setState(() {
                _selectedDate  = pickedDate;

              });
            }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            left:10,
            right:10,
            top:10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 40
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Text(_selectedDate == null ? "No Date Chosen !": DateFormat.yMd().format(_selectedDate) ),
                    Expanded(
                      child: FlatButton(
                        child: Text(
                          'Choose Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed:_presentDatePicker,
                        textColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text(
                  "Add Transaction",
                ),
                color: Colors.purple,
                textColor: Colors.white,
                onPressed: submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
