import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../lib/count_widget.dart';

void main() {
  testWidgets("CountWidget initial value is 0.", (tester) async {
    final myApp = ProviderScope(child: MaterialApp(home: CountWidget()));
    await tester.pumpWidget(myApp);

    final zeroCountFinder = find.text('0');
    expect(zeroCountFinder, findsOneWidget);
  });

  testWidgets("Value is 1 when the button is pressed once.", (tester) async {
    final myApp = ProviderScope(child: MaterialApp(home: CountWidget()));
    await tester.pumpWidget(myApp);

    await tester.tap(find.text('0'));
    await tester.pumpAndSettle();

    expect(find.text('1'), findsOneWidget);
  });
}
