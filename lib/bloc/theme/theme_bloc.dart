import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences _preferences;

  ThemeBloc(this._preferences) : super(ThemeState()) {
    on<SetDefaultThemeEvent>(_onSetDefaultTheme);
    on<ChangeThemeEvent>(_onChangeTheme);
  }

  _onSetDefaultTheme(SetDefaultThemeEvent event, Emitter<ThemeState> emit) {
    bool? isDark = _preferences.getBool('isDark');
    if (isDark != null) emit(state.copyWith(isDark: isDark));
  }

  _onChangeTheme(ChangeThemeEvent event, Emitter<ThemeState> emit) {
    bool newTheme = !state.isDark;
    emit(state.copyWith(isDark: newTheme));
    _preferences.setBool('isDark', newTheme);
  }
}
