import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sky_board/global_widgets/cta_button.dart';
import 'package:sky_board/global_widgets/custom_app_bar.dart';
import 'package:sky_board/global_widgets/custom_text_input.dart';
import 'package:sky_board/home_page/home_page.dart';
import 'package:sky_board/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formKey;
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();

    _authSubscription = supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authSubscription.cancel();
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
            key: _formKey,
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome Back We've Missed You!",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    CustomTextInput(
                      controller: _emailController,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      hintText: "Email",
                      textInputAction: TextInputAction.next,
                      validator: validateEmail,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextInput(
                      validator: validatePassword,
                      controller: _passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      autofillHints: const [AutofillHints.password],
                      hintText: "Password",
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Forgot Password?",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.grey[350])),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CTAButton(
                      text: 'Sign In',
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              });
                          try {
                            await Supabase.instance.client.auth
                                .signInWithPassword(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim());
                          } on AuthException catch (error) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(error.message),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.error,
                                ),
                              );
                            }
                          } catch (error) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      "An unexpected error occurred"),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.error,
                                ),
                              );
                            }
                          } finally {
                            Navigator.pop(context);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text(
                                "Please enter a valid email and password."),
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                          ));
                        }
                      },
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Text("Not signed up? ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.grey[500])),
                              Text(
                                "Sign up here",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validatePassword(password) {
    if (password == "" || password == null) {
      return "Please enter a valid password.";
    } else {
      return null;
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
}
