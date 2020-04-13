import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget{
  final String weekDayLabel;
  final double spendingAmount;
  final double percSpendingAmount;

   const ChartBar(this.weekDayLabel,this.spendingAmount,this.percSpendingAmount);

  Widget build(BuildContext context){
    return LayoutBuilder(builder: (ctx,constraints){
              return Column(
                children: <Widget>[
                  Container(
                      height:constraints.maxHeight*0.15,
                      child: FittedBox(child:Text("${spendingAmount.toStringAsFixed(0)}₹"),)),
                  SizedBox(height:constraints.maxHeight*0.05,),
                  Container(
                    height:constraints.maxHeight*0.6,
                    width:15,
                    child:Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border:Border.all(color:Colors.grey,width:1,),
                            color:Color.fromRGBO(220, 220, 220, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        FractionallySizedBox(
                          heightFactor: percSpendingAmount,
                          child:Container(
                            decoration: BoxDecoration(
                              color:Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height:constraints.maxHeight*0.05,),
                  Container(
                      height:constraints.maxHeight*0.15,
                      child: FittedBox(
                        fit:BoxFit.cover,
                          child: Text(weekDayLabel))),
                ],
              );
    });

  }
}