import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
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
      appBar: const CustomAppBar(),
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
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Account Details",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  CustomTextInput(
                                    controller: firstNameController,
                                    obscureText: false,
                                    keyboardType: TextInputType.name,
                                    autofillHints: const [
                                      AutofillHints.givenName
                                    ],
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
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  CustomTextInput(
                                    controller: lastNameController,
                                    obscureText: false,
                                    keyboardType: TextInputType.name,
                                    autofillHints: const [
                                      AutofillHints.familyName
                                    ],
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
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  CustomTextInput(
                                    maxLines: null,
                                    controller: personalStatementController,
                                    obscureText: false,
                                    keyboardType: TextInputType.multiline,
                                    autofillHints: const [],
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
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  CustomTextInput(
                                    controller: graduationYearController,
                                    obscureText: false,
                                    keyboardType: TextInputType.datetime,
                                    autofillHints: const [],
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
                                    "To update other aspects of your account such as your school or email, please email us at help@skyboard.com",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
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
                                          if (context.mounted) {
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
                                          if (context.mounted) {
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
                                                return const ForgotPassword();
                                              },
                                            ));
                                          },
                                          icon: const Text("Forgot Password")),
                                      IconButton(
                                          onPressed: () async {
                                            await launchUrl(Uri.parse(
                                                "https://ryan-sum.github.io/SkyBoard/#/privacy?id=privacy-policy"));
                                          },
                                          icon: const Text("Privacy Policy")),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () async {
                                            try {
                                              await supabase.auth.signOut();
                                            } on AuthException catch (error) {
                                              if (context.mounted) {
                                                SnackBar(
                                                  content: Text(error.message),
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .error,
                                                );
                                              }
                                            } catch (error) {
                                              if (context.mounted) {
                                                SnackBar(
                                                  content: const Text(
                                                      'Unexpected error occurred'),
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .error,
                                                );
                                              }
                                            } finally {
                                              if (context.mounted) {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                  builder: (context) =>
                                                      const OnboardingPage(),
                                                ));
                                              }
                                            }
                                          },
                                          icon: Text(
                                            "Sign Out",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error),
                                          )),
                                      const Spacer()
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Spacer(),
                                      SizedBox(
                                        height: 24,
                                        width: 256,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .errorContainer)),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: true,
                                                  builder:
                                                      (BuildContext context) {
                                                    return CupertinoAlertDialog(
                                                      title: const Text(
                                                          "Delete this account?"),
                                                      content: const Text(
                                                          "Are you sure you would like to delete this account and all associated data? This action is NOT reversable and all data pertaining to your account will be destroyed!"),
                                                      actions: [
                                                        CupertinoDialogAction(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          isDefaultAction: true,
                                                          child: const Text(
                                                              "No, Do Not Delete My Account"),
                                                        ),
                                                        CupertinoDialogAction(
                                                          isDestructiveAction:
                                                              true,
                                                          onPressed: () async {
                                                            if (mounted) {
                                                              Navigator.pop(
                                                                  context);

                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      const SnackBar(
                                                                content: Text(
                                                                    "Account marked for deletion. This action may take up to 24 hours to complete"),
                                                              ));
                                                            }
                                                          },
                                                          child: const Text(
                                                              "Yes, DELETE MY ACCOUNT"),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Text(
                                              "DELETE ACCOUNT",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error),
                                            )),
                                      ),
                                      const Spacer()
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
