import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MasterHand')),
      body: const Center(child: Text('Catálogo de sistemas de RPG')),
    );
  }
}
