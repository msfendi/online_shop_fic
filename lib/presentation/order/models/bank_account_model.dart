import '../../../core/core.dart';

class BankAccountModel {
  final String code;
  final String name;
  final String image;

  BankAccountModel(
      {required this.code, required this.name, required this.image});
}

final banks = [
  BankAccountModel(
    code: 'bri',
    name: 'BRI Virtual Account',
    image: Assets.images.banks.bRIDirectDebit.path,
  ),
  BankAccountModel(
    code: 'bca',
    name: 'BCA Virtual Account',
    image: Assets.images.banks.bca.path,
  ),
  BankAccountModel(
    code: 'bni',
    name: 'BNI Virtual Account',
    image: Assets.images.banks.mandiri.path,
  ),
];
