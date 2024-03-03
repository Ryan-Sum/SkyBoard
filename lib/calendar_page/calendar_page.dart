import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:icalendar_parser/icalendar_parser.dart';
import 'package:sky_board/calendar_page/calendar.dart';
import 'package:sky_board/calendar_page/event.dart';
import 'package:sky_board/calendar_page/user_event.dart';
import 'package:sky_board/main.dart';

import 'package:flutter/services.dart' show rootBundle;

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late List<Event> events;
  List<UserEvent> userEvents = [];

  Future<void> _cal() async {
    final icsString =
        await rootBundle.loadString('assets/calendar/icalfeed.ics');
    final iCalendar = ICalendar.fromString(icsString);
    final json = iCalendar.toJson().entries.last.value;
    events = <Event>[];
    for (var element in json) {
      events.add(Event.fromJson(jsonEncode(element)));
    }

    userEvents = [];
    List<Map<String, dynamic>> eventData =
        await supabase.from('event').select();
    for (var element in eventData) {
      UserEvent userEvent = UserEvent.fromMap(element);
      userEvents.add(userEvent);
    }
  }

  Future<void> _refreshCal() async {
    final icsString =
        await rootBundle.loadString('assets/calendar/icalfeed.ics');
    final iCalendar = ICalendar.fromString(icsString);
    final json = iCalendar.toJson().entries.last.value;
    events = <Event>[];
    for (var element in json) {
      setState(() {
        events.add(Event.fromJson(jsonEncode(element)));
      });
    }

    userEvents = [];
    List<Map<String, dynamic>> eventData =
        await supabase.from('event').select();
    for (var element in eventData) {
      UserEvent userEvent = UserEvent.fromMap(element);
      setState(() {
        userEvents.add(userEvent);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: _cal(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              case ConnectionState.done:
                {
                  return Calendar(
                    refresh: _refreshCal,
                    events: events,
                    userEvents: userEvents,
                  );
                }
            }
          }),
    );
  }
}
