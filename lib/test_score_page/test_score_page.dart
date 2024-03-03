// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sky_board/global_widgets/custom_app_bar.dart';
import 'package:sky_board/models/act_score.dart';
import 'package:sky_board/models/sat_score.dart';
import 'package:sky_board/test_score_page/act_entry_tile.dart';
import 'package:sky_board/test_score_page/edit_tests.dart';
import 'package:sky_board/test_score_page/sat_entry_tile.dart';

class TestScorePage extends StatefulWidget {
  final List<SATScore> satScores;
  final List<ACTScore> actScores;
  final SATScore? highestSAT;
  final ACTScore? highestACT;
  final bool? satIsHighest;
  final Future<void> Function() refresh;

  const TestScorePage({
    Key? key,
    required this.satScores,
    required this.actScores,
    required this.highestSAT,
    required this.highestACT,
    required this.satIsHighest,
    required this.refresh,
  }) : super(key: key);

  @override
  State<TestScorePage> createState() => _TestScorePageState();
}

class _TestScorePageState extends State<TestScorePage> {
  @override
  void initState() {
    widget.actScores.sort(
      (a, b) {
        double compA = (a.english + a.math + a.science + a.reading) / 4;
        double compB = (b.english + b.math + b.science + b.reading) / 4;
        return compB.compareTo(compA);
      },
    );
    widget.satScores.sort(
      (a, b) {
        int compA = a.english + a.math;
        int compB = b.english + b.math;
        return compB.compareTo(compA);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Center(
                    child: widget.satIsHighest == null
                        ? Container()
                        : widget.satIsHighest!
                            ? Hero(
                                tag: "sat",
                                child: SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Text(
                                        "${((widget.highestSAT!.english + widget.highestSAT!.math)).round()}\nSAT",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        height: 150,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 16,
                                          value: ((widget.highestSAT!.english +
                                                  widget.highestSAT!.math)) /
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
                                  width: 150,
                                  height: 150,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Text(
                                        "${((widget.highestACT!.english + widget.highestACT!.math + widget.highestACT!.reading + widget.highestACT!.science) / 4).round()}\nACT",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        height: 150,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 16,
                                          value: (((widget.highestACT!.english +
                                                      widget.highestACT!.math +
                                                      widget
                                                          .highestACT!.reading +
                                                      widget.highestACT!
                                                          .science) /
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
                              )),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Text(
                      "Tests (${widget.satScores.length + widget.actScores.length})",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditTests(
                                      refresh: widget.refresh,
                                    )),
                          );
                        },
                        icon: Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.primary,
                        ))
                  ],
                ),
              ]),
            ),
          ),
          SliverList.builder(
              itemCount: widget.satScores.length + widget.actScores.length,
              itemBuilder: (context, index) {
                if (index == 0 && widget.actScores.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "ACT Scores",
                          textAlign: TextAlign.left,
                        ),
                        const Divider(),
                        widget.actScores.isEmpty
                            ? Container()
                            : ACTEntryTile(
                                refresh: widget.refresh,
                                score: widget.actScores[index],
                              )
                      ],
                    ),
                  );
                }
                if (index < widget.actScores.length) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0.0),
                    child: ACTEntryTile(
                      refresh: widget.refresh,
                      score: widget.actScores[index],
                    ),
                  );
                }
                print("Index: $index\Act Scores: ${widget.actScores.length}");
                if (index == 0 ||
                    (widget.actScores.isNotEmpty &&
                        index == widget.actScores.length)) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "SAT Scores",
                          textAlign: TextAlign.left,
                        ),
                        const Divider(),
                        SATEntryTile(
                          refresh: widget.refresh,
                          score:
                              widget.satScores[index - widget.actScores.length],
                        )
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0.0),
                    child: SATEntryTile(
                      refresh: widget.refresh,
                      score: widget.satScores[index - widget.actScores.length],
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
