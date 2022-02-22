import 'package:crypto_tracker/models/crypto_id_model.dart';
import 'package:crypto_tracker/porviders/providers.dart';
import 'package:crypto_tracker/services/api_service.dart';
import 'package:crypto_tracker/widgets/app_bar_widget.dart';
import 'package:crypto_tracker/widgets/list_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return WillPopScope(
          onWillPop: () async {
            ref.watch(searchIdProvider.notifier).openSearchBar();
            return false;
          },
          child: Scaffold(
            appBar: const AppBarWidget(isHome: false),
            body: FutureBuilder<List<CryptoIdModel>>(
              future: APIService.getAllCoins(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return BrowseListViewWidget(cryptos: snapshot.data!);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
            ),
          ),
        );
      }
    );
  }
}
