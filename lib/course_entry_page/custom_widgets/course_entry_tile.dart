import 'package:flutter/material.dart';
import 'package:sky_board/course_entry_page/custom_widgets/edit_course.dart';
import 'package:sky_board/models/course.dart';
import 'package:sky_board/models/grade.dart';

class CourseEntryTile extends StatelessWidget {
  const CourseEntryTile(
      {super.key, required this.course, required this.refresh});

  final Course course;
  final Future<void> Function() refresh;
  String convertGrade(Grade grade) {
    if (grade == Grade.a) return "A";
    if (grade == Grade.b) return "B";
    if (grade == Grade.c) return "C";
    if (grade == Grade.d) return "D";
    if (grade == Grade.f) return "F";
    return "F";
  }

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
              Text(course.courseName),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditCourse(
                          course: course,
                          refresh: refresh,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.more_horiz_rounded,
                      color: Theme.of(context).colorScheme.secondary))
            ],
          ),
          Table(
            columnWidths: const {
              0: FixedColumnWidth(64),
              1: FixedColumnWidth(64),
              2: FixedColumnWidth(64),
              4: FixedColumnWidth(64),
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
                      "S1",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "S2",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "Final ",
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
                      "Year",
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
                      convertGrade(course.semesterOneGrade!),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      course.semesterTwoGrade == null
                          ? "N/A"
                          : convertGrade(course.semesterTwoGrade!),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      convertGrade(course.finalGrade),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const TableCell(
                    child: Text(
                      "",
                    ),
                  ),
                  TableCell(
                    child: Text(
                      course.yearTaken!.year.toString(),
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
