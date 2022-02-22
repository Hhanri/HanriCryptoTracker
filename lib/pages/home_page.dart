import 'package:crypto_tracker/resources/strings.dart';
import 'package:crypto_tracker/widgets/app_bar_widget.dart';
import 'package:crypto_tracker/widgets/list_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(isHome: true),
      body: HomeListViewWidget(),
      //bottomSheet: BottomSheetWidget(),
    );
  }
}

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: InkWell(
            onTap: () => launch(SystemStrings.creditUrl),
            child: const Text(SystemStrings.creditTitle)
          ),
        ),
      ],
    );
  }
}