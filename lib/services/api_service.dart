import 'dart:convert';
import 'package:crypto_tracker/models/price_model.dart';
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
      print(element[PriceModel.priceKey]);
      print(element[PriceModel.dailyKey][PriceModel.priceChangeKey]);
      prices.add(PriceModel.getPriceModel(element));
    }
    print(prices);
    return prices;
  }
}