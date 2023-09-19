import 'package:cricket/core/sizing.dart';
import 'package:cricket/theme/app_styles.dart';
import 'package:cricket/widgets/custom_tff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTeam extends ConsumerWidget {
  const AddTeam({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstTController = TextEditingController();
    final secondTController = TextEditingController();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipOval(
              child: Container(
                height: getHorizontalSize(350),
                width: getVerticalSize(500),
                color: Colors.green,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: CustomTextField(
                      hintText: 'Enter your Team Name',
                      controller: firstTController,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: TextButton(
          onPressed: () {},
          child: Text(
            'NEXT',
            style: AppStyle.txtPoppinsMedium18Black900,
          ),
        ));
  }
}
