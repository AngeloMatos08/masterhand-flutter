import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/local/app_database.dart';
import 'logic/favorites_provider.dart';
import 'ui/screens/home_screen.dart';

void main() {
  runApp(const MasterHandApp());
}

class MasterHandApp extends StatelessWidget {
  const MasterHandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDatabase>(
          create: (_) => AppDatabase(),
          dispose: (_, db) => db.close(),
        ),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: MaterialApp(
        title: 'MasterHand',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5C3D2E)),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
