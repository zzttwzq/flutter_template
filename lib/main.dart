import 'package:app/views/app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) async {
    debugPrint('>>> ${details.toString()}');
  };

  runApp(App());
}
