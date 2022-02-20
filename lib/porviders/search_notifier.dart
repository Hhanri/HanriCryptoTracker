import 'package:flutter_riverpod/flutter_riverpod.dart';


class SearchSeedNotifier extends StateNotifier<SearchModel> {
  SearchSeedNotifier() : super(_initialState);

  static final SearchModel _initialState = SearchModel(searchedId: "", isSearching: false);

  void searchId(String id) {
    state = SearchModel(isSearching: state.isSearching, searchedId: id);
  }

  void openSearchBar() {
    state = SearchModel(isSearching: !state.isSearching, searchedId: "");
  }

}

class SearchModel {
  final bool isSearching;
  final String searchedId;

  SearchModel({
    required this.isSearching,
    required this.searchedId
  });

}