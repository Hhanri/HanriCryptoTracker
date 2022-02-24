import 'package:equatable/equatable.dart';

class PriceModel extends Equatable{
  final double price;
  final double priceChange;

  const PriceModel({
    required this.price,
    required this.priceChange
  });

  static const blankModel = PriceModel(price: 0, priceChange: 0);

  factory PriceModel.getPriceModel(Map<String,dynamic> data, bool onlyId){
    double priceChange;
    double price;
    try {
      priceChange = double.parse(data["1d"]["price_change"]);
    } catch(e) {
      priceChange = 0.0;
    }
    try {
      price = double.parse(data["price"]);
    } catch(e) {
      price = 0.0;
    }
    return PriceModel(
      price: price,
      priceChange: priceChange
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [price, priceChange];
}