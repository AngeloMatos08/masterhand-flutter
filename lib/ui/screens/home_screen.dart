import 'package:flutter/material.dart';
import 'test_systems_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MasterHand')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Catálogo de sistemas de RPG'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TestSystemsScreen(),
                  ),
                );
              },
              child: const Text('Ver Sistemas (Teste)'),
            ),
          ],
        ),
      ),
    );
  }
}

