import 'package:shared_preferences/shared_preferences.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'font_event.dart';

part 'font_state.dart';

class FontBloc extends Bloc<FontEvent, FontState> {
  final SharedPreferences _preferences;

  FontBloc(this._preferences) : super(FontState()) {
    on<SetDefaultFontSizeEvent>(_onSetDefaultFontSize);
    on<ChangeFontSizeEvent>(_onChangeFontSize);
  }

  _onSetDefaultFontSize(
      SetDefaultFontSizeEvent event, Emitter<FontState> emit) {
    double? val = _preferences.getDouble('fontSize');
    if (val != null) emit(state.copyWith(fontScaling: val));
  }

  _onChangeFontSize(ChangeFontSizeEvent event, Emitter<FontState> emit) {
    double val =
        event.decrease ? state.fontScaling - 0.2 : state.fontScaling + 0.2;
    emit(state.copyWith(fontScaling: val));
    _preferences.setDouble('fontSize', val);
  }
}
