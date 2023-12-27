import 'package:flutter/material.dart';
import 'package:sky_board/course_entry_page/custom_widgets/course_entry_tile.dart';
import 'package:sky_board/course_entry_page/custom_widgets/edit_course.dart';
import 'package:sky_board/global_widgets/custom_app_bar.dart';
import 'package:sky_board/main.dart';
import 'package:sky_board/models/course.dart';
import 'package:sky_board/models/course_type.dart';
import 'package:sky_board/models/grade.dart';
import 'package:sky_board/models/subject.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v8.dart';

class CourseEntryPage extends StatefulWidget {
  const CourseEntryPage(
      {super.key,
      required this.courses,
      required this.gpa,
      required this.refresh});

  final Future<void> Function() refresh;
  final List<Course> courses;
  final double gpa;

  @override
  State<CourseEntryPage> createState() => _CourseEntryPageState();
}

class _CourseEntryPageState extends State<CourseEntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Hero(
                  tag: 'gpa',
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          "${widget.gpa}\nGPA",
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                            strokeWidth: 16,
                            value: widget.gpa / 4,
                            strokeCap: StrokeCap.round,
                            color: Theme.of(context).colorScheme.secondary,
                            backgroundColor:
                                Theme.of(context).colorScheme.surfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              children: [
                Text(
                  "Courses (${widget.courses.length})",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCourse(
                            course: Course(
                                id: Uuid().v8(),
                                studentId: supabase.auth.currentUser!.id,
                                courseName: "",
                                courseType: null,
                                subject: null,
                                yearTaken: null,
                                isOneSemester: false,
                                semesterOneGrade: null,
                                semesterTwoGrade: null,
                                finalGrade: Grade.a),
                            refresh: _refresh,
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.secondary,
                    ))
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.courses.length,
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) => Column(
                children: [
                  CourseEntryTile(
                    course: widget.courses[index],
                    refresh: _refresh,
                  ),
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    widget.refresh();
    setState(() {
      widget.courses;
      widget.gpa;
    });
  }
}
