import 'package:crypto_tracker/models/crypto_id_model.dart';
import 'package:crypto_tracker/models/price_model.dart';
import 'package:crypto_tracker/providers/providers.dart';
import 'package:crypto_tracker/providers/search_notifier.dart';
import 'package:crypto_tracker/resources/strings.dart';
import 'package:crypto_tracker/services/api_service.dart';
import 'package:crypto_tracker/widgets/dismissible_background_container_widget.dart';
import 'package:crypto_tracker/widgets/list_tile_widget.dart';
import 'package:crypto_tracker/widgets/loading_widget.dart';
import 'package:crypto_tracker/widgets/no_internet_widget.dart';
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
        final bool isConnectedToInternet = ref.watch(connectivityProvider);
        print("rebuilt");
        if (isConnectedToInternet) {
          if (searching.isSearching == true && searching.searchedId.isNotEmpty) {
            final List<CryptoIdModel> searchedIds = cryptos.where(
              (element) => element.id.toLowerCase().startsWith(searching.searchedId.toLowerCase()) || element.name.startsWith(searching.searchedId.toLowerCase())
            ).toList();
            if (searchedIds.isNotEmpty) {
              return SimpleListViewWidget(
                cryptos: searchedIds,
                isNewId: false,
                ref: ref,
              );
            } else {
              return const Center(child: Text("no result found"));
            }
          } else {
            if (cryptos.isNotEmpty){
              return ReorderableListViewWidget(
                ref: ref,
                cryptos: cryptos,
                onReorder: (oldIndex, newIndex) {
                  ref.watch(cryptoIdsProvider.notifier).swapIds(oldIndex, newIndex, cryptos[oldIndex]);
                }
              );
            } else {
              return const Center(
                child: Text(
                  SystemStrings.noCryptoAdded
                ),
              );
            }
          }
        } else {
          return const NoInternetWidget();
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
            return SimpleListViewWidget(
              cryptos: searchedIds,
              isNewId: true,
              ref: ref,
            );
          } else {
            return const Center(child: Text("no result found"));
          }
        } else {
          return SimpleListViewWidget(
            cryptos: cryptos,
            isNewId: true,
            ref: ref,
          );
        }
      },
    );
  }
}

class SimpleListViewWidget extends StatelessWidget {
  final WidgetRef ref;
  final List<CryptoIdModel> cryptos;
  final bool isNewId;
  const SimpleListViewWidget({
    Key? key,
    required this.cryptos,
    required this.isNewId,
    required this.ref
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isNewId) {
      print("building search list view");
      return ListView.builder(
        itemCount: cryptos.length,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return ListTileWidget(
            crypto: cryptos[index],
            isNewId: isNewId,
            price: PriceModel.blankModel,
          );
        },
      );
    } else {
      return FutureBuilder(
        future: APIService.getPrices(cryptos),
        builder: (BuildContext context, AsyncSnapshot<List<PriceModel>> snapshot) {
          if (snapshot.hasData) {
            final List<PriceModel> prices = snapshot.data!;
            return ListView.builder(
              itemCount: cryptos.length,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final CryptoIdModel currentCrypto = cryptos[index];
                final PriceModel currentPrice = prices[index];
                return Dismissible(
                  background: const DissmissibleBackgroundContainerWidget(),
                  key: ValueKey(currentCrypto),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    prices.removeAt(index);
                    ref.watch(cryptoIdsProvider.notifier).removeId(currentCrypto);
                  },
                  child: ListTileWidget(
                    crypto: currentCrypto,
                    isNewId: isNewId,
                    price: currentPrice
                  ),
                );
              },
            );
          } else {
            return const LoadingWidget();
          }
        },
      );
    }
  }
}

class ReorderableListViewWidget extends StatelessWidget {
  final List<CryptoIdModel> cryptos;
  final Function(int,int) onReorder;
  final WidgetRef ref;
  const ReorderableListViewWidget({
    Key? key,
    required this.cryptos,
    required this.onReorder,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: APIService.getPrices(cryptos),
      builder: (BuildContext context, AsyncSnapshot<List<PriceModel>> snapshot) {
        if (snapshot.hasData) {
          List<PriceModel> prices = snapshot.data!;
          return ReorderableListView.builder(
              physics: const ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final CryptoIdModel currentCrypto = cryptos[index];
                final PriceModel currentPrice = prices[index];
                return Dismissible(
                  background: const DissmissibleBackgroundContainerWidget(),
                  key: ValueKey(currentCrypto),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    prices.removeAt(index);
                    ref.watch(cryptoIdsProvider.notifier).removeId(currentCrypto);
                  },
                  child: ListTileWidget(
                    crypto: currentCrypto,
                    isNewId: false,
                    price: currentPrice
                  ),
                );
              },
              itemCount: cryptos.length,
              onReorder: (int oldIndex, int newIndex) {
                onReorder(oldIndex, newIndex);
                final int index = newIndex > oldIndex ? newIndex - 1 : newIndex;
                final PriceModel movedPrice = prices[oldIndex];
                prices.removeAt(oldIndex);
                prices.insert(index, movedPrice);
              }
          );
        } else {
          return const LoadingWidget();
        }
      },

    );

  }
}

