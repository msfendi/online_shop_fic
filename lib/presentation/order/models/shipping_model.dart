import 'package:online_shop_fic/core/extensions/date_time_ext.dart';
import 'package:online_shop_fic/core/extensions/int_ext.dart';

class ShippingModel {
  final String type;
  final int priceStart;
  final int priceEnd;
  final DateTime estimate;

  ShippingModel({
    required this.type,
    required this.priceStart,
    required this.priceEnd,
    required this.estimate,
  });

  String get priceFormat =>
      '${priceStart.currencyFormatRp} - ${priceEnd.currencyFormatRp}';
  String get estimateFormat => estimate.toFormattedDate();
}
