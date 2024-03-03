// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:uuid/uuid.dart';

import 'package:sky_board/global_widgets/cta_button.dart';
import 'package:sky_board/global_widgets/custom_app_bar.dart';
import 'package:sky_board/global_widgets/custom_text_input.dart';
import 'package:sky_board/main.dart';
import 'package:sky_board/models/act_score.dart';
import 'package:sky_board/models/sat_score.dart';

class EditTests extends StatefulWidget {
  final SATScore? satScore;
  final ACTScore? actScore;
  final Future<void> Function() refresh;

  const EditTests({
    Key? key,
    this.satScore,
    this.actScore,
    required this.refresh,
  }) : super(key: key);

  @override
  State<EditTests> createState() => _EditTestsState();
}

class _EditTestsState extends State<EditTests> {
  bool? isSat;

  late TextEditingController mathController;
  late TextEditingController englishController;
  late TextEditingController scienceController;
  late TextEditingController readingController;
  late TextEditingController dateController;
  late DateTime? date;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    if (widget.satScore != null) {
      isSat = true;
      mathController = TextEditingController.fromValue(
          TextEditingValue(text: widget.satScore!.math.toString()));
      englishController = TextEditingController.fromValue(
          TextEditingValue(text: widget.satScore!.english.toString()));
      scienceController = TextEditingController();
      readingController = TextEditingController();
      date = widget.satScore!.dateTaken;
      dateController = TextEditingController.fromValue(TextEditingValue(
          text:
              "${widget.satScore!.dateTaken.month}/${widget.satScore!.dateTaken.day}/${widget.satScore!.dateTaken.year}"));
      formKey = GlobalKey<FormState>();
    } else if (widget.actScore != null) {
      isSat = false;
      mathController = TextEditingController.fromValue(
          TextEditingValue(text: widget.actScore!.math.toString()));
      englishController = TextEditingController.fromValue(
          TextEditingValue(text: widget.actScore!.english.toString()));
      scienceController = TextEditingController.fromValue(
          TextEditingValue(text: widget.actScore!.science.toString()));
      readingController = TextEditingController.fromValue(
          TextEditingValue(text: widget.actScore!.reading.toString()));
      date = widget.actScore!.dateTaken;
      dateController = TextEditingController.fromValue(TextEditingValue(
          text:
              "${widget.actScore!.dateTaken.month}/${widget.actScore!.dateTaken.day}/${widget.actScore!.dateTaken.year}"));
      formKey = GlobalKey<FormState>();
    } else {
      isSat = null;
      mathController = TextEditingController();
      englishController = TextEditingController();
      scienceController = TextEditingController();
      readingController = TextEditingController();
      dateController = TextEditingController();
      formKey = GlobalKey<FormState>();
    }

