// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sky_board/custom_item_page/custom_item_page.dart';
import 'package:sky_board/models/custom_item.dart';

class CustomTile extends StatelessWidget {
  final CustomItem item;
  final Future<void> Function() refresh;

  const CustomTile({
    Key? key,
    required this.item,
    required this.refresh,
  }) : super(key: key);

  IconData getIcon(String type) {
    if (type == "work") return Icons.work_rounded;
    if (type == "award") return Icons.emoji_events_rounded;
    if (type == "athletics") return Icons.sports_football_rounded;
    if (type == "arts") return Icons.theater_comedy_rounded;
    if (type == "leadership") return Icons.handshake_rounded;
    if (type == "club") return Icons.groups_2_rounded;
    return Icons.emoji_objects_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CustomItemPage(
                      refresh: refresh,
                      item: item,
                    )));
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
                ),
              ],
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Row(
                children: [
                  Icon(
                    getIcon(item.type),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          item.description,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
