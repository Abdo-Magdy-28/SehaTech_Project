import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Textformfield extends StatefulWidget {
  Textformfield({
    super.key,
    required this.hinttext,
    this.obsecure = false,
    required this.bordercolor,
    required this.prefixicon,
    required this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.done,
    this.controller,
    this.validator,
    this.ispassword = false,
  });
  final String? Function(String?)? validator;
  final String hinttext;
  bool obsecure;
  final bool ispassword;
  final Color bordercolor;
  final String prefixicon;
  final FocusNode focusNode;
  final TextEditingController? controller;
  final Function(String)? onFieldSubmitted;
  final TextInputAction textInputAction;

  @override
  State<Textformfield> createState() => _TextformfieldState();
}

class _TextformfieldState extends State<Textformfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        focusNode: widget.focusNode,
        obscureText: widget.obsecure,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        style: const TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          hintText: widget.hinttext,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: const Color(0xFFF3F1F7),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              widget.prefixicon,
              width: 18,
              height: 18,
              fit: BoxFit.contain,
            ),
          ),

          suffixIcon: widget.ispassword
              ? GestureDetector(
                  onTap: () {
                    widget.obsecure = !widget.obsecure;
                    setState(() {});
                  },
                  child: widget.obsecure
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset("assets/images/shape.svg"),
                        )
                      : Icon(Icons.remove_red_eye_outlined),
                )
              : null,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: widget.bordercolor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: widget.bordercolor),
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
