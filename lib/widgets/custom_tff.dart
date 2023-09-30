import 'package:cricket/theme/color_constant.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  void Function(String)? onChanged;
   CustomTextField(
      {super.key, required this.hintText, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: IconButton(
            onPressed: () {
              controller!.clear();
            },
            icon: const Icon(
              Icons.clear,
              color: Color.fromARGB(255, 169, 12, 1),
            )),
        prefixIcon: const Icon(
          Icons.sports_cricket,
          color: Color.fromARGB(255, 169, 12, 1),
        ),
        filled: true,
        fillColor: ColorConstant.cricketPitchColor, // Cricket pitch color
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorConstant.whiteA700), // Border color when pressed
        ),
      ),
    );
  }
}
