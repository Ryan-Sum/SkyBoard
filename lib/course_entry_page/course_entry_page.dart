import 'package:flutter/material.dart';
import 'package:sky_board/course_entry_page/custom_widgets/course_entry_tile.dart';
import 'package:sky_board/course_entry_page/custom_widgets/edit_course.dart';
import 'package:sky_board/global_widgets/custom_app_bar.dart';
import 'package:sky_board/main.dart';
import 'package:sky_board/models/course.dart';
import 'package:sky_board/models/grade.dart';
import 'package:uuid/uuid.dart';

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
  void initState() {
    widget.courses.sort((a, b) {
      return b.yearTaken!.compareTo(a.yearTaken!);
    });

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
                  child: Hero(
                      tag: 'gpa',
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              "${widget.gpa.toStringAsPrecision(2)}\nGPA",
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
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Text(
                      "Courses (${widget.courses.length})",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditCourse(
                                course: Course(
                                    id: const Uuid().v8(),
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
              ]),
            ),
          ),
          SliverList.builder(
            itemCount: widget.courses.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.courses[index].yearTaken!.year.toString()} - ${widget.courses[index].yearTaken!.add(const Duration(days: 366)).year..toString()}",
                        textAlign: TextAlign.left,
                      ),
                      const Divider(),
                      CourseEntryTile(
                        course: widget.courses[index],
                        refresh: _refresh,
                      ),
                    ],
                  ),
                );
              }
              if (widget.courses[index].yearTaken !=
                  widget.courses[index - 1].yearTaken) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.courses[index].yearTaken!.year.toString()} - ${widget.courses[index].yearTaken!.add(const Duration(days: 366)).year..toString()}",
                        textAlign: TextAlign.left,
                      ),
                      const Divider(),
                      CourseEntryTile(
                        course: widget.courses[index],
                        refresh: _refresh,
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0.0),
                child: Column(
                  children: [
                    CourseEntryTile(
                      course: widget.courses[index],
                      refresh: _refresh,
                    ),
                  ],
                ),
              );
            },
          )
        ],
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
