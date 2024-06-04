import 'package:flutter/material.dart';
import 'package:ttpay/component/empty_image_column.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Column noTransactionsColumn(BuildContext context) => emptyImageColumn(
      imageAddress: 'assets/images/no-transaction.png',
      title: AppLocalizations.of(context)!.no_transactions_found,
      description:
          AppLocalizations.of(context)!.no_transactions_found_description,
    );
