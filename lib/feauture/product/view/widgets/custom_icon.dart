import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.icon, this.onPressed, this.color});
  final IconData icon;
  final VoidCallback? onPressed; // وظيفة اختيارية
  final Color? color;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Color(0xFFFAF8F5),
      ),
      child: IconButton(
        onPressed: onPressed ?? () => Navigator.pop(context),
        // لو مبعتناش onPressed، هيعمل back تلقائي (زي أيقونة الرجوع)
        icon: Icon(
          icon,
          color:
              color ??
              const Color(0xff6D4C41), // لو مبعتناش لون، هياخد البني الافتراضي
        ),
      ),
    );
  }
}
