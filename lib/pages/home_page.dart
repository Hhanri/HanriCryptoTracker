import 'package:crypto_tracker/widgets/app_bar_widget.dart';
import 'package:crypto_tracker/widgets/list_view_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(isHome: true),
      body: HomeListViewWidget()
    );
  }
}