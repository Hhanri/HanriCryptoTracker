import 'package:crypto_tracker/models/crypto_id_model.dart';
import 'package:crypto_tracker/porviders/providers.dart';
import 'package:crypto_tracker/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final bool counter = ref.watch(timerProvider.select((value) => value.changed));
        final List<CryptoIdModel> cryptos = ref.watch(cryptoIdsProvider);
        ref.watch(cryptoIdsProvider.notifier).setPrices();
        print(ref.watch(cryptoIdsProvider));
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
    return ReorderableListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTileWidget(
          crypto: cryptos[index],
          key: ValueKey(cryptos[index].id + cryptos[index].name + cryptos[index].price.toString()),
        );
      },
      itemCount: cryptos.length,
      onReorder: (int oldIndex, int newIndex) {
        onReorder(oldIndex, newIndex);
      }
    );
  }
}

