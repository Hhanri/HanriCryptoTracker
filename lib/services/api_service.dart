import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class APIService {
  static const String apiKey = "c64645f4cfb004d4dfab5e1fb5a2ce30a9864275";
  static const String urlBody = "https://api.nomics.com/v1/currencies/ticker?";
  static const String apiKeyExtension = "key=";
  static const String idsExtension = "&ids=";
  static const String attributesExtensions = "&attributes=id,name,logo_url,price";

  static Future<List<String>> getPrices(List<String> ids) async {
    final String url = "$urlBody$apiKeyExtension$apiKey$idsExtension${ids.join(",")}$attributesExtensions";
    print(url);
    List<String> prices = [];
    final Response response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body) as List<dynamic>;
    print(body);
    for (var element in body) {
      prices.add(element["price"] ?? "error");
    }

    return prices;
  }
}