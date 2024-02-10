import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/screens/home_screen.dart';
import '../lib/jokes_app.dart';

void main() {
  testWidgets("JokesApp shows HomeScreen at start.", (tester) async {
    await tester.pumpWidget(JokesApp());
    final homeScreenFinder = find.byType(HomeScreen);
    expect(homeScreenFinder, findsOneWidget);
  });
}
