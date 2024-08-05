import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/config/router/app_route.dart';
import 'package:foodrush/config/themes/app_theme.dart';
import 'package:foodrush/core/common/provider/is_dark_theme.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watching the theme state from Riverpod
    final isDarkTheme = ref.watch(isDarkThemeProvider);

    // Khalti Public Key, replace with your own key for production
    const String khaltiPublicKey =
        "test_public_key_3c7363ddf621449a85055ddea0d51811";

    return KhaltiScope(
      publicKey: khaltiPublicKey,
      enabledDebugging: true, // Set to false in production
      builder: (context, navKey) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food Rush',
          theme: AppTheme.getApplicationTheme(
              isDarkTheme), // Using the dynamic theme based on the 'isDarkTheme' flag
          initialRoute:
              AppRoute.splashRoute, // Assuming you have a splash screen set up
          routes: AppRoute.getApplicationRoute(), // Your application routes
          navigatorKey: navKey, // Navigator key required by Khalti
          localizationsDelegates: const [
            KhaltiLocalizations.delegate,
          ],
        );
      },
    );
  }
}
