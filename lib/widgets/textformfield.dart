import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Textformfield extends StatelessWidget {
  const Textformfield({
    super.key,
    required this.hinttext,
    this.obsecure = false,
    required this.bordercolor,
    required this.prefixicon,
    required this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.done,
    this.controller,
  });

  final String hinttext;
  final bool obsecure;
  final Color bordercolor;
  final String prefixicon;
  final FocusNode focusNode;
  final TextEditingController? controller;
  final Function(String)? onFieldSubmitted;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obsecure,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return "Field is required";
          }
          return null;
        },
        style: const TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: const Color(0xFFF3F1F7),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              prefixicon,
              width: 18,
              height: 18,
              fit: BoxFit.contain,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: bordercolor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: bordercolor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Color(0xFF2260FF), width: 1.5),
          ),
        ),
      ),
    );
  }
}
