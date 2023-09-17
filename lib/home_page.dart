import 'package:cricket/features/repository/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(cricketScoreProvider);
    final s = ref.watch(cricketScoreProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              ref.read(cricketScoreProvider.notifier).getWickets(1);
            },
            icon:  Icon(
              Icons.ssid_chart_rounded,
              color: Colors.indigo,
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(cricketScoreProvider.notifier).updateScore(10);
            },
            icon: Icon(
              Icons.splitscreen_rounded,
              color: Colors.indigo,
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'A v/s B',
          style: TextStyle(
              color: Colors.indigo, fontSize: 30, fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.indigo,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              'A.1st inning',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, left: 20),
                            child: Row(
                              children: [
                                Text(
                                  "${score.totalScore} / ${score.totalWickets}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5, top: 5),
                                  child: Text(
                                    '(0.0)',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20, right: 150),
                            child: Text(
                              'CRR',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20, right: 150),
                            child: Text(
                              s.getRunRate().toStringAsPrecision(3),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.indigo),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              'Batsman',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Text(
                            'R',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'B',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '4s',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '6s',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'SR',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                        height: 10,
                        color: Colors.white,
                      ),
                      Container(
                        height: 100,
                        color: Colors.indigo,
                      ),
                      const Divider(
                        thickness: 2,
                        height: 10,
                        color: Colors.white,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              'Bowler     ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Text(
                            '0.0',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '0.0',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '0',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '0',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '00.00',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.indigo),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'This over :',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.indigo),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
