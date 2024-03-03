// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:uuid/uuid.dart';

import 'package:sky_board/global_widgets/cta_button.dart';
import 'package:sky_board/global_widgets/custom_app_bar.dart';
import 'package:sky_board/global_widgets/custom_text_input.dart';
import 'package:sky_board/main.dart';
import 'package:sky_board/models/community_service.dart';
import 'package:sky_board/service_hours/custom_widgets/pin.dart';

class EditEventPage extends StatefulWidget {
  const EditEventPage({
    Key? key,
    required this.refresh,
    this.communityService,
  }) : super(key: key);
  final Future<void> Function() refresh;
  final CommunityService? communityService;

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  late final TextEditingController organizationName;
  late final TextEditingController description;
  late final TextEditingController hours;
  late final TextEditingController date;
  bool isVerified = false;
  DateTime? _dateTime;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    organizationName = TextEditingController.fromValue(TextEditingValue(
        text: widget.communityService == null
            ? ""
            : widget.communityService!.organizationName));
    description = TextEditingController.fromValue(TextEditingValue(
        text: widget.communityService == null
            ? ""
            : widget.communityService!.description));
    hours = TextEditingController.fromValue(TextEditingValue(
        text: widget.communityService == null
            ? ""
            : widget.communityService!.hours.toString()));
    date = TextEditingController.fromValue(TextEditingValue(
        text: widget.communityService == null
            ? ""
            : "${widget.communityService!.date.month.toString()}/${widget.communityService!.date.day.toString()}/${widget.communityService!.date.year.toString()}"));

    _dateTime = widget.communityService == null
        ? DateTime.now()
        : widget.communityService!.date;
    isVerified = widget.communityService == null
        ? false
        : widget.communityService!.isVerified;
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    organizationName.dispose();
    description.dispose();
    hours.dispose();
    date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CustomTextInput(
                      onTap: () {
                        setState(() {
                          isVerified = false;
                        });
                      },
                      validator: (p0) {
                        if (p0 != null) {
                          if (p0.length > 3) {
                            return null;
                          }
                        }
                        return "Organization name must be greater than 3 characters";
                      },
                      controller: organizationName,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      autofillHints: const [AutofillHints.organizationName],
                      hintText: 'Organization Name',
                      textInputAction: TextInputAction.next),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextInput(
                      onTap: () {
                        setState(() {
                          isVerified = false;
                        });
                      },
                      validator: (p0) {
                        if (p0 != null) {
                          if (p0.length > 3) {
                            return null;
                          }
                        }
                        return "Description must be greater than 3 characters";
                      },
                      controller: description,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      autofillHints: const [],
                      hintText: 'Event Description',
                      textInputAction: TextInputAction.next),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextInput(
                      onTap: () {
                        setState(() {
                          isVerified = false;
                        });
                      },
                      validator: (p0) {
                        if (p0 != null) {
                          double? num = double.tryParse(p0);
                          if (num != null) {
                            if (num > 0 && num <= 8) {
                              if (num - num.truncate() == 0 ||
                                  num - num.truncate() == 0.5) {
                                return null;
                              } else {
                                return "Please enter values in increments of 0.5 hours.";
                              }
                            } else {
                              return "Please enter a value between 0-8 hours.";
                            }
                          } else {
                            return "Please enter a number.";
                          }
                        } else {
                          return "Please enter the hours you volunteered.";
                        }
                      },
                      controller: hours,
                      obscureText: false,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      autofillHints: const [],
                      hintText: 'Total Hours (Max. 8 per day)',
                      textInputAction: TextInputAction.next),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextInput(
                    onTap: () async {
                      setState(() {
                        isVerified = false;
                      });

                      _dateTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now());
                      if (_dateTime != null) {
                        date.setText(
                            "${_dateTime!.month}/${_dateTime!.day}/${_dateTime!.year}");
                      }
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
                    controller: date,
                    obscureText: false,
                    keyboardType: TextInputType.none,
                    autofillHints: const [],
                    hintText: "Date of event",
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  isVerified
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border:
                                  Border.all(color: Colors.green, width: 2)),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Organization Verified",
                                  style: TextStyle(color: Colors.green),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            bool? result =
                                await Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const PinPage();
                              },
                            ));
                            if (result == true) {
                              setState(() {
                                isVerified = true;
                              });
                            }
                          },
                          child: const Text("Verify With Organization")),
                  const Spacer(),
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
                            CommunityService service = CommunityService(
                                id: widget.communityService == null
                                    ? const Uuid().v8()
                                    : widget.communityService!.id,
                                studentId: supabase.auth.currentUser!.id,
                                organizationName: organizationName.text.trim(),
                                description: description.text.trim(),
                                hours: double.parse(hours.text.trim()),
                                brightFuturesEligible: true,
                                isVerified: isVerified,
                                date: _dateTime!);
                            await supabase
                                .from("community_service")
                                .upsert(service.toMap());
                          } on Error {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
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
                                content: Text(
                                    "Community Service successfully updated"),
                              ));
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }

                            widget.refresh();
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text(
                                "Please enter valid values for all fields."),
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                          ));
                        }
                      }),
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
                                      if (widget.communityService != null) {
                                        await supabase
                                            .from("community_service")
                                            .delete()
                                            .match({
                                          'id': widget.communityService!.id
                                        });
                                      }

                                      if ((context.mounted)) {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        widget.refresh();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Event successfully deleted"),
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
            )),
      ),
    );
  }
}
