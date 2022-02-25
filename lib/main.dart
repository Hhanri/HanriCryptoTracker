import 'package:crypto_tracker/pages/home_page.dart';
import 'package:crypto_tracker/providers/providers.dart';
import 'package:crypto_tracker/resources/strings.dart';
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
      ref.watch(cryptoIdsProvider.notifier).loadInitialState();
      ref.watch(timerProvider.notifier).start();
      ref.watch(connectivityProvider.notifier).startListeningConnectivityState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: SystemStrings.appTitle,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
