import 'package:flutter/material.dart';

class SettingsGroup extends StatelessWidget {
  final String header;
  final List<Widget> items;

  const SettingsGroup({super.key, required this.header, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, bottom: 8, top: 16),
          child: Text(
            header,
            style: TextStyle(
              color: const Color(0xFF3E2723),
              fontSize: 14,
              fontFamily: 'Arimo',
              fontWeight: FontWeight.w600,
              height: 1.50,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 2), // تحكم في اتجاه الظل
              ),
            ],
          ),
          child: Column(children: items),
        ),
      ],
    );
  }
}
