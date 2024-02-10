import 'package:test/test.dart';

import '../lib/fun.dart';

void main() {
  test('Calling fun() returns "Testing is fun".', () async {
    expect(fun(), "Testing is fun");
  });
  test('Calling sum(40,2) returns 42.', () async {
    expect(sum(40, 2), 42);
  });
}
