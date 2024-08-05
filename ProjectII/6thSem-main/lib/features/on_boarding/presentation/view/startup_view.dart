import 'package:flutter/material.dart';
import 'package:foodrush/core/common/globs.dart';
import 'package:foodrush/features/main_tabview/presentation/view/main_tabview.dart';
import 'package:foodrush/features/on_boarding/presentation/view/on_boarding_view.dart';
import 'package:lottie/lottie.dart';

class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StarupViewState();
}

class _StarupViewState extends State<StartupView> {
  @override
  void initState() {
    super.initState();
    goWelcomePage();
  }

  void goWelcomePage() async {
    await Future.delayed(const Duration(seconds: 3));
    welcomePage();
  }

  void welcomePage() {
    if (Globs.udValueBool(Globs.userLogin)) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainTabView()),
        (route) => false, // This predicate removes all previous routes
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const OnBoardingView()),
        (route) => false, // This predicate removes all previous routes
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          ColorFiltered(
            colorFilter: const ColorFilter.mode(
                Color.fromARGB(255, 247, 16, 0), BlendMode.srcIn),
            child: Image.asset(
              "assets/images/splash_bg.png",
              width: media.width,
              height: media.height,
              fit: BoxFit.cover,
            ),
          ),
          Lottie.asset(
            'assets/images/loading.json',
            width: media.width * 0.40,
            height: media.width * 0.40,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
