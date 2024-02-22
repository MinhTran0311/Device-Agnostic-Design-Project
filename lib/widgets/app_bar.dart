import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackGroundAndAppBar extends StatelessWidget {
  const BackGroundAndAppBar(
      {super.key, required this.body, this.isHomePage = false});
  final bool isHomePage;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: body),
      appBar: AppBar(
        title: const Text('Quizzzz'),
        backgroundColor: Color(0xFF40A2E3),
        automaticallyImplyLeading: false,
        actions: [
          !isHomePage
              ? IconButton(
                  onPressed: () => context.go("/"),
                  icon: const Icon(Icons.home))
              : const SizedBox.shrink(),
          IconButton(
              onPressed: () => context.go("/statistic"),
              icon: const Icon(Icons.align_vertical_bottom))
        ],
      ),
    );
  }
}
