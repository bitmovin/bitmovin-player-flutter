import 'package:flutter/material.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<StatefulWidget> createState() => EventsState();
}

class EventsState extends State<Events> {
  List<String> items = [];

  void add(String newItem) {
    if (items.isNotEmpty && items.first.startsWith(newItem)) {
      final count = _extractNumberFromString(items.first) + 1;
      final itemWithCount = "$newItem ($count)";
      setState(() {
        items[0] = itemWithCount;
      });
      return;
    }

    setState(() {
      items.insert(0, newItem);
    });
  }

  int _extractNumberFromString(String input) {
    final regex = RegExp(r'\((\d+)\)');
    final match = regex.firstMatch(input);
    if (match != null && match.groupCount >= 1) {
      final numberStr = match.group(1);
      return numberStr != null ? int.parse(numberStr) : 1;
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Text(items[index]);
      },
    );
  }
}
