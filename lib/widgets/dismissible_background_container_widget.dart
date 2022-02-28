import 'package:flutter/material.dart';

class DissmissibleBackgroundContainerWidget extends StatelessWidget {
  const DissmissibleBackgroundContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerRight,
      color: Colors.red,
      child: const Icon(Icons.delete_forever, color: Colors.white,),
    );
  }
}
