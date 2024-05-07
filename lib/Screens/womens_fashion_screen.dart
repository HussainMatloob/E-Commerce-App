import 'package:flutter/material.dart';

class WomensFashion extends StatefulWidget {
  const WomensFashion({super.key});

  @override
  State<WomensFashion> createState() => _WomensFashionState();
}

class _WomensFashionState extends State<WomensFashion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text("Womens Fashion"),),
      ),
    );
  }
}
