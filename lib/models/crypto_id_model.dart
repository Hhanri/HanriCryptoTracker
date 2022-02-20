import 'package:equatable/equatable.dart';
class CryptoIdModel extends Equatable{
  final String id;
  final String name;
  final String price;
  const CryptoIdModel({required this.id, required this.name, required this.price});

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
