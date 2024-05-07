import 'package:flutter/material.dart';
class WatchesScreen extends StatefulWidget {
  const WatchesScreen({super.key});

  @override
  State<WatchesScreen> createState() => _WatchesScreenState();
}

class _WatchesScreenState extends State<WatchesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text("Watches"),),
      ),
    );
  }
}
