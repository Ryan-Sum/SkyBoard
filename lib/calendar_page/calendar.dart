// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:sky_board/calendar_page/add_user_event.dart';
import 'package:sky_board/calendar_page/event.dart';
import 'package:sky_board/calendar_page/user_event.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    Key? key,
    required this.events,
    required this.userEvents,
    required this.refresh,
  }) : super(key: key);
  final List<Event> events;
  final List<UserEvent> userEvents;
  final Future<void> Function() refresh;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final DateTime _firstDay = DateTime(2023, 8, 10);
  final DateTime _lastDay = DateTime(2025, 5, 30);
  DateTime _focusedDay = DateTime.now();
  List<Event> _selectedEvents = <Event>[];
  List<UserEvent> _selectedUserEvents = <UserEvent>[];

  bool _selectedDayPredicate(DateTime day) {
    return isSameDay(_focusedDay, day);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
    });
    _getSelectedEvents();
  }

  void _getSelectedEvents() {
    _selectedEvents = <Event>[];
    _selectedUserEvents = <UserEvent>[];
    for (var element in widget.events) {
      if (isSameDay(_focusedDay, element.dtstart)) {
        setState(() {
          _selectedEvents.add(element);
        });
      }
    }

    for (var element in widget.userEvents) {
      if (isSameDay(_focusedDay, element.dtstart)) {
        setState(() {
          _selectedUserEvents.add(element);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          calendarBuilders: CalendarBuilders(
            headerTitleBuilder: (context, day) {
              return Row(
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  Text(
                    DateFormat("MMMM yyyy").format(day),
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return AddUserEvent(
                              refresh: widget.refresh,
                              selectedDate: _focusedDay,
                            );
                          },
                        ));
                      },
                      icon: const Icon(Icons.add)),
                ],
              );
            },
            singleMarkerBuilder: (context, day, event) {
              if (event is Event) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(1.0, 0, 1.0, 0),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(1.0, 0, 1.0, 0),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                );
              }
            },
          ),
          eventLoader: (day) {
            List daysEvents = [];
            for (var element in widget.events) {
              if (isSameDay(day, element.dtstart)) {
                daysEvents.add(element);
              }
            }
            for (var element in widget.userEvents) {
              if (isSameDay(day, element.dtstart)) {
                daysEvents.add(element);
              }
            }
            return daysEvents;
          },
          calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary),
              todayDecoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Theme.of(context).colorScheme.primary, width: 2),
              ),
              todayTextStyle:
                  TextStyle(color: Theme.of(context).colorScheme.onSurface)),
          focusedDay: _focusedDay,
          firstDay: _firstDay,
          lastDay: _lastDay,
          selectedDayPredicate: _selectedDayPredicate,
          onDaySelected: _onDaySelected,
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
        ),
        const Divider(),
        _selectedEvents.isEmpty && _selectedUserEvents.isEmpty
            ? const Text("No Events Selected")
            : ListView.builder(
                shrinkWrap: true,
                itemCount: _selectedEvents.length + _selectedUserEvents.length,
                itemBuilder: (context, index) {
                  return index < _selectedEvents.length
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return buildSheet(
                                          context, _selectedEvents[index]);
                                    },
                                  );
                                },
                                icon: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Tooltip(
                                      message: "District calendar event",
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      _selectedEvents[index].summary,
                                      textAlign: TextAlign.left,
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Divider()
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return buildUserSheet(
                                          context,
                                          _selectedUserEvents[
                                              index - _selectedEvents.length],
                                          widget.refresh);
                                    },
                                  );
                                },
                                icon: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Tooltip(
                                      message: "User added event",
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      _selectedUserEvents[
                                              index - _selectedEvents.length]
                                          .summary,
                                      textAlign: TextAlign.left,
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Divider()
                          ],
                        );
                },
              ),
      ],
    );
  }
}

Widget buildSheet(BuildContext context, Event data) {
  return Container(
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16))),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 0, 32, 32),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Spacer(),
                Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      width: 32,
                      height: 8,
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
            Text(
              data.summary,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
                '${DateFormat('EEEE, MMM d, yyyy @').add_jm().format(data.dtstart)}\n${data.location ?? "No Location"}'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Text(
                data.description == null ? "No Description" : data.description!,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildUserSheet(
    BuildContext context, UserEvent data, Future<void> Function() refresh) {
  return Container(
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16))),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 0, 32, 32),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Spacer(),
                Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      width: 32,
                      height: 8,
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
            Text(
              data.summary,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              children: [
                Text(
                    '${DateFormat('EEEE, MMM d, yyyy @').add_jm().format(data.dtstart)}\n${data.location ?? "No Location"}'),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return AddUserEvent(
                            selectedDate: DateTime.now(),
                            refresh: refresh,
                            userEvent: data,
                          );
                        },
                      ));
                    },
                    icon: const Icon(Icons.edit))
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Text(
                data.description == null ? "No Description" : data.description!,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
