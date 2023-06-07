part of 'font_bloc.dart';

class FontState {
  final double fontScaling;

  FontState({this.fontScaling = 1.0});

  FontState copyWith({required double fontScaling}) {
    return FontState(fontScaling: fontScaling);
  }
}

class FontInitial extends FontState {}
