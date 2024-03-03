// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sky_board/linkedin/linkedin_post.dart';
import 'package:uuid/uuid.dart';

import 'package:sky_board/global_widgets/cta_button.dart';
import 'package:sky_board/global_widgets/custom_app_bar.dart';
import 'package:sky_board/global_widgets/custom_text_input.dart';
import 'package:sky_board/main.dart';
import 'package:sky_board/models/custom_item.dart';

class CustomItemPage extends StatefulWidget {
  const CustomItemPage({
    Key? key,
    required this.refresh,
    this.item,
  }) : super(key: key);

  final Future<void> Function() refresh;
  final CustomItem? item;

  @override
  State<CustomItemPage> createState() => _CustomItemPageState();
}

class _CustomItemPageState extends State<CustomItemPage> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController linkController;
  late final GlobalKey<FormState> formState;
  String type = "default";

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.item?.title);
    descriptionController =
        TextEditingController(text: widget.item?.description);
    linkController = TextEditingController(text: widget.item?.link);
    formState = GlobalKey<FormState>();
    type = widget.item == null ? "default" : widget.item!.type;
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    linkController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
              key: formState,
              child: Column(
                children: [
                  DropdownButtonFormField(
                    value: type,
                    validator: (value) {
                      if (value == "default") {
                        return "Please Select a Value";
                      }
                      return null;
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'default',
                        child: Text(
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black38),
                            'Activity/Award Type'),
                      ),
                      DropdownMenuItem(
                        value: 'work',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Work Experience'),
                      ),
                      DropdownMenuItem(
                        value: 'award',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Award/Achievement'),
                      ),
                      DropdownMenuItem(
                        value: 'athletics',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Athletic Participation'),
                      ),
                      DropdownMenuItem(
                        value: 'arts',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Performing Arts'),
                      ),
                      DropdownMenuItem(
                        value: 'club',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Club/Organization Membership'),
                      ),
                      DropdownMenuItem(
                        value: 'leadership',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Leadership Position'),
                      ),
                      DropdownMenuItem(
                        value: 'other',
                        child: Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'Other'),
                      ),
                    ],
                    onChanged: (value) {
                      type = value!;
                    },
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
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextInput(
                    controller: titleController,
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    autofillHints: const [],
                    hintText: "Activity/Award Title",
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
                    controller: descriptionController,
                    obscureText: false,
                    keyboardType: TextInputType.multiline,
                    autofillHints: const [],
                    hintText: "Description",
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
                    controller: linkController,
                    obscureText: false,
                    keyboardType: TextInputType.multiline,
                    autofillHints: const [],
                    hintText: "Link (Optional)",
                    textInputAction: TextInputAction.next,
                    validator: (p0) {
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  (widget.item == null) ||
                          (supabase.auth.currentSession?.providerToken == null)
                      ? Container()
                      : TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return CupertinoAlertDialog(
                                    title: const Text("Share to Linkedin?"),
                                    content: const Text(
                                        "Are you sure you would like to share this item publically to your Linkedin Profile?"),
                                    actions: [
                                      CupertinoDialogAction(
                                        onPressed: () => Navigator.pop(context),
                                        isDefaultAction: true,
                                        child: const Text("No"),
                                      ),
                                      CupertinoDialogAction(
                                        onPressed: () async {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              });
                                          String? response =
                                              await LinkedinPost.postToLinkedin(
                                                  "${widget.item!.title}: ${widget.item!.description}",
                                                  widget.item!.link);

                                          if (response == "201") {
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Item successfully shared"),
                                              ));
                                            }
                                          } else {
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "An error occurred. Please try again later. Code: $response"),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .error,
                                              ));
                                            }
                                          }
                                          if (context.mounted) {
                                            Navigator.pop(context);

                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text("Yes"),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Share to Linkedin",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 118, 181),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: SvgPicture.asset(
                                      "assets/svgs/linkedIn_icon.svg"))
                            ],
                          )),
                  const Spacer(),
                  CTAButton(
                    text: "Save",
                    onTap: () async {
                      if (formState.currentState!.validate()) {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                        CustomItem activity = CustomItem(
                            id: widget.item == null
                                ? const Uuid().v4()
                                : widget.item!.id,
                            userId: supabase.auth.currentUser!.id,
                            type: type,
                            title: titleController.value.text,
                            description: descriptionController.value.text,
                            link: linkController.value.text.isEmpty
                                ? null
                                : linkController.value.text);
                        try {
                          await supabase
                              .from("custom_item")
                              .upsert(activity.toMap());
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
                              content: Text("Item successfully updated"),
                            ));
                            Navigator.pop(context);
                          }

                          widget.refresh();
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text(
                              "Please enter valid values for all required fields."),
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ));
                      }
                    },
                  )
                ],
              )),
        )));
  }
}
