import 'package:crypto_tracker/models/crypto_id_model.dart';
import 'package:crypto_tracker/models/price_model.dart';
import 'package:crypto_tracker/porviders/providers.dart';
import 'package:crypto_tracker/porviders/search_notifier.dart';
import 'package:crypto_tracker/services/api_service.dart';
import 'package:crypto_tracker/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeListViewWidget extends StatelessWidget {
  const HomeListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final bool counter = ref.watch(timerProvider.select((value) => value.changed));
        final List<CryptoIdModel> cryptos = ref.watch(cryptoIdsProvider);
        final SearchModel searching = ref.watch(searchIdProvider);
        print("rebuilt");
        if (searching.isSearching == true && searching.searchedId.isNotEmpty) {
          final List<CryptoIdModel> searchedIds = cryptos.where(
            (element) => element.id.toLowerCase().startsWith(searching.searchedId.toLowerCase()) || element.name.startsWith(searching.searchedId.toLowerCase())
          ).toList();
          if (searchedIds.isNotEmpty) {
            return SimpleListViewWidget(cryptos: searchedIds, isNewId: false);
          } else {
            return const Center(child: Text("no result found"));
          }
        } else {
          if (cryptos.isNotEmpty){
            return ReorderableListViewWidget(
              cryptos: cryptos,
              onReorder: (oldIndex, newIndex) {
                ref.watch(cryptoIdsProvider.notifier).swapIds(oldIndex, newIndex, cryptos[oldIndex]);
              }
            );
          } else {
            return const Center(
              child: Text(
                "no crypto added"
              ),
            );
          }
        }
      }
    );
  }
}

class BrowseListViewWidget extends StatelessWidget {
  final List<CryptoIdModel> cryptos;
  const BrowseListViewWidget({
    Key? key,
    required this.cryptos
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final SearchModel searching = ref.watch(searchIdProvider);
        if (searching.isSearching && searching.searchedId.isNotEmpty) {
          final List<CryptoIdModel> searchedIds = cryptos.where(
            (element) => element.id.toLowerCase().startsWith(searching.searchedId.toLowerCase()) || element.name.toLowerCase().toLowerCase().startsWith(searching.searchedId.toLowerCase())
          ).toList();
          if (searchedIds.isNotEmpty) {
            return SimpleListViewWidget(cryptos: searchedIds, isNewId: true);
          } else {
            return const Center(child: Text("no result found"));
          }
        } else {
          return SimpleListViewWidget(cryptos: cryptos, isNewId: true);
        }
      },
    );
  }
}

class SimpleListViewWidget extends StatelessWidget {
  final List<CryptoIdModel> cryptos;
  final bool isNewId;
  const SimpleListViewWidget({
    Key? key,
    required this.cryptos,
    required this.isNewId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(cryptos);
    if (isNewId) {
      print("building search list view");
      return ListView.builder(
        itemCount: cryptos.length,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return ListTileWidget(crypto: cryptos[index], isNewId: isNewId, price: PriceModel.blankModel);
        },
      );
    } else {
      return FutureBuilder(
        future: APIService.getPrices(cryptos),
        builder: (BuildContext context, AsyncSnapshot<List<PriceModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: cryptos.length,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return ListTileWidget(crypto: cryptos[index], isNewId: isNewId, price: snapshot.data![index],);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      );
    }
  }
}

class ReorderableListViewWidget extends StatelessWidget {
  final List<CryptoIdModel> cryptos;
  final Function(int,int) onReorder;
  const ReorderableListViewWidget({
    Key? key,
    required this.cryptos,
    required this.onReorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: APIService.getPrices(cryptos),
      builder: (BuildContext context, AsyncSnapshot<List<PriceModel>> snapshot) {
        if (snapshot.hasData) {
          return ReorderableListView.builder(
              physics: const ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return ListTileWidget(
                  isNewId: false,
                  crypto: cryptos[index],
                  key: ValueKey(cryptos[index].id + cryptos[index].name),
                  price: snapshot.data![index]
                );
              },
              itemCount: cryptos.length,
              onReorder: (int oldIndex, int newIndex) {
                onReorder(oldIndex, newIndex);
              }
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },

    );

  }
}

