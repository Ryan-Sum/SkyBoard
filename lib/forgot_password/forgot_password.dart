import 'package:flutter/material.dart';
import 'package:sky_board/global_widgets/cta_button.dart';
import 'package:sky_board/global_widgets/custom_app_bar.dart';
import 'package:sky_board/global_widgets/custom_text_input.dart';
import 'package:sky_board/main.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late final TextEditingController emailController;
  late final GlobalKey<FormState> formKey;

  Future<void> _resetPassword() async {
    if (formKey.currentState!.validate()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      try {
        await supabase.auth.resetPasswordForEmail(emailController.text.trim());
      } catch (error) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("An unexpected error occurred"),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      } finally {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Email sent"),
            ),
          );
          Navigator.pop(context);
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Please enter a valid email."),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    }
  }

  String? _validateEmail(email) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email ?? "")) {
      return null;
    } else {
      return "Please enter a valid email.";
    }
  }

  @override
  void initState() {
    emailController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Password Reset",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                  "Enter the email you registered with to reset your password"),
              SizedBox(
                height: 16,
              ),
              CustomTextInput(
                  validator: _validateEmail,
                  controller: emailController,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                  hintText: "Email",
                  textInputAction: TextInputAction.done),
              SizedBox(
                height: 16,
              ),
              CTAButton(
                text: "Submit",
                onTap: _resetPassword,
              )
            ],
          ),
        ),
      ),
    );
  }
}
