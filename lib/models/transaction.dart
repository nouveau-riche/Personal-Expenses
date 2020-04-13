import 'package:flutter/foundation.dart';

class Transaction{
  final String id;
  final String product;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.product,
    @required this.amount,
    @required this.date});
}

