import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionRow extends StatelessWidget {
  final String questionText;
  final String actionText;
  final VoidCallback onTap;

  const OptionRow({
    super.key,
    required this.questionText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 7,
      children: [
        Text(
          questionText,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.yellow,
            ),
          ),
        ),
      ],
    );
  }
}