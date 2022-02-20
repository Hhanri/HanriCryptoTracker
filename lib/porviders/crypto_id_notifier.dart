import 'package:crypto_tracker/models/crypto_id_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CryptoIdNotifier extends StateNotifier<List<CryptoIdModel>> {
  CryptoIdNotifier() : super(_initialState);

  static final List<CryptoIdModel> _initialState = [const CryptoIdModel(id: "BTC", name: "BTC")];

}