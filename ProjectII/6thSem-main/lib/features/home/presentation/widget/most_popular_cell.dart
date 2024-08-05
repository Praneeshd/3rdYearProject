import 'package:flutter/material.dart';
import 'package:foodrush/config/constants/theme_constant.dart';

class MostPopularCell extends StatelessWidget {
  final Map mObj;
  final VoidCallback onTap;
  const MostPopularCell({super.key, required this.mObj, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                mObj["foodImageUrl"].toString(),
                width: 220,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              mObj["foodName"],
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ThemeConstant.primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  mObj["foodCategory"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ThemeConstant.secondaryText, fontSize: 12),
                ),
                const Text(
                  " . ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ThemeConstant.primaryColor, fontSize: 12),
                ),
                Text(
                  mObj["foodDescription"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ThemeConstant.secondaryText, fontSize: 12),
                ),
                const SizedBox(
                  width: 8,
                ),
                // Image.asset(
                //   "assets/images/rate.png",
                //   width: 10,
                //   height: 10,
                //   fit: BoxFit.cover,
                // ),
                // const SizedBox(
                //   width: 4,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
