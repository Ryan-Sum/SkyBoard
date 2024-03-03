import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sky_board/global_widgets/cta_button.dart';
import 'package:sky_board/global_widgets/custom_app_bar.dart';
import 'package:sky_board/global_widgets/custom_text_input.dart';
import 'package:sky_board/main.dart';
import 'package:sky_board/models/course.dart';
import 'package:sky_board/models/course_type.dart';
import 'package:sky_board/models/grade.dart';
import 'package:sky_board/models/subject.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditCourse extends StatefulWidget {
  const EditCourse({super.key, required this.course, required this.refresh});

  final Course course;
  final Future<void> Function() refresh;

  @override
  State<EditCourse> createState() => _EditCourseState();
}

class _EditCourseState extends State<EditCourse> {
  late final TextEditingController courseNameController;
  CourseType? courseType;
  Subject? subject = Subject.other;
  DateTime? yearTaken;
  bool isOneSemester = false;
  Grade? semOneGrade;
  Grade? semTwoGrade;
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
      appBar: const CustomAppBar(),
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
                const SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField(
                    validator: (value) {
                      if (value == "default") {
                        return "Please Select a Value";
                      }
                      return null;
                    },
                    value: subject == null ? 'default' : subject!.name,
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
                        value: 'science',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Science'),
                      ),
                      DropdownMenuItem(
                        value: 'english',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'English'),
                      ),
                      DropdownMenuItem(
                        value: 'history',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'History'),
                      ),
                      DropdownMenuItem(
                        value: 'language',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Language'),
                      ),
                      DropdownMenuItem(
                        value: 'arts',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Arts'),
                      ),
                      DropdownMenuItem(
                        value: 'finances',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Finances'),
                      ),
                      DropdownMenuItem(
                        value: 'cte',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'CTE'),
                      ),
                      DropdownMenuItem(
                        value: 'other',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Other'),
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
                const SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField(
                    validator: (value) {
                      if (value == "default") {
                        return "Please Select a Value";
                      }
                      return null;
                    },
                    value: courseType == null ? 'default' : courseType!.name,
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
                        value: 'honors',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Honors'),
                      ),
                      DropdownMenuItem(
                        value: 'aice',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'AICE'),
                      ),
                      DropdownMenuItem(
                        value: 'dual',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Dual'),
                      ),
                      DropdownMenuItem(
                        value: 'ap',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'AP'),
                      ),
                      DropdownMenuItem(
                        value: 'ib',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'IB'),
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
                const SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField(
                    validator: (value) {
                      if (value == "default") {
                        return "Please Select a Value";
                      }
                      return null;
                    },
                    value: yearTaken == null
                        ? 'default'
                        : yearTaken!.year.toString(),
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
                        value: '2020',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            '2020-2021'),
                      ),
                      DropdownMenuItem(
                        value: '2021',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            '2021-2022'),
                      ),
                      DropdownMenuItem(
                        value: '2022',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            '2022-2023'),
                      ),
                      DropdownMenuItem(
                        value: '2023',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            '2023-2024'),
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
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Text("Is One Semester (True/False):"),
                    const Spacer(),
                    Switch.adaptive(
                        value: isOneSemester,
                        onChanged: (x) {
                          setState(() {
                            isOneSemester = x;
                            semTwoGrade = null;
                          });
                        })
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField(
                    validator: (value) {
                      if (value == "default") {
                        return "Please Select a Value";
                      }
                      return null;
                    },
                    value: semOneGrade == null ? 'default' : semOneGrade!.name,
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
                        value: 'b',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'B'),
                      ),
                      DropdownMenuItem(
                        value: 'c',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'C'),
                      ),
                      DropdownMenuItem(
                        value: 'd',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'D'),
                      ),
                      DropdownMenuItem(
                        value: 'f',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'F'),
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
                const SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField(
                    validator: (value) {
                      if (isOneSemester == true) {
                        return null;
                      }
                      if (value == "default") {
                        return "Please Select a Value";
                      }
                      return null;
                    },
                    value: semTwoGrade == null
                        ? "default"
                        : (isOneSemester ? null : semTwoGrade!.name),
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
                        value: 'b',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'B'),
                      ),
                      DropdownMenuItem(
                        value: 'c',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'C'),
                      ),
                      DropdownMenuItem(
                        value: 'd',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'D'),
                      ),
                      DropdownMenuItem(
                        value: 'f',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge, 'F'),
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
                const Spacer(),
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
                              ? semOneGrade!
                              : Grade.values[4 -
                                  (((4 - semOneGrade!.index) +
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
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text(
                                "An error occurred. Please try again later."),
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                          ));
                        }
                      } finally {
                        if (context.mounted) {
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Course successfully updated"),
                          ));
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }

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
                ),
                IconButton(
                    color: Theme.of(context).colorScheme.error,
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: const Text("Delete this course?"),
                              content: const Text(
                                  "Are you sure you would like to delete this course?"),
                              actions: [
                                CupertinoDialogAction(
                                  onPressed: () => Navigator.pop(context),
                                  isDefaultAction: true,
                                  child: const Text("No"),
                                ),
                                CupertinoDialogAction(
                                  isDestructiveAction: true,
                                  onPressed: () async {
                                    await supabase
                                        .from("courses")
                                        .delete()
                                        .match({'id': widget.course.id});
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      widget.refresh();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text("Course successfully deleted"),
                                      ));
                                    }
                                  },
                                  child: const Text("Yes"),
                                ),
                              ],
                            );
                          });
                    },
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.delete_forever_rounded),
                        Text("Delete Course",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.error))
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
