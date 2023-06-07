part of 'font_bloc.dart';

@immutable
abstract class FontEvent {}

class SetDefaultFontSizeEvent extends FontEvent {}

class ChangeFontSizeEvent extends FontEvent {
  final bool decrease;

  ChangeFontSizeEvent({this.decrease = false});
}