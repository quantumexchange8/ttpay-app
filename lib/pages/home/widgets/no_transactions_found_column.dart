import 'package:flutter/material.dart';
import 'package:ttpay/component/empty_image_column.dart';

Column noTransactionsColumn = emptyImageColumn(
  description: 'It seems there are no transactions to display at the moment.',
  imageAddress: 'assets/images/no-transaction.png',
  title: 'No Transactions Found',
);
