import 'package:flutter/material.dart';
import 'package:foodrush/config/constants/theme_constant.dart';

class ViewAllTitleRow extends StatelessWidget {
  final String title;
  final VoidCallback onView;
  const ViewAllTitleRow({super.key, required this.title, required this.onView});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: ThemeConstant.primaryText,
              fontSize: 20,
              fontWeight: FontWeight.w800),
        ),
        TextButton(
          onPressed: onView,
          child: const Text(
            "View all",
            style: TextStyle(
                color: ThemeConstant.primaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
