import 'package:flutter/material.dart';

class MensFashion extends StatefulWidget {
  const MensFashion({super.key});

  @override
  State<MensFashion> createState() => _MensFashionState();
}

class _MensFashionState extends State<MensFashion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text("Mens Fashion"),),
      ),
    );
  }
}
