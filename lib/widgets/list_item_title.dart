import 'package:flutter/material.dart';

class ListItemTitle extends StatelessWidget {
  final String title;

  const ListItemTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }
}
