// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sky_board/models/course.dart';

class CheckboxCourse extends StatefulWidget {
  final Course course;
  final void Function(bool) onTap;

  const CheckboxCourse({
    Key? key,
    required this.course,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CheckboxCourse> createState() => _CheckboxCourseState();
}

class _CheckboxCourseState extends State<CheckboxCourse> {
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
              Text(widget.course.courseName),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    "Final Grade: ${widget.course.finalGrade.name.toUpperCase()}"),
              ),
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}
