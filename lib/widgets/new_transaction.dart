import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import './adaptive_button.dart';

class NewTransaction extends StatefulWidget{
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
    DateTime  selectedDate;
     void presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now()).then((pickedDate){
            if(pickedDate==null)
              {return;}
            setState((){
              selectedDate = pickedDate;
            });
        });
  }

  void submitData(){
    final enteredProduct=productController.text;
    final enteredAmount= double.parse(amountController.text);
    if(enteredProduct.isEmpty || enteredAmount<=0 || selectedDate == null)
      {return;}
    widget.addTx(enteredProduct,enteredAmount,selectedDate);
    Navigator.of(context).pop();
  }

  final productController = TextEditingController();
     final amountController =  TextEditingController();

          Widget build(BuildContext context){
            return SingleChildScrollView(
              child:Card(
              child:Container(
                padding: EdgeInsets.only(
                  top:10,
                  left:10,
                  right:10,
                  bottom:MediaQuery.of(context).viewInsets.bottom + 10,
                ),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText:'Product'),
                      controller: productController,
                    ),
                    TextField(
                      decoration:InputDecoration(labelText:'Amount'),
                      controller:amountController,
                      keyboardType:TextInputType.numberWithOptions(decimal:true),
                    ),

                    Container(
                      height:70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(selectedDate == null ? "No Date Choosen" : "Picked Date: ${DateFormat.yMMMd().format(selectedDate)}"),
                          AdaptiveButton('Chosse Date',presentDatePicker),
                        ],
                      ),
                    ),
                    RaisedButton(child:Text("Add Transaction",),
                        textColor:Colors.white,
                        color:Colors.purple,
                        onPressed: (){
                               submitData();
                    }),
                  ],
                ),
              ),
            ),
            );
          }
}