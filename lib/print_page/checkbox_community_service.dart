// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sky_board/models/community_service.dart';

class CheckboxCommunityService extends StatefulWidget {
  final CommunityService service;
  final void Function(bool) onTap;

  const CheckboxCommunityService({
    Key? key,
    required this.service,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CheckboxCommunityService> createState() =>
      _CheckboxCommunityServiceState();
}

class _CheckboxCommunityServiceState extends State<CheckboxCommunityService> {
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
              Text(
                  "${DateFormat('M/d/y').format(widget.service.date)} @ ${widget.service.organizationName}"),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Hours ${widget.service.hours}"),
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
