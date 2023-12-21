import 'package:flutter/material.dart';
import 'package:sky_board/dashboard_page/custom_widgets/course_tile.dart';
import 'package:sky_board/main.dart';
import 'package:sky_board/models/course.dart';
import 'package:sky_board/models/course_type.dart';
import 'package:sky_board/models/grade.dart';
import 'package:sky_board/models/student.dart';
import 'package:sky_board/models/subject.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Student _student = Student(
      studentId: '',
      schoolId: '',
      firstName: '',
      lastName: '',
      graduationYear: DateTime.now(),
      personalSummary: '');

  late List<Course> _courses = [];

  late double gpa = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initData(),
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          case ConnectionState.done:
            {
              return RefreshIndicator(
                  onRefresh: refreshData,
                  child: ReorderableListView(
                      padding: const EdgeInsets.fromLTRB(16, 64, 16, 0),
                      header: Text(
                        "Hi ${_student.firstName}",
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.left,
                      ),
                      children: [
                        CourseTile(
                          key: GlobalKey(),
                          gpa: gpa,
                          courses: _courses,
                          refresh: refreshData,
                        ),
                      ],
                      onReorder: (x, y) {}));
            }
        }
      },
    );
  }

  Future<void> initData() async {
    List<Map<String, dynamic>> studentData =
        await supabase.from('students').select();
    _student = Student.fromMap(studentData[0]);
    List<Map<String, dynamic>> courseData =
        await supabase.from('courses').select();
    _courses = [];
    for (var element in courseData) {
      _courses.add(Course.fromMap(element));
    }
    double total = 0;
    for (var element in _courses) {
      total += (4 - element.finalGrade.index);
    }
    gpa = total / _courses.length;
  }

  Future<void> refreshData() async {
    List<Map<String, dynamic>> studentData =
        await supabase.from('students').select();
    _student = Student.fromMap(studentData[0]);
    List<Map<String, dynamic>> courseData =
        await supabase.from('courses').select();
    _courses = [];
    for (var element in courseData) {
      setState(() {
        _courses.add(Course.fromMap(element));
      });
    }
    double total = 0;
    for (var element in _courses) {
      total += (4 - element.finalGrade.index);
    }
    setState(() {
      gpa = total / _courses.length;
    });
  }
}
