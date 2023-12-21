import 'package:flutter/material.dart';
import 'package:sky_board/dashboard_page/dashboard_page.dart';
import 'package:sky_board/global_widgets/cta_button.dart';
import 'package:sky_board/global_widgets/custom_app_bar.dart';
import 'package:sky_board/global_widgets/custom_text_input.dart';
import 'package:sky_board/main.dart';
import 'package:sky_board/models/course.dart';
import 'package:sky_board/models/course_type.dart';
import 'package:sky_board/models/grade.dart';
import 'package:sky_board/models/subject.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class EditCourse extends StatefulWidget {
  const EditCourse({super.key, required this.course, required this.refresh});

  final Course course;
  final Future<void> Function() refresh;

  @override
  State<EditCourse> createState() => _EditCourseState();
}

class _EditCourseState extends State<EditCourse> {
  late final TextEditingController courseNameController;
  CourseType courseType = CourseType.regular;
  Subject subject = Subject.other;
  DateTime yearTaken = DateTime.now();
  bool isOneSemester = false;
  Grade semOneGrade = Grade.f;
  Grade? semTwoGrade = null;
  late final GlobalKey<FormState> formKey;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    courseNameController =
        TextEditingController(text: widget.course.courseName);
    courseType = widget.course.courseType;
    subject = widget.course.subject;
    yearTaken = widget.course.yearTaken;
    isOneSemester = widget.course.isOneSemester;
    semOneGrade = widget.course.semesterOneGrade;
    semTwoGrade = widget.course.semesterTwoGrade;
    super.initState();
  }

  @override
  void dispose() {
    courseNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextInput(
                  autofillHints: const [],
                  controller: courseNameController,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  hintText: 'Course Name',
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.length < 4) {
                      return "Please Enter the Full Course Name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField(
                    validator: (value) {
                      if (value == "default") {
                        return "Please Select a Value";
                      }
                      return null;
                    },
                    value: subject.name,
                    items: [
                      DropdownMenuItem(
                        value: 'default',
                        child: Text(
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black38),
                            'Subject'),
                      ),
                      DropdownMenuItem(
                        value: 'math',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Math'),
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Science'),
                        value: 'science',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'English'),
                        value: 'english',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'History'),
                        value: 'history',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Language'),
                        value: 'language',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Arts'),
                        value: 'arts',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Finances'),
                        value: 'finances',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'CTE'),
                        value: 'cte',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Other'),
                        value: 'Other',
                      ),
                    ],
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black38),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                    onChanged: (x) {
                      if (x == "math") {
                        setState(() {
                          subject = Subject.math;
                        });
                      } else if (x == "science") {
                        setState(() {
                          subject = Subject.science;
                        });
                      } else if (x == "english") {
                        setState(() {
                          subject = Subject.english;
                        });
                      } else if (x == "history") {
                        setState(() {
                          subject = Subject.history;
                        });
                      } else if (x == "language") {
                        setState(() {
                          subject = Subject.language;
                        });
                      } else if (x == "arts") {
                        setState(() {
                          subject = Subject.arts;
                        });
                      } else if (x == "finances") {
                        setState(() {
                          subject = Subject.finances;
                        });
                      } else if (x == "cte") {
                        setState(() {
                          subject = Subject.cte;
                        });
                      } else if (x == "other") {
                        setState(() {
                          subject = Subject.other;
                        });
                      }
                    }),
                SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField(
                    validator: (value) {
                      if (value == "default") {
                        return "Please Select a Value";
                      }
                      return null;
                    },
                    value: courseType.name,
                    items: [
                      DropdownMenuItem(
                        value: 'default',
                        child: Text(
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black38),
                            'Course Type'),
                      ),
                      DropdownMenuItem(
                        value: 'regular',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Regular'),
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Honors'),
                        value: 'honors',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'AICE'),
                        value: 'aice',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Dual'),
                        value: 'dual',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'AP'),
                        value: 'ap',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'IB'),
                        value: 'ib',
                      ),
                    ],
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black38),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                    onChanged: (x) {
                      if (x == "regular") {
                        setState(() {
                          courseType = CourseType.regular;
                        });
                      } else if (x == "honors") {
                        setState(() {
                          courseType = CourseType.honors;
                        });
                      } else if (x == "aice") {
                        setState(() {
                          courseType = CourseType.aice;
                        });
                      } else if (x == "dual") {
                        setState(() {
                          courseType = CourseType.dual;
                        });
                      } else if (x == "ap") {
                        setState(() {
                          courseType = CourseType.ap;
                        });
                      } else if (x == "ib") {
                        setState(() {
                          courseType = CourseType.ib;
                        });
                      }
                    }),
                SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField(
                    validator: (value) {
                      if (value == "default") {
                        return "Please Select a Value";
                      }
                      return null;
                    },
                    value: yearTaken.year.toString(),
                    items: [
                      DropdownMenuItem(
                        value: 'default',
                        child: Text(
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black38),
                            'Year Taken'),
                      ),
                      DropdownMenuItem(
                        value: '2020-2021',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            '2020'),
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            '2021-2022'),
                        value: '2021',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            '2022-2023'),
                        value: '2022',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            '2023-2024'),
                        value: '2023',
                      ),
                    ],
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black38),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                    onChanged: (x) {
                      if (x == "2020") {
                        setState(() {
                          yearTaken = DateTime(2020);
                        });
                      } else if (x == "2021") {
                        setState(() {
                          yearTaken = DateTime(2021);
                        });
                      } else if (x == "2022") {
                        setState(() {
                          yearTaken = DateTime(2022);
                        });
                      } else if (x == "2023") {
                        setState(() {
                          yearTaken = DateTime(2023);
                        });
                      }
                    }),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text("Is One Semester (True/False):"),
                    Spacer(),
                    Switch.adaptive(
                        value: isOneSemester,
                        onChanged: (x) {
                          setState(() {
                            isOneSemester = x;
                          });
                        })
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField(
                    validator: (value) {
                      if (value == "default") {
                        return "Please Select a Value";
                      }
                      return null;
                    },
                    value: semOneGrade.name,
                    items: [
                      DropdownMenuItem(
                        value: 'default',
                        child: Text(
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black38),
                            'Semester One Grade'),
                      ),
                      DropdownMenuItem(
                        value: 'a',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'A'),
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'B'),
                        value: 'b',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'C'),
                        value: 'c',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'D'),
                        value: 'd',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'F'),
                        value: 'f',
                      ),
                    ],
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black38),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                    onChanged: (x) {
                      if (x == "a") {
                        setState(() {
                          semOneGrade = Grade.a;
                        });
                      } else if (x == "b") {
                        setState(() {
                          semOneGrade = Grade.b;
                        });
                      } else if (x == "c") {
                        setState(() {
                          semOneGrade = Grade.c;
                        });
                      } else if (x == "d") {
                        setState(() {
                          semOneGrade = Grade.d;
                        });
                      } else if (x == "f") {
                        setState(() {
                          semOneGrade = Grade.f;
                        });
                      }
                    }),
                SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField(
                    validator: (value) {
                      if (value == "default") {
                        return "Please Select a Value";
                      }
                      return null;
                    },
                    value: isOneSemester ? null : semTwoGrade!.name,
                    items: [
                      DropdownMenuItem(
                        value: 'default',
                        child: Text(
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black38),
                            'Semester Two Grade'),
                      ),
                      DropdownMenuItem(
                        value: 'a',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'A'),
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'B'),
                        value: 'b',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'C'),
                        value: 'c',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'D'),
                        value: 'd',
                      ),
                      DropdownMenuItem(
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'F'),
                        value: 'f',
                      ),
                    ],
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black38),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                    onChanged: isOneSemester
                        ? null
                        : (x) {
                            if (x == "a") {
                              setState(() {
                                semTwoGrade = Grade.a;
                              });
                            } else if (x == "b") {
                              setState(() {
                                semTwoGrade = Grade.b;
                              });
                            } else if (x == "c") {
                              setState(() {
                                semTwoGrade = Grade.c;
                              });
                            } else if (x == "d") {
                              setState(() {
                                semTwoGrade = Grade.d;
                              });
                            } else if (x == "f") {
                              setState(() {
                                semTwoGrade = Grade.f;
                              });
                            }
                          }),
                Spacer(),
                CTAButton(
                  text: "Save",
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      Course course = Course(
                          id: widget.course.id,
                          studentId:
                              Supabase.instance.client.auth.currentUser!.id,
                          courseName: courseNameController.text.trim(),
                          courseType: courseType,
                          subject: subject,
                          yearTaken: yearTaken,
                          isOneSemester: isOneSemester,
                          semesterOneGrade: semOneGrade,
                          semesterTwoGrade: semTwoGrade,
                          finalGrade: isOneSemester
                              ? semOneGrade
                              : Grade.values[4 -
                                  (((4 - semOneGrade.index) +
                                              (4 - semTwoGrade!.index)) /
                                          2)
                                      .round()]);
                      try {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                        await supabase.from("courses").upsert(course.toMap());
                      } on Error {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text(
                              "An error occurred. Please try again later."),
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ));
                      } finally {
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text("Course successfully updated"),
                        ));
                        Navigator.pop(context);
                        Navigator.pop(context);
                        widget.refresh();
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text(
                            "Please enter valid values for all fields."),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
