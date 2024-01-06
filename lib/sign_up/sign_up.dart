import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sky_board/forgot_password/forgot_password.dart';
import 'package:sky_board/global_widgets/cta_button.dart';
import 'package:sky_board/global_widgets/custom_app_bar.dart';
import 'package:sky_board/global_widgets/custom_text_input.dart';
import 'package:sky_board/home_page/home_page.dart';
import 'package:sky_board/main.dart';
import 'package:sky_board/models/student.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController graduationYearController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  late Student _student;
  late final GlobalKey<FormState> formKey;

  String? validatePassword(String? password) {
    if (password == "" || password == null) {
      return "Please enter a valid password.";
    } else if (password.length >= 6) {
      return null;
    } else {
      return "Please enter a longer password (Min. 6 Characters)";
    }
  }

  String? validateEmail(email) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email ?? "")) {
      return null;
    } else {
      return "Please enter a valid email.";
    }
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    _setupAuthListener();
    formKey = GlobalKey<FormState>();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    graduationYearController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    graduationYearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
          child: Form(
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
                      "Sign Up",
                      style: Theme.of(context).textTheme.titleMedium,
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
                    SizedBox(
                      height: 16,
                    ),
                    CustomTextInput(
                      controller: emailController,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      hintText: "Email",
                      textInputAction: TextInputAction.next,
                      validator: validateEmail,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextInput(
                      validator: validatePassword,
                      controller: passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      autofillHints: const [AutofillHints.password],
                      hintText: "Password",
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CTAButton(
                      text: "Sign In",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                });
                            await supabase.auth.signUp(
                                password: passwordController.text.trim(),
                                email: emailController.text.trim());
                            Student sendStudent = Student(
                                studentId: supabase.auth.currentUser!.id,
                                schoolId:
                                    "17f2e3a7-8f0a-4ee8-8400-a5e9b75f63e1",
                                firstName: firstNameController.text.trim(),
                                lastName: lastNameController.text.trim(),
                                graduationYear: DateTime(int.parse(
                                    graduationYearController.text.trim())),
                                personalSummary:
                                    "Add your personal summary here! Don't be shy... Brag a little!");
                            await supabase
                                .from('students')
                                .upsert(sendStudent.toMap());
                          } on Exception {
                            if (mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text(
                                    "An error occurred. Please try again later."),
                                backgroundColor:
                                    Theme.of(context).colorScheme.error,
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
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text(
                                "Please enter valid values for all fields."),
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                          ));
                        }
                      },
                    ),
                    Center(
                      child: IconButton(
                          onPressed: () async {
                            await launchUrl(Uri.parse(
                                "https://ryan-sum.github.io/SkyBoard/#/privacy?id=privacy-policy"));
                          },
                          icon: Text("Privacy Policy")),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
