import 'package:cricket/core/sizing.dart';
import 'package:cricket/theme/app_styles.dart';
import 'package:cricket/widgets/custom_button.dart';
import 'package:cricket/widgets/custom_tff.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class OverScreen extends StatefulWidget {
  const OverScreen({super.key});

  @override
  State<OverScreen> createState() => _OverScreenState();
}

class _OverScreenState extends State<OverScreen> {
  final oversController = TextEditingController();

  void navigateToChoose() {
    Routemaster.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: getPadding(all: 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: getVerticalSize(300),
              width: getHorizontalSize(350),
              color: Colors.green,
              child: Padding(
                padding: getPadding(left: 30, right: 30, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'OVERS',
                      style: AppStyle.txtPoppinsMedium18WhiteA700,
                    ),
                    CustomTextField(
                      onPressedofSuffixIcon: () {
                        setState(() {
                          oversController.clear();
                        });
                      },
                      inputType: TextInputType.number,
                      hintText: 'Enter the no of overs',
                      controller: oversController,
                      onChanged: (value) {
                        setState(
                            () {}); // Trigger a rebuild when the text changes
                      },
                    ),
                    SizedBox(
                      height: getVerticalSize(12),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          onPressed: () {
                            setState(() {
                              oversController.text = 10.toString();
                            });
                          },
                          text: "10",
                          width: getHorizontalSize(50),
                          height: getVerticalSize(50),
                        ),
                        CustomButton(
                          onPressed: () {
                            setState(() {
                              oversController.text = 15.toString();
                            });
                          },
                          text: "15",
                          width: getHorizontalSize(50),
                          height: getVerticalSize(50),
                        ),
                        CustomButton(
                          onPressed: () {
                            setState(() {
                              oversController.text = 20.toString();
                            });
                          },
                          text: "20",
                          width: getHorizontalSize(50),
                          height: getVerticalSize(50),
                        ),
                        CustomButton(
                          onPressed: () {
                            setState(() {
                              oversController.text = 40.toString();
                            });
                          },
                          text: "40",
                          width: getHorizontalSize(50),
                          height: getVerticalSize(50),
                        ),
                        CustomButton(
                          onPressed: () {
                            setState(() {
                              oversController.text = 50.toString();
                            });
                          },
                          text: "50",
                          width: getHorizontalSize(50),
                          height: getVerticalSize(50),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getVerticalSize(70),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          onPressed: () {
                            navigateToChoose();
                          },
                          text: 'BACK',
                          width: getHorizontalSize(80),
                          height: getVerticalSize(40),
                        ),
                        if (oversController.text.isNotEmpty)
                          CustomButton(
                            onPressed: () {},
                            text: 'NEXT',
                            width: getHorizontalSize(80),
                            height: getVerticalSize(40),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
