import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsiri_muyassar/bloc/font/font_bloc.dart';

class AyatArabText extends StatelessWidget {
  final String title;

  const AyatArabText({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FontBloc fontBloc = BlocProvider.of(context, listen: true);
    return Text(
      title,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontSize: 26 * fontBloc.state.fontScaling,
      ),
    );
  }
}
