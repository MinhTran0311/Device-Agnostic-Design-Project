import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/hello_world_widget.dart';

void main() {
  testWidgets("HelloWorldWidget displays 'Hello world!'.", (tester) async {
    await tester.pumpWidget(MaterialApp(home: HelloWorldWidget()));
    final helloWorldFinder = find.text('Hello world!');
    expect(helloWorldFinder, findsOneWidget);
  });
}
