import 'dart:convert';
import 'package:crypto_tracker/models/crypto_id_model.dart';
import 'package:crypto_tracker/models/price_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class APIService {
  static const String apiKey = "c64645f4cfb004d4dfab5e1fb5a2ce30a9864275";
  static const String urlBody = "https://api.nomics.com/v1/currencies";
  static const String tickerPath = "/ticker";
  static const String apiKeyExtension = "?key=";
  static const String idsExtension = "&ids=";
  static const String attributesExtensions = "&attributes=id,name,logo_url";
  static const String intervalExtensions = "&interval=1h";
  static const String rankSortingExtensions = "&sort=rank";

  static Future<List<PriceModel>> getPrices(List<CryptoIdModel> cryptos) async {
    final List<String> ids = cryptos.map((e) => e.id).toList();
    final String url = "$urlBody$tickerPath$apiKeyExtension$apiKey$idsExtension${ids.join(",")}$intervalExtensions";
    List<PriceModel> newPrices = [];
    for (int i = 0; i < ids.length; i++) {
      newPrices.add(PriceModel.blankModel);
    }
    final Response response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body) as List<dynamic>;
    for (var element in body) {
      try {
        newPrices[cryptos.indexWhere((e) => e.id == element[CryptoIdModel.idKey] && e.name == element[CryptoIdModel.nameKey])] = PriceModel.getPriceModel(element, false);
      } catch(e) {
        print("error refreshing prices");
      }
    }
    return newPrices;
  }

  static Future<List<CryptoIdModel>> getAllCoins() async {
    const String url = "$urlBody$apiKeyExtension$apiKey$attributesExtensions";
    List<CryptoIdModel> cryptos = [];
    final Response response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body) as List<dynamic>;
    for (var element in body) {
      cryptos.add(CryptoIdModel.getCryptoIdModel(element, true));
    }
    return cryptos;
  }
}