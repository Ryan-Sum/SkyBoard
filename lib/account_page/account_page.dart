import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sky_board/forgot_password/forgot_password.dart';
import 'package:sky_board/global_widgets/cta_button.dart';
import 'package:sky_board/global_widgets/custom_app_bar.dart';
import 'package:sky_board/global_widgets/custom_text_input.dart';
import 'package:sky_board/main.dart';
import 'package:sky_board/models/student.dart';
import 'package:sky_board/onboarding_page/onboarding_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController personalStatementController;
  late final TextEditingController graduationYearController;

  late Student _student;
  late final GlobalKey<FormState> formKey;

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedOut) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const OnboardingPage(),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    _setupAuthListener();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    graduationYearController.dispose();
    personalStatementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: FutureBuilder(
            future: initData(),
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
                    return Form(
                      key: formKey,
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Account Details",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  CustomTextInput(
                                    controller: firstNameController,
                                    obscureText: false,
                                    keyboardType: TextInputType.name,
                                    autofillHints: [AutofillHints.givenName],
                                    hintText: "First Name",
                                    textInputAction: TextInputAction.next,
                                    validator: (p0) {
                                      if (p0 != null && p0.isNotEmpty) {
                                        return null;
                                      } else {
                                        return "Please enter a value for this field";
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  CustomTextInput(
                                    controller: lastNameController,
                                    obscureText: false,
                                    keyboardType: TextInputType.name,
                                    autofillHints: [AutofillHints.familyName],
                                    hintText: "Last Name",
                                    textInputAction: TextInputAction.next,
                                    validator: (p0) {
                                      if (p0 != null && p0.isNotEmpty) {
                                        return null;
                                      } else {
                                        return "Please enter a value for this field";
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  CustomTextInput(
                                    maxLines: null,
                                    controller: personalStatementController,
                                    obscureText: false,
                                    keyboardType: TextInputType.multiline,
                                    autofillHints: [],
                                    hintText: "Personal Statement",
                                    textInputAction: TextInputAction.next,
                                    validator: (p0) {
                                      if (p0 != null && p0.isNotEmpty) {
                                        return null;
                                      } else {
                                        return "Please enter a value for this field";
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  CustomTextInput(
                                    controller: graduationYearController,
                                    obscureText: false,
                                    keyboardType: TextInputType.datetime,
                                    autofillHints: [],
                                    hintText: "Graduation Year (Ex. 2025)",
                                    textInputAction: TextInputAction.next,
                                    validator: (p0) {
                                      if (p0 == "2023" ||
                                          p0 == "2024" ||
                                          p0 == "2025" ||
                                          p0 == "2026" ||
                                          p0 == "2027") {
                                        return null;
                                      } else {
                                        return "Please enter the year correctly formatted. Ex. 2025";
                                      }
                                    },
                                  ),
                                  Text(
                                    "To update/delete other aspects of your account such as your school or email, please email us at help@skyboard.com",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  CTAButton(
                                    text: "Update",
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        try {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              });
                                          Student sendStudent = Student(
                                              studentId: supabase
                                                  .auth.currentUser!.id,
                                              schoolId:
                                                  "17f2e3a7-8f0a-4ee8-8400-a5e9b75f63e1",
                                              firstName: firstNameController
                                                  .text
                                                  .trim(),
                                              lastName: lastNameController.text
                                                  .trim(),
                                              graduationYear: DateTime(
                                                  int.parse(
                                                      graduationYearController
                                                          .text
                                                          .trim())),
                                              personalSummary:
                                                  personalStatementController
                                                      .text
                                                      .trim());
                                          await supabase
                                              .from("students")
                                              .upsert(sendStudent.toMap());
                                        } on Error {
                                          if (mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: const Text(
                                                  "An error occurred. Please try again later."),
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .error,
                                            ));
                                          }
                                        } finally {
                                          if (mounted) {
                                            Navigator.pop(context);

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Account Details successfully updated"),
                                            ));
                                          }

                                          refreshData();
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: const Text(
                                              "Please enter valid values for all fields."),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .error,
                                        ));
                                      }
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return ForgotPassword();
                                              },
                                            ));
                                          },
                                          icon: Text("Forgot Password")),
                                      IconButton(
                                          onPressed: () async {
                                            await launchUrl(Uri.parse(
                                                "https://ryan-sum.github.io/SkyBoard/#/privacy?id=privacy-policy"));
                                          },
                                          icon: Text("Privacy Policy")),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            supabase.auth.signOut();
                                          },
                                          icon: Text(
                                            "Sign Out",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error),
                                          )),
                                      Spacer()
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
              }
            }),
      ),
    );
  }

  Future<void> initData() async {
    List<Map<String, dynamic>> studentData =
        await supabase.from('students').select();
    _student = Student.fromMap(studentData[0]);
    firstNameController = TextEditingController.fromValue(
        TextEditingValue(text: _student.firstName));
    lastNameController = TextEditingController.fromValue(
        TextEditingValue(text: _student.lastName));
    personalStatementController = TextEditingController.fromValue(
        TextEditingValue(text: _student.personalSummary));
    graduationYearController = TextEditingController.fromValue(
        TextEditingValue(text: _student.graduationYear.year.toString()));
  }

  Future<void> refreshData() async {
    List<Map<String, dynamic>> studentData =
        await supabase.from('students').select();
    setState(() {
      _student = Student.fromMap(studentData[0]);
      firstNameController.text = _student.firstName;
      lastNameController.text = _student.lastName;
      personalStatementController.text = _student.personalSummary;
      graduationYearController.text = _student.graduationYear.year.toString();
    });
  }
}
