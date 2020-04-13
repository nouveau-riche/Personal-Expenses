import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget{
    final List<Transaction> recentTransaction;
    Chart(this.recentTransaction);

  List<Map<String,Object>> get groupedTransactionValues{
    return List.generate(7, (index) {
            final weekDay = DateTime.now().subtract(Duration(days: index));

            var totalAmount =0.0;
            for(var i=0;i<recentTransaction.length;i++){
              if(recentTransaction[i].date.day == weekDay.day &&
                recentTransaction[i].date.month == weekDay.month &&
                recentTransaction[i].date.year == weekDay.year
              ){
                  totalAmount += recentTransaction[i].amount;
                }
            }
            return {'day':DateFormat.E().format(weekDay).substring(0,1) ,'amount':totalAmount};
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context){
    return Container(
      margin:EdgeInsets.all(6),
      child: Card(
          elevation: 10,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((data){
                  return Flexible(
                    fit:FlexFit.tight,
                    child:ChartBar(data['day'],data['amount'],(data['amount'] as double)/1000),);
              }).toList(),
         ),
          ),
      ),
    );

  }
}