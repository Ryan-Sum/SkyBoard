// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sky_board/models/sat_score.dart';

class CheckboxSAT extends StatefulWidget {
  final SATScore sat;
  final void Function(bool) onTap;

  const CheckboxSAT({
    Key? key,
    required this.sat,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CheckboxSAT> createState() => _CheckboxSATState();
}

class _CheckboxSATState extends State<CheckboxSAT> {
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
                  "${DateFormat('MMMM yyyy').format(widget.sat.dateTaken)} SAT"),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    "Final Score: ${widget.sat.english + widget.sat.math}"),
              ),
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}
