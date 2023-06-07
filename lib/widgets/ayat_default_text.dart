import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsiri_muyassar/bloc/font/font_bloc.dart';
import 'package:tafsiri_muyassar/bloc/show_translation_cubit.dart';

class AyatDefaultText extends StatelessWidget {
  final String title;
  final TextStyle? textStyle;
  final TextAlign? textAlign;

  const AyatDefaultText({
    Key? key,
    required this.title,
    this.textStyle,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ShowTranslationCubit translationCubit =
        BlocProvider.of(context, listen: true);

    if (!translationCubit.state) return const SizedBox();

    return BlocBuilder<FontBloc, FontState>(
      builder: (context, state) {
        return Text(
          title,
          textAlign: textAlign ?? TextAlign.justify,
          style: textStyle ??
              TextStyle(
                fontSize: 16 * state.fontScaling,
              ),
        );
      },
    );
  }
}
