// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sky_board/course_entry_page/course_entry_page.dart';
import 'package:sky_board/models/course.dart';
import 'package:sky_board/models/grade.dart';

class CourseTile extends StatelessWidget {
  final double gpa;
  final List<Course> courses;
  final Future<void> Function() refresh;

  const CourseTile({
    Key? key,
    required this.gpa,
    required this.courses,
    required this.refresh,
  }) : super(key: key);

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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseEntryPage(
                courses: courses,
                gpa: gpa,
                refresh: refresh,
              ),
            ));
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
                ),
              ],
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Row(
                children: [
                  Icon(
                    Icons.school_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Courses",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      courses.length == 1
                          ? Text("${courses.length} Course Entered")
                          : Text("${courses.length} Courses Entered"),
                    ],
                  ),
                  const Spacer(),
                  Hero(
                    tag: "gpa",
                    child: SizedBox(
                      width: 75,
                      height: 75,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            "${gpa.toStringAsPrecision(2)}\nGPA",
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: 75,
                            height: 75,
                            child: CircularProgressIndicator(
                              strokeWidth: 8,
                              value: gpa / 4,
                              strokeCap: StrokeCap.round,
                              color: Theme.of(context).colorScheme.secondary,
                              backgroundColor:
                                  Theme.of(context).colorScheme.surfaceVariant,
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
