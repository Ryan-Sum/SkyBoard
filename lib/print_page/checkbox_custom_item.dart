// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sky_board/models/course.dart';
import 'package:sky_board/models/custom_item.dart';

class CheckboxCustomItem extends StatefulWidget {
  final CustomItem item;
  final void Function(bool) onTap;

  const CheckboxCustomItem({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CheckboxCustomItem> createState() => _CheckboxCustomItemState();
}

class _CheckboxCustomItemState extends State<CheckboxCustomItem> {
  String getType(String type) {
    if (type == "work") return "Work Experience";
    if (type == "award") return "Award/Achievement";
    if (type == "athletics") return "Athletic Participation";
    if (type == "arts") return "Performing Arts";
    if (type == "leadership") return "Leadership Position";
    if (type == "club")
      return "Club Membership";
    else
      return "Other";
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox.adaptive(
                  value: isChecked,
                  onChanged: (x) {
                    setState(() {
                      isChecked = x!;
                    });
                    widget.onTap(x!);
                  }),
              Text(widget.item.title),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(getType(widget.item.type)),
              ),
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}
