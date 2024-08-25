import 'package:flutter/material.dart';

class BuyandSell extends StatefulWidget {
  const BuyandSell({super.key});

  @override
  State<BuyandSell> createState() => _BuyandSellState();
}

class _BuyandSellState extends State<BuyandSell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 219, 219),
      appBar: AppBar(
        toolbarHeight: 100,
      ),
    );
  }
}
