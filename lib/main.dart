import 'dart:async';

import 'package:app/views/app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) async {
    // reportError(details);

    debugPrint('>>> ${details.toString()}');

    // await test();
  };

  runApp(App());
}
