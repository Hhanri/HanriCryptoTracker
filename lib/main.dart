import 'package:crypto_tracker/models/crypto_id_model.dart';
import 'package:crypto_tracker/porviders/providers.dart';
import 'package:crypto_tracker/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp()
    )
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref.watch(timerProvider.notifier).start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          ref.watch(cryptoIdsProvider.notifier).setPrices();
          bool counter = ref.watch(timerProvider.select((value) => value.changed));
          final List<CryptoIdModel> cryptos = ref.watch(cryptoIdsProvider);
          if (cryptos.isNotEmpty){
            return ListView.builder(
              itemCount: cryptos.length,
              itemBuilder: (BuildContext context, int index) {
                final CryptoIdModel currentCrypto = cryptos[index];
                return ListTileWidget(crypto: currentCrypto);
              },
            );
          } else {
            return const Center(
              child: Text(
                "no crypto added"
              ),
            );
          }
        }
      )
    );
  }
}
