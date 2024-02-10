import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countProvider = StateProvider<int>((ref) => 0);

class CountWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int count = ref.watch(countProvider);
    return ElevatedButton(
      onPressed: () =>
          ref.watch(countProvider.notifier).update((state) => state + 1),
      child: Text('$count'),
    );
  }
}
