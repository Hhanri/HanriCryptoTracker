import 'package:crypto_tracker/resources/strings.dart';
import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        SystemStrings.noInternetTitle
      ),
    );
  }
}
