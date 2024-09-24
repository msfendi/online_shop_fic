import '../../../core/core.dart';

class TransactionModel {
  final String noResi;
  final String status;
  final int quantity;
  final int price;

  TransactionModel({
    required this.noResi,
    required this.status,
    required this.quantity,
    required this.price,
  });

  String get item => '$quantity item yang dibeli';
  String get priceFormat => price.currencyFormatRp;
}

final List<TransactionModel> transactions = [
  TransactionModel(
    noResi: '1234567890',
    status: 'Dikirim',
    quantity: 2,
    price: 200000,
  ),
  TransactionModel(
    noResi: '1234567890',
    status: 'Dikirim',
    quantity: 2,
    price: 200000,
  ),
  TransactionModel(
    noResi: '1234567890',
    status: 'Dikirim',
    quantity: 2,
    price: 200000,
  ),
  TransactionModel(
    noResi: '1234567890',
    status: 'Dikirim',
    quantity: 2,
    price: 200000,
  ),
  TransactionModel(
    noResi: '1234567890',
    status: 'Dikirim',
    quantity: 2,
    price: 200000,
  ),
];
