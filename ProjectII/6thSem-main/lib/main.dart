import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'core/app.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await HiveService().init();
  // //HiveService().deleteHive();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
