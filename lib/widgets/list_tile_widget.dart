import 'package:crypto_tracker/models/crypto_id_model.dart';
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final CryptoIdModel crypto;
  const ListTileWidget({Key? key, required this.crypto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(crypto.id),
      trailing: PriceDisplayWidget(crypto: crypto),
    );
  }
}

class PriceDisplayWidget extends StatelessWidget {
  final CryptoIdModel crypto;
  const PriceDisplayWidget({Key? key, required this.crypto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          Text(
            "${crypto.price.toStringAsFixed(2)} \$",
            style: TextStyle(
              color: crypto.priceChange.isNegative ? Colors.red : Colors.green
            ),
          ),
          Icon(
            crypto.priceChange.isNegative ? Icons.arrow_drop_down : Icons.arrow_drop_up,
            color: crypto.priceChange.isNegative ? Colors.red : Colors.green,
          )
        ],
      ),
    );
  }
}

