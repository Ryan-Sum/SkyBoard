import 'dart:io';
import 'dart:typed_data';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sky_board/main.dart';
import 'package:sky_board/models/act_score.dart';
import 'package:sky_board/models/community_service.dart';
import 'package:sky_board/models/course.dart';
import 'package:sky_board/models/sat_score.dart';
import 'package:sky_board/models/student.dart';
import 'package:sky_board/print_page/checkbox.dart';
import 'package:sky_board/print_page/checkbox_act.dart';
import 'package:sky_board/print_page/checkbox_community_service.dart';
import 'package:sky_board/print_page/checkbox_sat.dart';
import 'package:sky_board/print_page/pdf_service.dart';
import 'package:uuid/uuid.dart';

class PrintPage extends StatefulWidget {
  const PrintPage({super.key});

  @override
  State<PrintPage> createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
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

  List<Course> sendCourse = [];
  List<ACTScore> sendACT = [];
  List<SATScore> sendSAT = [];
  List<CommunityService> sendService = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
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
                      return CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x00000000)
                                        .withOpacity(0.2),
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
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 128, 32, 16),
                                    child: Text(
                                        "Choose the items you would like to include on your résumé...",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Courses:",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Divider()
                              ],
                            ),
                          ),
                          SliverList.builder(
                            itemCount: _courses.length,
                            itemBuilder: (context, index) {
                              return CheckboxCourse(
                                course: _courses[index],
                                onTap: (x) {
                                  if (x == true) {
                                    sendCourse.add(_courses[index]);
                                  } else {
                                    sendCourse.removeWhere((element) {
                                      return element.id == _courses[index].id;
                                    });
                                  }
                                },
                              );
                            },
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "ACT Tests:",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Divider()
                              ],
                            ),
                          ),
                          SliverList.builder(
                            itemCount: _actScores.length,
                            itemBuilder: (context, index) {
                              return CheckboxACT(
                                onTap: (x) {
                                  if (x == true) {
                                    sendACT.add(_actScores[index]);
                                  } else {
                                    sendACT.removeWhere((element) {
                                      return element.id == _actScores[index].id;
                                    });
                                  }
                                },
                                act: _actScores[index],
                              );
                            },
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "SAT Tests:",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Divider()
                              ],
                            ),
                          ),
                          SliverList.builder(
                            itemCount: _satScores.length,
                            itemBuilder: (context, index) {
                              return CheckboxSAT(
                                onTap: (p0) {
                                  if (p0 == true) {
                                    sendSAT.add(_satScores[index]);
                                  } else {
                                    sendSAT.removeWhere((element) {
                                      return element.id == _satScores[index].id;
                                    });
                                  }
                                },
                                sat: _satScores[index],
                              );
                            },
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Community Service Events:",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Divider()
                              ],
                            ),
                          ),
                          SliverList.builder(
                            itemCount: _communityService.length,
                            itemBuilder: (context, index) {
                              return CheckboxCommunityService(
                                onTap: (p0) {
                                  if (p0 == true) {
                                    sendService.add(_communityService[index]);
                                  } else {
                                    sendService.removeWhere((element) {
                                      return element.id ==
                                          _communityService[index].id;
                                    });
                                  }
                                },
                                service: _communityService[index],
                              );
                            },
                          ),
                        ],
                      );
                    }
                }
              }),
        ),
        Column(
          children: [
            Spacer(),
            Row(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton.extended(
                      onPressed: () async {
                        Uint8List data = await PdfService().createResume(
                            _student,
                            sendCourse,
                            sendACT,
                            sendSAT,
                            sendService,
                            totalHours,
                            gpa);
                        PdfService().savePdfFile(Uuid().v4(), data);
                        sendCourse = [];
                        sendACT = [];
                        sendSAT = [];
                        sendService = [];
                      },
                      label: Row(
                        children: [
                          Text("Generate"),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.file_copy)
                        ],
                      )),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Future<void> getData() async {
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
  }
}
