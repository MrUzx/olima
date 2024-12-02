import 'package:document_sent/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedbutton extends StatelessWidget {
  Function? onPressed;
  final height, width;
  String title;
  Color color;

  CustomElevatedbutton({
    super.key,
    required this.onPressed,
    this.height,
    this.width,
    required this.title,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          onPressed!(); // Bu yerda onPressed funksiyasini chaqiryapmiz
        },
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)
        ),
      ),
    );
  }
}
