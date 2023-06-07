import 'package:flutter/material.dart';
import 'package:tafsiri_muyassar/bloc/show_translation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowTranslationButton extends StatelessWidget {
  const ShowTranslationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ShowTranslationCubit showTranslationCubit =
        BlocProvider.of(context, listen: true);
    return IconButton(
      onPressed: showTranslationCubit.handleChangeTranslationState,
      icon: Icon(
        showTranslationCubit.state ? Icons.text_fields : Icons.format_clear,
      ),
    );
  }
}
