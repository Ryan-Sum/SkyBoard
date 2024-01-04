import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sky_board/global_widgets/custom_app_bar.dart';
import 'package:sky_board/global_widgets/custom_text_input.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController personalStatementController;

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    personalStatementController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    personalStatementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Account Details",
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
                  textInputAction: TextInputAction.next),
              SizedBox(
                height: 16,
              ),
              CustomTextInput(
                  controller: lastNameController,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  autofillHints: [AutofillHints.familyName],
                  hintText: "Last Name",
                  textInputAction: TextInputAction.next),
              SizedBox(
                height: 16,
              ),
              CustomTextInput(
                  controller: emailController,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                  hintText: "Email",
                  textInputAction: TextInputAction.next),
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
                  textInputAction: TextInputAction.next),
            ],
          ),
        ),
      ),
    );
  }
}
