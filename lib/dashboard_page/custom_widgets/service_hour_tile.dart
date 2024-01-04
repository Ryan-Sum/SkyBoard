// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sky_board/models/community_service.dart';
import 'package:sky_board/service_hours/service_hours_view.dart';

class ServiceHourTile extends StatefulWidget {
  final double hours;
  final List<CommunityService> services;
  final Future<void> Function() refresh;

  const ServiceHourTile({
    Key? key,
    required this.hours,
    required this.services,
    required this.refresh,
  }) : super(key: key);

  @override
  State<ServiceHourTile> createState() => _ServiceHourTileState();
}

class _ServiceHourTileState extends State<ServiceHourTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServiceHoursView(
                refresh: widget.refresh,
                hours: widget.hours,
                services: widget.services,
              ),
            ));
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color(0x00000000).withOpacity(0.09),
                  offset: const Offset(0, 0),
                  blurRadius: 19,
                  spreadRadius: 5,
                )
              ],
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Row(
                children: [
                  Icon(
                    Icons.schedule_rounded,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Service Hours",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(widget.services.length == 1
                          ? "${widget.services.length} Event Entered"
                          : "${widget.services.length} Events Entered"),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 75,
                    width: 75,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.hours.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "hours",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
