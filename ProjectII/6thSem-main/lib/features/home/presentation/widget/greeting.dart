import 'package:flutter/widgets.dart';
import 'package:foodrush/config/constants/theme_constant.dart';

Widget greeting() {
  DateTime now = DateTime.now();
  int hour = now.hour;

  if (hour >= 0 && hour < 12) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Good morning!",
              style: TextStyle(
                  color: ThemeConstant.primaryText,
                  fontSize: 20,
                  fontFamily: 'Times New Roman',
                  fontWeight: FontWeight.w800),
            ),
            Image.asset(
              "assets/images/night.png",
              width: 30,
              height: 30,
            ),
          ],
        ),
        const Text(
          "User",
          style: TextStyle(
              fontSize: 15,
              fontFamily: 'Times New Roman',
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  } else {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Good Night!",
              style: TextStyle(
                  color: ThemeConstant.primaryText,
                  fontSize: 20,
                  fontFamily: 'Times New Roman',
                  fontWeight: FontWeight.w800),
            ),
            Image.asset(
              "assets/images/night.png",
              width: 30,
              height: 30,
            ),
          ],
        ),
        const Text(
          "User",
          style: TextStyle(
              fontSize: 15,
              fontFamily: 'Times New Roman',
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
