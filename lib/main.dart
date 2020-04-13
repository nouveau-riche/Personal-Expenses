import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/new_transaction.dart';
import 'models/transaction.dart';
import 'widgets/transaction_list_content.dart';
import 'package:personalxpenses/widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return MaterialApp(
      title:"PersonalExpenses",
      theme:ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{


  final List<Transaction> _userTransaction=[
//    Transaction(
//        id:'t1',
//        product:'New Shoes',
//        amount:59.99,
//        date:DateTime.now()
//    ),
//    Transaction(
//        id:'t2',
//        product:'Grocries',
//        amount:13.65,
//        date:DateTime.now()
//    ),
  ];

  @override
  void initState(){
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
      print(state);
  }

  @override
  dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  void addNewTransaction(String txProduct,double txAmount,DateTime selectedDate){
    final newTx=Transaction(
        product:txProduct,
        amount : txAmount,
        date: selectedDate,
        id: DateTime.now().toString()
    );

    setState(() {
      _userTransaction.add(newTx);
    });

  }


  void _startAddingNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder:(_) {
      return GestureDetector (
        onTap:(){},
        child:NewTransaction(addNewTransaction),
        behavior:HitTestBehavior.opaque,

      );
    });
  }

  void deleteTransaction(String id){
    setState(() {
      _userTransaction.removeWhere((tx){
        return tx.id==id;
      });
    });
  }

  List<Transaction> get _recentTransactions{
        return _userTransaction.where((tx) {
            return tx.date.isAfter(DateTime.now().subtract(Duration(days:7),));
        }).toList();
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context){

    final mediaQuery = MediaQuery.of(context);
    final isLandscape = MediaQuery.of(context).orientation ==  Orientation.landscape;


    final PreferredSizeWidget appBar = Platform.isIOS ? CupertinoNavigationBar(
      middle:Text("Personal Expenses"),
      trailing:Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () => _startAddingNewTransaction(context),
            child:Icon(CupertinoIcons.add),

          ),
        ],
      ),

    ) : AppBar(
      title:Text("Personal Expenses"),
      actions:<Widget>[
        IconButton(
            icon:Icon(Icons.add),
            onPressed:() => _startAddingNewTransaction(context)
        ),
      ],
    );

    final txList = Container(
      height:(mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top)*0.7,
      child:TransactionList(_userTransaction,deleteTransaction),);


    final pageBody = SafeArea(
      child: SingleChildScrollView(
      child:Column(
        children: <Widget>[
          if(isLandscape) Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Show Chart',style:TextStyle(fontSize: 10,color:Colors.green),),
              Switch.adaptive(value:_showChart, onChanged:(val) {
                setState(() {
                  _showChart = val;
                });
              },),
            ],
          ),

          if(!isLandscape) Container(
            height:(mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top)*0.3,
            child:Chart(_recentTransactions),),
          if(!isLandscape) txList,


          if(isLandscape) _showChart ? Container(
            height:(mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top)*0.8,
            width:mediaQuery.size.width*0.8,
            child:Chart(_recentTransactions),
          ) : txList
        ],
      ),
    ),
    );

    return Platform.isIOS ? CupertinoPageScaffold(
            child:pageBody,
            navigationBar: appBar,) : Scaffold(
      appBar:appBar,
      body: pageBody,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(child:Icon(Icons.add), onPressed:() => _startAddingNewTransaction(context)),
    );
  }
}