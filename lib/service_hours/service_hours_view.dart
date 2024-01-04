// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sky_board/global_widgets/custom_app_bar.dart';
import 'package:sky_board/models/community_service.dart';
import 'package:sky_board/service_hours/custom_widgets/edit_event.dart';
import 'package:sky_board/service_hours/custom_widgets/event_tile.dart';

class ServiceHoursView extends StatefulWidget {
  final double hours;
  final List<CommunityService> services;
  final Future<void> Function() refresh;

  const ServiceHoursView({
    Key? key,
    required this.hours,
    required this.services,
    required this.refresh,
  }) : super(key: key);

  @override
  State<ServiceHoursView> createState() => _ServiceHoursViewState();
}

class _ServiceHoursViewState extends State<ServiceHoursView> {
  @override
  void initState() {
    widget.services.sort(
      (a, b) {
        return b.date.compareTo(a.date);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).colorScheme.tertiary,
                  child: SizedBox(
                    height: 128,
                    child: Row(
                      children: [
                        const Spacer(),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.hours.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "hours",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary),
                              ),
                            ],
                          ),
                        ),
                        const Spacer()
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        "Events (${widget.services.length})",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditEventPage(refresh: widget.refresh)),
                            );
                          },
                          icon: Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.tertiary,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverList.builder(
            itemCount: widget.services.length,
            itemBuilder: (context, index) {
              return EventTile(
                service: widget.services[index],
                refresh: widget.refresh,
              );
            },
          )
        ],
      ),
    );
  }
}
