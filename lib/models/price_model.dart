import 'package:equatable/equatable.dart';

class PriceModel extends Equatable {
  final double price;
  final double priceChange;

  const PriceModel({required this.price, required this.priceChange});

  static const String priceKey = "price";
  static const String priceChangeKey = "price_change";
  static const String dailyKey = "1d";

  factory PriceModel.getPriceModel(Map<String,dynamic> data) {
    return PriceModel(
        price: double.parse(data[PriceModel.priceKey]?? "0"),
        priceChange: double.parse(data[PriceModel.dailyKey][PriceModel.priceChangeKey] ?? 0)
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [price, priceChange];
}