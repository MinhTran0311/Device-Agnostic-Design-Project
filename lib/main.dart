import 'package:flutter/material.dart';
import 'package:flutter_application_1/injection_setup.dart';
import 'package:flutter_application_1/routes/router.dart';

main() async {
  await initializeDependencies();

  runApp(MaterialApp.router(routerConfig: router));
}
