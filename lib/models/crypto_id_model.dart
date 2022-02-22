import 'package:equatable/equatable.dart';
class CryptoIdModel extends Equatable{
  final String id;
  final String name;
  final double price;
  final double priceChange;
  const CryptoIdModel({
    required this.id,
    required this.name,
    required this.price,
    required this.priceChange
  });

  static const blankModel = CryptoIdModel(id: "", name: "", price: 0, priceChange: 0);

  static Map<String,dynamic> toMap(CryptoIdModel data) {
    return {
      idKey: data.id,
      nameKey: data.name,
      priceKey: data.price,
      priceChangeKey: data.priceChange
    };
  }

  factory CryptoIdModel.fromMap(Map<String,dynamic> data) {
    return CryptoIdModel(
      id: data[idKey],
      name: data[nameKey],
      price: data[priceKey],
      priceChange: data[priceChangeKey]
    );
  }

  factory CryptoIdModel.getCryptoIdModel(Map<String,dynamic> data, bool onlyId){
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
    return CryptoIdModel(
      id: data["id"],
      name: data["name"],
      price: onlyId ? 0.0 : price,
      priceChange: onlyId ? 0.0 : priceChange
    );
  }

  static const String idKey = "id";
  static const String nameKey = "name";
  static const String priceKey = "price";
  static const String priceChangeKey = "priceChange";

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, price, priceChange];
}
