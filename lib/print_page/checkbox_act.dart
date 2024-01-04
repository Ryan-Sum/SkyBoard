// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sky_board/models/act_score.dart';

class CheckboxACT extends StatefulWidget {
  final ACTScore act;
  final void Function(bool) onTap;

  const CheckboxACT({
    Key? key,
    required this.act,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CheckboxACT> createState() => _CheckboxACTState();
}

class _CheckboxACTState extends State<CheckboxACT> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox.adaptive(
                  value: isChecked,
                  onChanged: (x) {
                    setState(() {
                      isChecked = x!;
                    });
                    widget.onTap(x!);
                  }),
              Text(
                  "${DateFormat('MMMM yyyy').format(widget.act.dateTaken)} ACT"),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    "Final Score: ${((widget.act.reading + widget.act.english + widget.act.science + widget.act.math) / 4).round()}"),
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
