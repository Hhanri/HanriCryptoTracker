import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class APIService {
  static const String apiKey = "c64645f4cfb004d4dfab5e1fb5a2ce30a9864275";
  static const String urlBody = "https://api.nomics.com/v1/currencies/ticker?";
  static const String apiKeyExtension = "key=";
  static const String idsExtension = "&ids=";
  static const String attributesExtensions = "&attributes=id,name,logo_url,price";

  static Future<List<PriceModel>> getPrices(List<String> ids) async {
    final String url = "$urlBody$apiKeyExtension$apiKey$idsExtension${ids.join(",")}$attributesExtensions";
    List<PriceModel> prices = [];
    final Response response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body) as List<dynamic>;
    for (var element in body) {
      print(element["price"]);
      print(element["1d"]["price_change"]);
      prices.add(PriceModel(price: element["price"] ?? "error", priceChange: double.parse(element["1d"]["price_change"] ?? "0")));
    }
    print(prices);
    return prices;
  }
}

class PriceModel extends Equatable {
  final String price;
  final double priceChange;

  const PriceModel({required this.price, required this.priceChange});

  @override
  // TODO: implement props
  List<Object?> get props => [price, priceChange];
}