import 'package:cricket/core/sizing.dart';
import 'package:cricket/theme/app_styles.dart';
import 'package:cricket/theme/color_constant.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  

  final void Function()? onPressed;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.width,
    required this.height,
    
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getHorizontalSize(width),
      height: getVerticalSize(height),
      child: TextButton(
        
        
          style: ButtonStyle(
              
              backgroundColor:
                  MaterialStatePropertyAll(ColorConstant.cricketPitchColor)),
          onPressed: onPressed,
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.txtPoppinsMedium18Black900,
          )),
    );
  }
}
