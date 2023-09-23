import 'package:cricket/core/sizing.dart';
import 'package:cricket/theme/app_styles.dart';
import 'package:cricket/widgets/custom_button.dart';
import 'package:cricket/widgets/custom_tff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class AddTeam extends ConsumerStatefulWidget {
  const AddTeam({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTeamState();
}

class _AddTeamState extends ConsumerState<AddTeam> {
  final firstTController = TextEditingController();
  final secondTController = TextEditingController();
  bool showSecondTextField = false;

  @override
  void dispose() {
    super.dispose();
    firstTController.dispose();
    secondTController.dispose();
  }

  void navigateToToss() {
    Routemaster.of(context).push('toss-screen');
  }

  @override
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
                child: Padding(
                  padding: getPadding(all: 30),
                  child: CustomTextField(
                    hintText: showSecondTextField
                        ? 'Enter second Team Name'
                        : 'Enter first Team Name',
                    controller: showSecondTextField
                        ? secondTController
                        : firstTController,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: getPadding(left: 40),
            child: showSecondTextField
                ? CustomButton(
                    width: getHorizontalSize(90),
                    height: getVerticalSize(40),
                    onPressed: () {
                      setState(() {
                        if (showSecondTextField) {
                          // Switch to the second text field
                          showSecondTextField = false;
                        } else {
                          // Perform your action when both team names are entered
                          // For example, navigate to the next page
                          // You can add your navigation logic here
                        }
                      });
                    },
                    text: 'BACK')
                : const SizedBox(),
          ),
          CustomButton(
            width: getHorizontalSize(90),
            height: getVerticalSize(40),
            onPressed: () {
              setState(() {
                if (!showSecondTextField && firstTController.text.isNotEmpty) {
                  // Switch to the second text field
                  showSecondTextField = true;
                } else if (secondTController.text.isNotEmpty &&
                    firstTController.text.isNotEmpty) {
                  // Perform your action when both team names are entered
                  // For example, navigate to the next page
                  // You can add your navigation logic here
                  navigateToToss();
                }
              });
            },
            text: showSecondTextField ? 'SUBMIT' : 'NEXT',
          )
        ],
      ),
    );
  }
}
