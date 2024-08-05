import 'package:flutter/material.dart';
import 'package:foodrush/config/constants/theme_constant.dart';

class TabButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String icon;
  final bool isSelected;
  const TabButton({super.key, required this.title, required this.icon , required this.onTap, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 15,
            height: 15,
            color: isSelected ? ThemeConstant.primaryColor : ThemeConstant.placeholder,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? ThemeConstant.primaryColor :   ThemeConstant.placeholder,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}