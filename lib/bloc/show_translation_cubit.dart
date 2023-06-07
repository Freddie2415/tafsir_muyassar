import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowTranslationCubit extends Cubit<bool> {
  final SharedPreferences _preferences;

  ShowTranslationCubit(this._preferences) : super(true);

  setDefaultTranslationState() {
    final defaultState = _preferences.getBool('show_translation');
    if (defaultState != null) emit(defaultState);
  }

  handleChangeTranslationState() {
    _preferences.setBool('show_translation', !state);
    emit(!state);
  }
}
