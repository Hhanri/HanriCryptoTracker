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
    try {
      final List<CryptoIdModel> cryptos = await APIService.getPrices(state);
      state = [...cryptos];
      save();
    } catch(e) {
      print("error");
    }
  }

  void addId(CryptoIdModel crypto) {
    List<CryptoIdModel> temporaryState = [...state];
    temporaryState.add(crypto);
    state = temporaryState;
    save();
  }

  void swapIds(int oldIndex, int newIndex, CryptoIdModel crypto) {
    final int index = newIndex > oldIndex ? newIndex - 1 : newIndex;
    List<CryptoIdModel> temporaryState = [...state];
    temporaryState.removeAt(oldIndex);
    temporaryState.insert(index, crypto);
    state = temporaryState;
    save();
  }
}