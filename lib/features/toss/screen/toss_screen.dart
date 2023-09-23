import 'package:cricket/core/sizing.dart';
import 'package:cricket/theme/app_styles.dart';
import 'package:cricket/theme/color_constant.dart';
import 'package:cricket/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class TossScreen extends ConsumerStatefulWidget {
  const TossScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TossScreenState();
}

class _TossScreenState extends ConsumerState<TossScreen> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: getPadding(all: 12),
          child: ClipOval(
            child: Container(
              height: getHorizontalSize(350),
              width: getVerticalSize(500),
              color: Colors.green,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isSelected ? 'Choose to' : 'Toss Won By',
                    style: AppStyle.txtPoppinsMedium18WhiteA700,
                  ),
                  Padding(
                    padding: getPadding(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isSelected
                            ? TextButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.sports_cricket_rounded,
                                  color: ColorConstant.red,
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        ColorConstant.cricketPitchColor)),
                                label: Text(
                                  'Batting',
                                  style: AppStyle.txtPoppinsMedium18Black900,
                                ))
                            : CustomButton(
                                onPressed: () {
                                  setState(() {
                                    isSelected = true;
                                  });
                                },
                                text: 'TeamA',
                                width: getHorizontalSize(100),
                                height: getVerticalSize(50),
                              ),
                        isSelected
                            ? TextButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.sports_baseball_rounded,
                                  color: ColorConstant.red,
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        ColorConstant.cricketPitchColor)),
                                label: Text(
                                  'Bowling',
                                  style: AppStyle.txtPoppinsMedium18Black900,
                                ))
                            : CustomButton(
                                onPressed: () {
                                  setState(() {
                                    isSelected = true;
                                  });
                                },
                                text: 'TeamB',
                                width: getHorizontalSize(100),
                                height: getVerticalSize(50),
                              ),
                      ],
                    ),
                  )
                ],
              )),
            ),
          ),
        ),
      ),
      floatingActionButton: isSelected
          ? Padding(
              padding: getPadding(left: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomButton(
                      onPressed: () {
                        setState(() {
                          isSelected = false;
                        });
                      },
                      text: 'BACK',
                      width: getHorizontalSize(90),
                      height: getVerticalSize(40)),
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
