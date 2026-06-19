import 'package:flutter/material.dart';

class UploadBox extends StatelessWidget {
  const UploadBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        // إضافة إطار عادي بلون متناسق
        border: Border.all(color: const Color(0xFFD7CCC8), width: 1.5),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.camera_alt_outlined, color: Color(0xFFC9A875), size: 40),
          SizedBox(height: 8),
          Text(
            "Upload Photo",
            style: TextStyle(
              color: const Color(0xFF6D4C41),
              fontSize: 12.25,
              fontFamily: 'Arimo',
              fontWeight: FontWeight.w600,
              height: 1.43,
            ),
          ),
        ],
      ),
    );
  }
}
