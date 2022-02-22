import 'package:crypto_tracker/models/crypto_id_model.dart';
import 'package:crypto_tracker/porviders/providers.dart';
import 'package:crypto_tracker/porviders/search_notifier.dart';
import 'package:crypto_tracker/resources/strings.dart';
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
        ref.watch(cryptoIdsProvider.notifier).setPrices();
        final SearchModel searching = ref.watch(searchIdProvider);
        if (searching.isSearching == true && searching.searchedId.isNotEmpty) {
          final List<CryptoIdModel> searchedIds = cryptos.where(
            (element) => element.id.toLowerCase().contains(searching.searchedId.toLowerCase()) || element.name.contains(searching.searchedId.toLowerCase())
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
            (element) => element.id.toLowerCase().contains(searching.searchedId.toLowerCase()) || element.name.contains(searching.searchedId.toLowerCase())
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
    return ListView.builder(
      itemCount: cryptos.length,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return ListTileWidget(crypto: cryptos[index], isNewId: isNewId);
      },
    );
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
    return Column(
      children: [
        ReorderableListView.builder(
          physics: const ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return ListTileWidget(
              isNewId: false,
              crypto: cryptos[index],
              key: ValueKey(cryptos[index].id + cryptos[index].name),
            );
          },
          itemCount: cryptos.length,
          onReorder: (int oldIndex, int newIndex) {
            onReorder(oldIndex, newIndex);
          }
        ),
      ],
    );
  }
}