    super.initState();
  }

  @override
  void dispose() {
    mathController.dispose();
    englishController.dispose();
    scienceController.dispose();
    readingController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: formKey,
            child: SafeArea(
              child: Column(
                children: [
                  DropdownButtonFormField(
                    onChanged: (x) {
                      if (x == "default") {
                        setState(() {
                          isSat = null;
                        });
                      } else if (x == "sat") {
                        setState(() {
                          isSat = true;
                        });
                      } else if (x == "act") {
                        setState(() {
                          isSat = false;
                        });
                      }
                    },
                    validator: (value) {
                      if (value == "default") {
                        return "Please Select a Value";
                      }
                      return null;
                    },
                    value: isSat == null
                        ? 'default'
                        : isSat!
                            ? "sat"
                            : "act",
                    items: [
                      DropdownMenuItem(
                        value: 'default',
                        child: Text(
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black38),
                            'Test Type'),
                      ),
                      DropdownMenuItem(
                        value: 'sat',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'SAT'),
                      ),
                      DropdownMenuItem(
                        value: 'act',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'ACT'),
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
                  ),
                  Builder(
                    builder: (context) {
                      if (isSat == null) {
                        return Container();
                      } else if (isSat!) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextInput(
                                validator: (p0) {
                                  if (p0 == null || int.tryParse(p0) == null) {
                                    return "Value must be a positive integer";
                                  }
                                  if (!(int.parse(p0) >= 0) ||
                                      !(int.parse(p0) <= 800)) {
                                    return "Value must be in the range 0-800";
                                  }
                                  return null;
                                },
                                controller: englishController,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                autofillHints: const [],
                                hintText: "English Section Score",
                                textInputAction: TextInputAction.next),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextInput(
                                validator: (p0) {
                                  if (p0 == null || int.tryParse(p0) == null) {
                                    return "Value must be a positive integer";
                                  }
                                  if (!(int.parse(p0) >= 0) ||
                                      !(int.parse(p0) <= 800)) {
                                    return "Value must be in the range 0-800";
                                  }
                                  return null;
                                },
                                controller: mathController,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                autofillHints: const [],
                                hintText: "Math Section Score",
                                textInputAction: TextInputAction.next),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextInput(
                              onTap: () async {
                                date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime.now());
                                if (date != null) {
                                  dateController.setText(
                                      "${date!.month}/${date!.day}/${date!.year}");
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
                              controller: dateController,
                              obscureText: false,
                              keyboardType: TextInputType.none,
                              autofillHints: const [],
                              hintText: "Date of Test",
                              textInputAction: TextInputAction.next,
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextInput(
                                validator: (p0) {
                                  if (p0 == null || int.tryParse(p0) == null) {
                                    return "Value must be a positive integer";
                                  }
                                  if (!(int.parse(p0) >= 0) ||
                                      !(int.parse(p0) <= 36)) {
                                    return "Value must be in the range 0-36";
                                  }
                                  return null;
                                },
                                controller: englishController,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                autofillHints: const [],
                                hintText: "English Section Score",
                                textInputAction: TextInputAction.next),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextInput(
                                validator: (p0) {
                                  if (p0 == null || int.tryParse(p0) == null) {
                                    return "Value must be a positive integer";
                                  }
                                  if (!(int.parse(p0) >= 0) ||
                                      !(int.parse(p0) <= 36)) {
                                    return "Value must be in the range 0-36";
                                  }
                                  return null;
                                },
                                controller: mathController,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                autofillHints: const [],
                                hintText: "Math Section Score",
                                textInputAction: TextInputAction.next),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextInput(
                                validator: (p0) {
                                  if (p0 == null || int.tryParse(p0) == null) {
                                    return "Value must be a positive integer";
                                  }
                                  if (!(int.parse(p0) >= 0) ||
                                      !(int.parse(p0) <= 36)) {
                                    return "Value must be in the range 0-36";
                                  }
                                  return null;
                                },
                                controller: scienceController,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                autofillHints: const [],
                                hintText: "Science Section Score",
                                textInputAction: TextInputAction.next),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextInput(
                                validator: (p0) {
                                  if (p0 == null || int.tryParse(p0) == null) {
                                    return "Value must be a positive integer";
                                  }
                                  if (!(int.parse(p0) >= 0) ||
                                      !(int.parse(p0) <= 36)) {
                                    return "Value must be in the range 0-36";
                                  }
                                  return null;
                                },
                                controller: readingController,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                autofillHints: const [],
                                hintText: "Reading Section Score",
                                textInputAction: TextInputAction.next),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextInput(
                              onTap: () async {
                                date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime.now());
                                if (date != null) {
                                  dateController.setText(
                                      "${date!.month}/${date!.day}/${date!.year}");
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
                              controller: dateController,
                              obscureText: false,
                              keyboardType: TextInputType.none,
                              autofillHints: const [],
                              hintText: "Date of Test",
                              textInputAction: TextInputAction.next,
                            ),
                          ],
                        );
                      }
                    },
                  ),
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
                            if (isSat!) {
                              SATScore score = SATScore(
                                  id: widget.satScore == null
                                      ? const Uuid().v4()
                                      : widget.satScore!.id,
                                  studentId: supabase.auth.currentUser!.id,
                                  math: int.parse(mathController.text.trim()),
                                  english:
                                      int.parse(englishController.text.trim()),
                                  dateTaken: date!);
                              await supabase
                                  .from("sat_scores")
                                  .upsert(score.toMap());
                            } else {
                              ACTScore score = ACTScore(
                                  id: widget.actScore == null
                                      ? const Uuid().v4()
                                      : widget.actScore!.id,
                                  studentId: supabase.auth.currentUser!.id,
                                  math: int.parse(mathController.text.trim()),
                                  english:
                                      int.parse(englishController.text.trim()),
                                  science:
                                      int.parse(scienceController.text.trim()),
                                  reading:
                                      int.parse(readingController.text.trim()),
                                  dateTaken: date!);
                              await supabase
                                  .from('act_scores')
                                  .upsert(score.toMap());
                            }
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
                                content:
                                    Text("Test Score successfully updated"),
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
                                title: const Text("Delete this test?"),
                                content: const Text(
                                    "Are you sure you would like to delete this test?"),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed: () => Navigator.pop(context),
                                    isDefaultAction: true,
                                    child: const Text("No"),
                                  ),
                                  CupertinoDialogAction(
                                    isDestructiveAction: true,
                                    onPressed: () async {
                                      if (widget.actScore != null) {
                                        await supabase
                                            .from("act_scores")
                                            .delete()
                                            .match({'id': widget.actScore!.id});
                                      } else if (widget.satScore != null) {
                                        await supabase
                                            .from("sat_scores")
                                            .delete()
                                            .match({'id': widget.satScore!.id});
                                      }

                                      if (context.mounted) {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        widget.refresh();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text("Test successfully deleted"),
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
                          Text("Delete Test",
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
