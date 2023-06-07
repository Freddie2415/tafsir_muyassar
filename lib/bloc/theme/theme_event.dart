part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class SetDefaultThemeEvent extends ThemeEvent {}
class ChangeThemeEvent extends ThemeEvent {}