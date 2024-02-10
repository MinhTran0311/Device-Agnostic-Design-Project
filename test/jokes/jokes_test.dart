import 'package:test/test.dart';

import '../../lib/jokes/jokes.dart';

void main() {
  test('Check the question is not orange', () async {
    expect(
        JokeRepository.randomJoke() !=
            "What's orange and sounds like a parrot?",
        true);
  });
}
