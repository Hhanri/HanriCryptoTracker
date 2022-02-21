import 'package:crypto_tracker/models/crypto_id_model.dart';
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final CryptoIdModel crypto;
  const ListTileWidget({
    Key? key,
    required this.crypto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(crypto.id),
      trailing: PriceDisplayWidget(
        cryptoPrice: crypto.price,
        cryptoPriceChange: crypto.priceChange,
      ),
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

