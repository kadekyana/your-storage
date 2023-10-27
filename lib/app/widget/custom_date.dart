import 'package:flutter/material.dart';

class SuffixIconTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Widget icon;
  final void Function() onTap;
  const SuffixIconTextField(
      {super.key,
      required this.onTap,
      required this.hintText,
      required this.controller,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      readOnly: true,
      controller: controller,
      showCursor: false,
      style: TextStyle(fontFamily: 'Poppins'),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        hintText: hintText,
        hintStyle: TextStyle(fontFamily: 'Poppins'),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: icon,
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
