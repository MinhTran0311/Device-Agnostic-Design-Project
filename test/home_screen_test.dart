// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/screens/home/home_screen.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:nock/nock.dart';

// void main() {
//   setUpAll(() {
//     nock.init();
//   });

//   setUp(() {
//     nock.cleanAll();
//   });

//   testWidgets("HomeScreen displays topics from API.", (tester) async {
//     await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
//     final helloWorldFinder = find.text('Hello world!');
//     expect(helloWorldFinder, findsOneWidget);
//   });
// }

import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:nock/nock.dart';

void main() {
  setUpAll(() {
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  test("example", () async {
    final interceptor = nock("http://localhost/api").get("/users")
      ..reply(
        200,
        "result",
      );

    var url = Uri.parse('https://example.com');

    final response = await http.get(url);

    expect(interceptor.isDone, true);
    expect(response.statusCode, 200);
    expect(response.body, "result");
  });
}
