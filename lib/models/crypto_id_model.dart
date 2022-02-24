import 'package:equatable/equatable.dart';
class CryptoIdModel extends Equatable{
  final String logo;
  final String id;
  final String name;
  const CryptoIdModel({
    required this.logo,
    required this.id,
    required this.name,
  });

  static const blankModel = CryptoIdModel(logo: "", id: "", name: "");

  static Map<String,dynamic> toMap(CryptoIdModel data) {
    return {
      logoKey: data.logo,
      idKey: data.id,
      nameKey: data.name,
    };
  }

  factory CryptoIdModel.fromMap(Map<String,dynamic> data) {
    return CryptoIdModel(
      logo: data[logoKey],
      id: data[idKey],
      name: data[nameKey],
    );
  }

  factory CryptoIdModel.getCryptoIdModel(Map<String,dynamic> data, bool onlyId){
        return CryptoIdModel(
      logo: data["logo_url"],
      id: data["id"],
      name: data["name"],
    );
  }

  static const String logoKey = "logo";
  static const String idKey = "id";
  static const String nameKey = "name";
  static const String priceKey = "price";
  static const String priceChangeKey = "priceChange";

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
