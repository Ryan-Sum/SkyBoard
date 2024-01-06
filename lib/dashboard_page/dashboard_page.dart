import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sky_board/dashboard_page/custom_widgets/course_tile.dart';
import 'package:sky_board/dashboard_page/custom_widgets/service_hour_tile.dart';
import 'package:sky_board/dashboard_page/custom_widgets/test_score_tile.dart';
import 'package:sky_board/main.dart';
import 'package:sky_board/models/act_score.dart';
import 'package:sky_board/models/community_service.dart';
import 'package:sky_board/models/course.dart';
import 'package:sky_board/models/sat_score.dart';
import 'package:sky_board/models/student.dart';

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
  late List<CommunityService> _communityService = [];
  late List<ACTScore> _actScores = [];
  late List<SATScore> _satScores = [];

  late double gpa = 0;
  late double totalHours = 0;
  late List<Widget> tiles = [];

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
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          case ConnectionState.done:
            {
              return RefreshIndicator(
                  onRefresh: refreshData,
                  child: ReorderableListView(
                      header: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x00000000).withOpacity(0.2),
                              offset: const Offset(0, 0),
                              blurRadius: 19,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                          child: AnimateGradient(
                            primaryBegin: const Alignment(1, 0),
                            primaryEnd: const Alignment(2, 0),
                            secondaryBegin: const Alignment(0, 1),
                            secondaryEnd: const Alignment(0, 2),
                            primaryColors: const [
                              Color(0xffdd1f66),
                              Color(0xFFE6AC4A),
                              Color(0xff20c5dd),
                            ],
                            secondaryColors: const [
                              Color(0xffdd1f66),
                              Color(0xff20c5dd),
                              Color(0xFFE6AC4A),
                            ],
                            duration: const Duration(seconds: 20),
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 128, 32, 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome Back",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                  Text(
                                    "${_student.firstName} ${_student.lastName}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      children: tiles,
                      onReorder: (oldindex, newindex) {
                        if (newindex > oldindex) {
                          newindex -= 1;
                        }
                        final items = tiles.removeAt(oldindex);
                        tiles.insert(newindex, items);
                      }));
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

    List<Map<String, dynamic>> serviceData =
        await supabase.from('community_service').select();

    List<Map<String, dynamic>> actData =
        await supabase.from('act_scores').select();

    List<Map<String, dynamic>> satData =
        await supabase.from('sat_scores').select();

    _communityService = [];
    _courses = [];
    gpa = 0;
    _actScores = [];
    _satScores = [];

    for (var element in actData) {
      _actScores.add(ACTScore.fromMap(element));
    }

    for (var element in satData) {
      _satScores.add(SATScore.fromMap(element));
    }

    totalHours = 0;
    for (var element in serviceData) {
      CommunityService service = CommunityService.fromMap(element);
      totalHours += service.hours;
      _communityService.add(service);
    }
    _courses = [];
    for (var element in courseData) {
      _courses.add(Course.fromMap(element));
    }
    double total = 0;
    for (var element in _courses) {
      total += (4 - element.finalGrade.index);
    }
    gpa = total / _courses.length;
    if (_courses.length == 0) {
      gpa = 0;
    }
    tiles = [
      CourseTile(
        key: GlobalKey(),
        gpa: gpa,
        courses: _courses,
        refresh: refreshData,
      ),
      ServiceHourTile(
        refresh: refreshData,
        key: GlobalKey(),
        hours: totalHours,
        services: _communityService,
      ),
      TestScoreTile(
        refresh: refreshData,
        satScores: _satScores,
        actScores: _actScores,
        key: GlobalKey(),
      )
    ];
  }

  Future<void> refreshData() async {
    List<Map<String, dynamic>> studentData =
        await supabase.from('students').select();
    _student = Student.fromMap(studentData[0]);
    List<Map<String, dynamic>> courseData =
        await supabase.from('courses').select();
    List<Map<String, dynamic>> serviceData =
        await supabase.from('community_service').select();
    List<Map<String, dynamic>> actData =
        await supabase.from('act_scores').select();
    List<Map<String, dynamic>> satData =
        await supabase.from('sat_scores').select();

    _communityService = [];
    _courses = [];
    gpa = 0;
    if (_courses.length == 0) {
      setState(() {
        gpa = 0;
      });
    }
    setState(() {
      _satScores = [];
    });
    for (var element in actData) {
      setState(() {
        _actScores.add(ACTScore.fromMap(element));
      });
    }
    setState(() {
      _actScores = [];
    });
    for (var element in satData) {
      setState(() {
        _satScores.add(SATScore.fromMap(element));
      });
    }
    for (var element in serviceData) {
      CommunityService service = CommunityService.fromMap(element);
      totalHours += service.hours;
      setState(() {
        _communityService.add(service);
      });
    }
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

    setState(() {
      tiles = [
        CourseTile(
          key: GlobalKey(),
          gpa: gpa,
          courses: _courses,
          refresh: refreshData,
        ),
        ServiceHourTile(
          refresh: refreshData,
          key: GlobalKey(),
          hours: totalHours,
          services: _communityService,
        ),
        TestScoreTile(
          refresh: refreshData,
          satScores: _satScores,
          actScores: _actScores,
          key: GlobalKey(),
        )
      ];
    });
  }
}
