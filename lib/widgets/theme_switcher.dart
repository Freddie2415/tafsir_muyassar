import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsiri_muyassar/bloc/theme/theme_bloc.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context, listen: true);

    return Switch(value: themeBloc.state.isDark, onChanged: (_) {
      themeBloc.add(ChangeThemeEvent());
    });
  }
}
