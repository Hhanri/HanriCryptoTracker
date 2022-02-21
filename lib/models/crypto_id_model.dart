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

  static const String idKey = "id";
  static const String nameKey = "nameKey";
  static const String priceKey = "price";
  static const String priceChangeKey = "priceChange";

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
