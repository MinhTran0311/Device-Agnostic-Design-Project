import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListDataNotifier extends StateNotifier<List<String>> {
  final SharedPreferences prefs;
  ListDataNotifier(this.prefs) : super([]);

  _initialize() async {
    if (prefs.containsKey('data')) {
      state = prefs.getStringList('data')!;
    }
  }

  addItem() async {
    state = [...state, "${state.length + 1}"];
    prefs.setStringList('data', state);
  }
}

final listDataProvider =
    StateNotifierProvider<ListDataNotifier, List<String>>((ref) {
  final ld = ListDataNotifier(ref.watch(sharedPreferencesProvider));
  ld._initialize();
  return ld;
});

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

main() async {
  final prefs = await SharedPreferences.getInstance();

  runApp(ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
    child: ListApp(),
  ));
}

class ListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            AddWidget(),
            ListWidget(),
          ],
        ),
      ),
    );
  }
}

class AddWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(listDataProvider);

    return ElevatedButton(
      onPressed: () => ref.watch(listDataProvider.notifier).addItem(),
      child: Text('Items: ${list.length}'),
    );
  }
}

class ListWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(listDataProvider);
    return Column(
      children: list.map((item) => Text(item)).toList(),
    );
  }
}
