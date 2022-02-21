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

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
