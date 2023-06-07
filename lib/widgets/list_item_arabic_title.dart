import 'package:flutter/material.dart';

class ListItemArabicTitle extends StatelessWidget {
  final String title;

  const ListItemArabicTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyMedium?.color,
        fontSize: 16,
      ),
    );
  }
}
