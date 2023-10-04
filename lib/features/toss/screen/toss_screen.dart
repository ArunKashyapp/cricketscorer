import 'package:cricket/core/sizing.dart';
import 'package:cricket/features/toss/repository/toss_repository.dart';
import 'package:cricket/theme/app_styles.dart';
import 'package:cricket/theme/color_constant.dart';
import 'package:cricket/widgets/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class TossScreen extends ConsumerStatefulWidget {
  final String teamName1;
  final String teamName2;

  TossScreen({super.key, required this.teamName1, required this.teamName2});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TossScreenState(teamName1, teamName2);
}

class _TossScreenState extends ConsumerState<TossScreen> {
  bool isSelected = false;
  final String teamName1;
  final String teamName2;
  final MatchDb _matchDb = MatchDb(dbName: 'db.sqlite');
  int matchId = 0;

  @override
  void initState() {
    super.initState();
    _matchDb.open();
  }

  _TossScreenState(this.teamName1, this.teamName2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Padding(
            padding: getPadding(all: 12),
            child: ClipOval(
              child: Container(
                height: getVerticalSize(350),
                width: getHorizontalSize(500),
                color: Colors.green,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isSelected ? 'Elected to' : 'Toss Winner',
                      style: AppStyle.txtPoppinsMedium18WhiteA700,
                    ),
                    Padding(
                      padding: getPadding(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isSelected
                              ? TextButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      _matchDb.updateMatch(matchId, true);
                                    });
                                  },
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
                                  onPressed: () async {
                                    final mId = await _matchDb.createMatch(
                                        teamName1, teamName2, teamName1);
                                    if (mId != null) {
                                      setState(() {
                                        isSelected = true;
                                        matchId = mId;
                                        // Now you can use the matchId as needed.
                                        print(
                                            'Match ID in toss xcreen : $matchId');
                                      });
                                    }
                                  },
                                  text: teamName1,
                                  width: getHorizontalSize(100),
                                  height: getVerticalSize(50),
                                ),
                          isSelected
                              ? TextButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      _matchDb.updateMatch(matchId, false);
                                    });
                                  },
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
                                      _matchDb.createMatch(
                                          teamName1, teamName2, teamName2);
                                      isSelected = true;
                                    });
                                  },
                                  text: teamName2,
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
        floatingActionButton: Padding(
          padding: getPadding(left: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomButton(
                  onPressed: () {
                    isSelected
                        ? setState(() {
                            isSelected = false;
                          })
                        : Routemaster.of(context).pop();
                  },
                  text: 'BACK',
                  width: getHorizontalSize(90),
                  height: getVerticalSize(40)),
            ],
          ),
        ));
  }
}
