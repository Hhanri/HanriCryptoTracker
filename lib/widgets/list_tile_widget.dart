import 'package:crypto_tracker/models/crypto_id_model.dart';
import 'package:crypto_tracker/porviders/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListTileWidget extends StatelessWidget {
  final CryptoIdModel crypto;
  final bool isNewId;
  const ListTileWidget({
    Key? key,
    required this.crypto,
    required this.isNewId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: BuildLogo(url: crypto.logo),
      title: Text(crypto.id),
      trailing: isNewId
        ? AddNewCryptoButtonWidget(crypto: crypto)
        : PriceDisplayWidget(
            cryptoPrice: crypto.price,
            cryptoPriceChange: crypto.priceChange,
          )
    );
  }
}

class BuildLogo extends StatelessWidget {
  final String url;
  const BuildLogo({
    Key? key, 
    required this.url
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool hasUrl = url.isNotEmpty;
    final bool isSvg = url.endsWith(".svg");
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 15,
      child: hasUrl
        ? isSvg
          ? SvgPicture.network(url)
          : Image.network(url)
        : Container(),
    );
  }
}


class PriceDisplayWidget extends StatelessWidget {
  final double cryptoPrice;
  final double cryptoPriceChange;
  const PriceDisplayWidget({
    Key? key,
    required this.cryptoPrice,
    required this.cryptoPriceChange
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          Text(
            "${cryptoPrice.toStringAsFixed(2)} \$",
            style: TextStyle(
              color: cryptoPriceChange.isNegative ? Colors.red : Colors.green
            ),
          ),
          Icon(
            cryptoPriceChange.isNegative ? Icons.arrow_drop_down : Icons.arrow_drop_up,
            color: cryptoPriceChange.isNegative ? Colors.red : Colors.green,
          )
        ],
      ),
    );
  }
}

class AddNewCryptoButtonWidget extends StatelessWidget {
  final CryptoIdModel crypto;
  const AddNewCryptoButtonWidget({
    Key? key,
    required this.crypto
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return IconButton(
          onPressed: () {
            ref.watch(cryptoIdsProvider.notifier).addId(crypto);
          },
          icon: const Icon(Icons.add)
        );
      }
    );
  }
}
