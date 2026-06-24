import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:masterhand/main.dart';

void main() {
  testWidgets('App inicializa sem erros', (WidgetTester tester) async {
    await tester.pumpWidget(const MasterHandApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
