import 'package:flutter/material.dart';
import 'package:tafsiri_muyassar/screens/search_screen.dart';

class LayoutAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const LayoutAppBar({
    Key? key,
    required this.title,
    this.actions,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  State<LayoutAppBar> createState() => _LayoutAppBarState();
}

class _LayoutAppBarState extends State<LayoutAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: widget.actions ??
          [
            IconButton(
              onPressed: () {
                Navigator.push(context, SearchScreen.route());
              },
              icon: const Icon(Icons.search),
            )
          ],
    );
  }
}
