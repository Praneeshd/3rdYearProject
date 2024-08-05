import 'package:foodrush/features/auth/presentation/view/login_screen_view.dart';
import 'package:foodrush/features/auth/presentation/view/register_screen_view.dart';
import 'package:foodrush/features/forgetpassword/presentation/view/change_password_screen_view.dart';
import 'package:foodrush/features/forgetpassword/presentation/view/code_screen_view.dart';
import 'package:foodrush/features/forgetpassword/presentation/view/sendemail_screen_view.dart';
import 'package:foodrush/features/main_tabview/presentation/view/main_tabview.dart';
import 'package:foodrush/features/more/presentaion/view/payment_view.dart';
import 'package:foodrush/features/splash/presentation/view/splash1_views.dart';
import 'package:foodrush/features/splash/presentation/view/splash_screen_view.dart';
import 'package:foodrush/features/splash/presentation/view/welcome_screen_view.dart';

class AppRoute {
  AppRoute._();
  static const String splashRoute = '/';
  static const String splash2Route = '/splash';
  static const String frontRoute = '/front';
  static const String loginRoute = '/login';
  static const String registerRoute = '/create';
  static const String homeRoute = '/home';
  static const String sendemailRoute = '/sendemail';
  static const String codeRoute = '/code';
  static const String changepasswordRoute = '/changepassword';
  static const String paymentRoute = '/payment';

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashView(),
      splash2Route: (context) => const SplashScreen(),
      frontRoute: (context) => const WelcomeView(),
      loginRoute: (context) => const LoginScreen(),
      registerRoute: (context) => const RegisterScreen(),
      homeRoute: (context) => const MainTabView(),
      sendemailRoute: (context) => const SendEmailScreenView(),
      codeRoute: (context) => const CodeEntryScreenView(),
      changepasswordRoute: (context) => const ChangePasswordScreen(),
      paymentRoute: (context) => const PaymentView(),
    };
  }
}
