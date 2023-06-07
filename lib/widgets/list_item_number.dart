import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class ListItemNumber extends StatelessWidget {
  final int number;
  const ListItemNumber({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: Svg(
                'assets/images/surah-border.svg')),
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.bodyLarge?.color
          ),
        ),
      ),
    );
  }
}
