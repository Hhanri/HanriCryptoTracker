import 'package:equatable/equatable.dart';

class CryptoIdModel extends Equatable{
  final String id;
  final String name;

  const CryptoIdModel({required this.id, required this.name});

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}