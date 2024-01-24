import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

main() {
  final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (context, state) => const ButtonScreen('/')),
    GoRoute(
        path: '/:first',
        builder: (context, state) =>
            ButtonScreen('/${state.pathParameters['first']!}/')),
    GoRoute(
        path: '/:first/:second',
        builder: (context, state) => SumScreen(
            state.pathParameters['first']!, state.pathParameters['second']!))
  ]);

  runApp(MaterialApp.router(routerConfig: router));
}

class ButtonScreen extends StatelessWidget {
  final String pathPrefix;
  const ButtonScreen(this.pathPrefix);

  @override
  Widget build(BuildContext context) {
    List<ElevatedButton> buttons = [];
    for (int i = 1; i < 6; i++) {
      buttons.add(ElevatedButton(
          onPressed: () => context.go('$pathPrefix$i'), child: Text("$i")));
    }

    return Column(children: buttons);
  }
}

class SumScreen extends StatelessWidget {
  final String first;
  final String second;

  const SumScreen(this.first, this.second);
  @override
  Widget build(BuildContext context) {
    int f = int.parse(first);
    int s = int.parse(second);

    return FutureBuilder<int>(
        future: SumApi().sum(f, s),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Retrieving sum");
          } else if (snapshot.hasError) {
            return Text("Error retrieving sum: ${snapshot.error}");
          } else if (!snapshot.hasData) {
            return const Text("No data.");
          } else {
            int sum = snapshot.data!;
            return Text('$f + $s = $sum');
          }
        });
  }
}

class SumApi {
  Future<int> sum(int first, int second) async {
    var response = await http.post(
      Uri.parse('https://fitech-api.deno.dev/sum-api'),
      body: jsonEncode({'one': first, 'two': second}),
    );

    var data = jsonDecode(response.body);
    return data['sum'];
  }
}
