import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({
    this.onChanged,
    super.key,
    this.hintText,
    this.obscureText = false,
  });
  String? hintText;
  bool? obscureText;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * .025,
      ),
      child: TextFormField(
        obscureText: obscureText!,
        validator: (data) {
          if (data!.isEmpty) {
            return 'field is required';
          }
        },
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(Icons.email_outlined, color: Colors.brown),
          hintStyle: TextStyle(
            color: const Color(0xFFBCAAA4),
            fontSize: 13,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffBCAAA4)),
            borderRadius: BorderRadius.circular(18),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffBCAAA4)),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
