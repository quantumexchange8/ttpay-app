import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MerchantWallet {
  int merchantId;
  String merchantWalletNo;
  double grossDeposit;
  double grossWithdrawal;
  double netDeposit;
  double netWithdrawal;
  double totalDepositFee;
  double totalWithdrawalFee;
  int totalDepositNumber;
  double totalFreezingAmount;
  MerchantWallet({
    required this.merchantId,
    required this.merchantWalletNo,
    required this.grossDeposit,
    required this.grossWithdrawal,
    required this.netDeposit,
    required this.netWithdrawal,
    required this.totalDepositFee,
    required this.totalWithdrawalFee,
    required this.totalDepositNumber,
    required this.totalFreezingAmount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'merchant_id': merchantId,
      'merchant_wallet_no': merchantWalletNo,
      'gross_deposit': grossDeposit,
      'gross_withdrawal': grossWithdrawal,
      'net_deposit': netDeposit,
      'net_withdrawal': netWithdrawal,
      'total_deposit_fee': totalDepositFee,
      'total_withdrawal_fee': totalWithdrawalFee,
      'total_deposit_number': totalDepositNumber,
      'total_freezing_amount': totalFreezingAmount,
    };
  }

  factory MerchantWallet.fromMap(Map<String, dynamic> map) {
    return MerchantWallet(
      merchantId: map['merchant_id'] as int,
      merchantWalletNo: map['merchant_wallet'] as String,
      grossDeposit: double.parse(map['gross_deposit'] as String),
      grossWithdrawal: double.parse(map['gross_withdrawal'] as String),
      netDeposit: double.parse(map['net_deposit'] as String),
      netWithdrawal: double.parse(map['net_withdrawal'] as String),
      totalDepositFee: double.parse(map['total_deposit_fee'] as String),
      totalWithdrawalFee: double.parse(map['total_withdrawal_fee'] as String),
      totalDepositNumber: map['total_deposit_number'] as int,
      totalFreezingAmount: double.parse(map['total_freezing_amount'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory MerchantWallet.fromJson(String source) =>
      MerchantWallet.fromMap(json.decode(source));
}
