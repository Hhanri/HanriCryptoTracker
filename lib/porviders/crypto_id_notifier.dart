import 'package:crypto_tracker/models/crypto_id_model.dart';
import 'package:crypto_tracker/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CryptoIdNotifier extends StateNotifier<List<CryptoIdModel>> {
  CryptoIdNotifier() : super(_initialState);

  static final List<CryptoIdModel> _initialState = [const CryptoIdModel(id: "BTC", name: "BTC", price: "")];

  List<String> getIds() {
    return state.map((e) => e.id).toList();
  }

  void setPrices() async {
    final List<String> ids = getIds();
    final List<String> prices = await APIService.getPrices(ids);
    List<CryptoIdModel> newState = [];
    for (var element in state) {
      try {
        int index = state.indexOf(element);
        newState.add(CryptoIdModel(id: element.id, name: element.name, price: prices[index]));
      } catch(e) {
        print("index error");
      }
    }
    state = newState;
  }

}