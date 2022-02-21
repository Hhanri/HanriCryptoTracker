import 'package:crypto_tracker/models/crypto_id_model.dart';
import 'package:crypto_tracker/models/price_model.dart';
import 'package:crypto_tracker/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CryptoIdNotifier extends StateNotifier<List<CryptoIdModel>> {
  CryptoIdNotifier() : super(_initialState);

  static final List<CryptoIdModel> _initialState = [
    const CryptoIdModel(id: "BTC", name: "BTC", price: 0, priceChange: 0),
    const CryptoIdModel(id: "ETH", name: "ETH", price: 0, priceChange: 0),
  ];

  List<String> getIds() {
    return state.map((e) => e.id).toList();
  }

  void setPrices() async {
    try {
      final List<String> ids = getIds();
      final List<PriceModel> prices = await APIService.getPrices(ids);
      List<CryptoIdModel> newState = [];
      for (var element in state) {
        int index = state.indexOf(element);
        newState.add(
          CryptoIdModel(
            id: element.id,
            name: element.name,
            price: prices[index].price,
            priceChange: prices[index].priceChange
          )
        );
      }
      state = newState;
    } catch(e) {
      print("error");
    }
  }
}