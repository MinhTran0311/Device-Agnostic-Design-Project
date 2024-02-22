import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      backgroundColor: Colors.amber,
    );
  }
}
