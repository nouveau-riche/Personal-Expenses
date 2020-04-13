import 'package:flutter/material.dart';
import '../models/transaction.dart';

import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget{

  final List<Transaction> transactions;
  final Function deletTransaction;
  TransactionList(this.transactions,this.deletTransaction);

          @override
          Widget build(BuildContext context){
        return  transactions.isEmpty ? LayoutBuilder(builder: (ctx, constraints){
          return Column(
            children: <Widget>[
              Text("No transactions done yet!"),
              Container(
                  margin:const EdgeInsets.only(top:60),
                  height:constraints.maxHeight*0.52,
                  child: Image.asset('assets/images/waiting.png',
                    fit:BoxFit.cover,
                  )),
            ],
          );
        })  : ListView.builder(
            itemBuilder:(ctx,index){
              return Card(
                elevation: 6,
                margin:const EdgeInsets.symmetric(horizontal:10,vertical:10),
                child: ListTile(
                  leading:CircleAvatar(
                    radius:30,
                    child:Padding(
                      padding:const EdgeInsets.all(10),
                      child: FittedBox(
                        child:Text("${transactions[index].amount.toStringAsFixed(1)}₹"),
                      ),
                    ),
                  ),
                  title:Text( transactions[index].product),
                  subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: MediaQuery.of(context).size.width > 460 ? FlatButton.icon(
                    icon:const Icon(Icons.delete),
                    label:const Text('Delete'),
                    textColor: Theme.of(context).errorColor,
                    onPressed: () => deletTransaction(transactions[index].id),
                  ) : IconButton(icon: const Icon(Icons.delete), color:Theme.of(context).errorColor,
                      onPressed:() => deletTransaction(transactions[index].id)
                  ),
                ),
              );
            },
            itemCount:transactions.length,
        );
      }
}