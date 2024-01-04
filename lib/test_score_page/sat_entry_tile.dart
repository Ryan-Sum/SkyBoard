// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sky_board/models/sat_score.dart';
import 'package:sky_board/test_score_page/edit_tests.dart';

class SATEntryTile extends StatefulWidget {
  const SATEntryTile({
    Key? key,
    required this.score,
    required this.refresh,
  }) : super(key: key);

  final SATScore score;
  final Future<void> Function() refresh;

  @override
  State<SATEntryTile> createState() => _SATEntryTileState();
}

class _SATEntryTileState extends State<SATEntryTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0x00000000).withOpacity(0.09),
            offset: const Offset(0, 0),
            blurRadius: 19,
            spreadRadius: 5,
          )
        ],
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                  "${DateFormat.yMMMM('en_US').format(widget.score.dateTaken)} SAT"),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTests(
                          refresh: widget.refresh,
                          satScore: widget.score,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.more_horiz_rounded,
                      color: Theme.of(context).colorScheme.primary))
            ],
          ),
          Table(
            columnWidths: const {
              0: FixedColumnWidth(64),
              1: FixedColumnWidth(64),
              3: FixedColumnWidth(64),
            },
            border: TableBorder(
              horizontalInside:
                  BorderSide(color: Theme.of(context).colorScheme.outline),
            ),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Text(
                      "English",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "Math",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const TableCell(
                    child: Text(""),
                  ),
                  TableCell(
                    child: Text(
                      "Final",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Text(
                      widget.score.english.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      widget.score.math.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const TableCell(
                    child: Text(""),
                  ),
                  TableCell(
                    child: Text(
                      (widget.score.english + widget.score.math)
                          .round()
                          .toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
