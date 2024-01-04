// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:uuid/uuid.dart';

import 'package:sky_board/calendar_page/user_event.dart';
import 'package:sky_board/global_widgets/cta_button.dart';
import 'package:sky_board/global_widgets/custom_app_bar.dart';
import 'package:sky_board/global_widgets/custom_text_input.dart';
import 'package:sky_board/main.dart';

class AddUserEvent extends StatefulWidget {
  final DateTime selectedDate;
  final UserEvent? userEvent;
  final Future<void> Function() refresh;

  const AddUserEvent({
    Key? key,
    required this.selectedDate,
    this.userEvent,
    required this.refresh,
  }) : super(key: key);

  @override
  State<AddUserEvent> createState() => _AddUserEventState();
}

class _AddUserEventState extends State<AddUserEvent> {
  late final TextEditingController summary;
  late final TextEditingController description;
  late final TextEditingController location;
  late final TextEditingController dateController;

  late DateTime selectedDate;

  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    summary = widget.userEvent == null
        ? TextEditingController()
        : TextEditingController.fromValue(
            TextEditingValue(text: widget.userEvent!.summary));
    description = widget.userEvent == null
        ? TextEditingController()
        : widget.userEvent!.description == null
            ? TextEditingController()
            : TextEditingController.fromValue(
                TextEditingValue(text: widget.userEvent!.description!));
    location = widget.userEvent == null
        ? TextEditingController()
        : widget.userEvent!.location == null
            ? TextEditingController()
            : TextEditingController.fromValue(
                TextEditingValue(text: widget.userEvent!.location!));
    selectedDate = widget.userEvent == null
        ? widget.selectedDate
        : widget.userEvent!.dtstart;
    dateController = TextEditingController.fromValue(TextEditingValue(
        text:
            "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}"));
    super.initState();
  }

  @override
  void dispose() {
    summary.dispose();
    description.dispose();
    location.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomTextInput(
                  controller: summary,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  autofillHints: [],
                  hintText: "Title",
                  textInputAction: TextInputAction.next,
                  validator: (p0) {
                    if (p0 != null && p0.isNotEmpty) {
                      return null;
                    } else {
                      return "Please enter a title for this event.";
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                CustomTextInput(
                    controller: description,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    autofillHints: [],
                    hintText: "Description (Optional)",
                    textInputAction: TextInputAction.next),
                SizedBox(
                  height: 16,
                ),
                CustomTextInput(
                    controller: location,
                    obscureText: false,
                    keyboardType: TextInputType.streetAddress,
                    autofillHints: [AutofillHints.postalAddress],
                    hintText: "Location (Optional)",
                    textInputAction: TextInputAction.next),
                SizedBox(
                  height: 16,
                ),
                CustomTextInput(
                  onTap: () async {
                    DateTime? tempDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030));
                    if (tempDate != null) {
                      selectedDate = tempDate;
                    } else {
                      selectedDate = DateTime.now();
                    }

                    dateController.setText(
                        "${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}");
                  },
                  validator: (p0) {
                    if (p0 != null) {
                      if (p0.isNotEmpty) {
                        return null;
                      }
                    }
                    return "Please enter a date";
                  },
                  isEnabled: false,
                  controller: dateController,
                  obscureText: false,
                  keyboardType: TextInputType.none,
                  autofillHints: const [],
                  hintText: "Date of event",
                  textInputAction: TextInputAction.next,
                ),
                Spacer(),
                CTAButton(
                  text: "Submit",
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
                        UserEvent event = UserEvent(
                            dtstart: selectedDate,
                            dtend: selectedDate,
                            summary: summary.text.trim(),
                            description: description.text.trim(),
                            location: location.text.trim(),
                            studentId: supabase.auth.currentUser!.id,
                            id: widget.userEvent == null
                                ? Uuid().v4()
                                : widget.userEvent!.id);
                        await supabase.from("event").upsert(event.toMap());
                      } on Error {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                            content: Text("Event successfully updated"),
                          ));
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
                              title: const Text("Delete this event?"),
                              content: const Text(
                                  "Are you sure you would like to delete this event?"),
                              actions: [
                                CupertinoDialogAction(
                                  onPressed: () => Navigator.pop(context),
                                  isDefaultAction: true,
                                  child: const Text("No"),
                                ),
                                CupertinoDialogAction(
                                  isDestructiveAction: true,
                                  onPressed: () async {
                                    if (widget.userEvent != null) {
                                      await supabase
                                          .from("event")
                                          .delete()
                                          .match({'id': widget.userEvent!.id});
                                    }

                                    if (mounted) {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      widget.refresh();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text("Event successfully deleted"),
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
                        Text("Delete Event",
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
