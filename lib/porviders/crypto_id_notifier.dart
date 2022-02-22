import 'dart:convert';
import 'package:crypto_tracker/models/crypto_id_model.dart';
import 'package:crypto_tracker/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CryptoIdNotifier extends StateNotifier<List<CryptoIdModel>> {
  CryptoIdNotifier() : super(_initialState);

  static final List<CryptoIdModel> _initialState = [];

  void loadInitialState() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedData = prefs.getStringList("save") ?? [];
    List<CryptoIdModel> loadedData = [];
    for (String element in savedData) {
      loadedData.add(CryptoIdModel.fromMap(jsonDecode(element)));
    }
    state = loadedData;
  }

  void save() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedData = [];
    for (CryptoIdModel element in state) {
      savedData.add(jsonEncode(CryptoIdModel.toMap(element)));
    }
    prefs.setStringList("save", savedData);
  }

  void setPrices() async {
    if (state.isNotEmpty) {
      try {
        final List<CryptoIdModel> cryptos = await APIService.getPrices(state);
        state = [...cryptos];
        print("state = $state");
        save();
      } catch(e) {
        //print("error");
      }
    }
  }

  void addId(CryptoIdModel crypto) {
    print("new to add = $crypto");
    if (state.any((element) => element.id == crypto.id && element.name == crypto.name)) {
      print("already added");
    } else {
      List<CryptoIdModel> temporaryState = [...state];
      temporaryState.add(crypto);
      state = temporaryState;
      save();
    }
  }

  void swapIds(int oldIndex, int newIndex, CryptoIdModel crypto) {
    final int index = newIndex > oldIndex ? newIndex - 1 : newIndex;
    List<CryptoIdModel> temporaryState = [...state];
    temporaryState.removeAt(oldIndex);
    temporaryState.insert(index, crypto);
    state = temporaryState;
    save();
  }
  void manualLoadState(){
    state = [
      const CryptoIdModel(id: "BTC", name: "Bitcoin", price: 0, priceChange: 0),
      const CryptoIdModel(id: "ETH", name: "Ethereum", price: 0, priceChange: 0)
    ];
    save();
  }
}