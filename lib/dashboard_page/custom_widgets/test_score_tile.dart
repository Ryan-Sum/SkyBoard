// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sky_board/models/act_score.dart';
import 'package:sky_board/models/sat_score.dart';
import 'package:sky_board/test_score_page/test_score_page.dart';

class TestScoreTile extends StatefulWidget {
  final List<SATScore> satScores;
  final List<ACTScore> actScores;
  final Future<void> Function() refresh;

  const TestScoreTile({
    Key? key,
    required this.satScores,
    required this.actScores,
    required this.refresh,
  }) : super(key: key);

  @override
  State<TestScoreTile> createState() => _TestScoreTileState();
}

class _TestScoreTileState extends State<TestScoreTile> {
  @override
  Widget build(BuildContext context) {
    SATScore? highestSat =
        widget.satScores.isEmpty ? null : widget.satScores.first;
    ACTScore? highestAct =
        widget.actScores.isEmpty ? null : widget.actScores.first;
    bool? satIsHighest;

    for (var score in widget.satScores) {
      if (highestSat == null) {
        highestSat = score;
      } else {
        if (score.math + score.english > highestSat.math + highestSat.english) {
          highestSat = score;
        }
      }
    }
    for (var score in widget.actScores) {
      if (highestAct == null) {
        highestAct = score;
      } else {
        if (((score.math + score.english + score.reading + score.science) / 4) >
            ((highestAct.math +
                    highestAct.english +
                    highestAct.science +
                    highestAct.reading) /
                4)) {
          highestAct = score;
        }
      }
    }
    if (highestAct != null && highestSat != null) {
      if ((highestSat.math + highestSat.english) / 1600 >
          ((highestAct.math +
                      highestAct.english +
                      highestAct.science +
                      highestAct.reading) /
                  4) /
              36) {
        satIsHighest = true;
      } else {
        satIsHighest = false;
      }
    } else if (highestAct != null) {
      satIsHighest = false;
    } else if (highestSat != null) {
      satIsHighest = true;
    } else {
      satIsHighest = null;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TestScorePage(
                    refresh: widget.refresh,
                    satScores: widget.satScores,
                    actScores: widget.actScores,
                    highestSAT: highestSat,
                    highestACT: highestAct,
                    satIsHighest: satIsHighest)));
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color(0x00000000).withOpacity(0.09),
                  offset: const Offset(0, 0),
                  blurRadius: 19,
                  spreadRadius: 5,
                )
              ],
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Row(
                children: [
                  Icon(
                    Icons.class_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Test Scores",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text((widget.actScores.length + widget.satScores.length ==
                              1)
                          ? "${widget.actScores.length + widget.satScores.length} Test Entered"
                          : "${widget.actScores.length + widget.satScores.length} Tests Entered"),
                    ],
                  ),
                  const Spacer(),
                  satIsHighest == null
                      ? Container()
                      : satIsHighest
                          ? Hero(
                              tag: "sat",
                              child: SizedBox(
                                width: 75,
                                height: 75,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Text(
                                      "${((highestSat!.english + highestSat.math)).round()}\nSAT",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: 75,
                                      height: 75,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 8,
                                        value: ((highestSat.english +
                                                highestSat.math)) /
                                            1600,
                                        strokeCap: StrokeCap.round,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .surfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Hero(
                              tag: "act",
                              child: SizedBox(
                                width: 75,
                                height: 75,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Text(
                                      "${((highestAct!.english + highestAct.math + highestAct.reading + highestAct.science) / 4).round()}\nACT",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: 75,
                                      height: 75,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 8,
                                        value: (((highestAct.english +
                                                    highestAct.math +
                                                    highestAct.reading +
                                                    highestAct.science) /
                                                4) /
                                            36),
                                        strokeCap: StrokeCap.round,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .surfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
