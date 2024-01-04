// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sky_board/models/community_service.dart';
import 'package:sky_board/service_hours/custom_widgets/edit_event.dart';

class EventTile extends StatefulWidget {
  const EventTile({
    Key? key,
    required this.refresh,
    required this.service,
  }) : super(key: key);
  final Future<void> Function() refresh;

  final CommunityService service;

  @override
  State<EventTile> createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditEventPage(
                    refresh: widget.refresh,
                    communityService: widget.service,
                  ),
                ));
          },
          icon: Row(
            children: [
              (widget.service.isVerified)
                  ? const Tooltip(
                      message: "Event verified.",
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                      ),
                    )
                  : Tooltip(
                      message: "Event not verified.",
                      child: Icon(
                        Icons.remove_circle_outline,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.service.organizationName),
                  Row(
                    children: [
                      Text(
                        widget.service.hours == 1
                            ? "${widget.service.hours} hour  |"
                            : "${widget.service.hours} hours  |",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        "  ${widget.service.date.month.toString()}/${widget.service.date.day.toString()}/${widget.service.date.year.toString()}",
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  )
                ],
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ));
  }
}
