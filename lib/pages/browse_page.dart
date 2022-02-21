import 'package:crypto_tracker/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(isHome: false),
    );
  }
}
