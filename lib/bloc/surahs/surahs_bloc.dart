import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tafsiri_muyassar/models/surah.dart';

import '../../repositories/local/box_repository.dart';

part 'surahs_event.dart';
part 'surahs_state.dart';

class SurahsBloc extends Bloc<SurahsEvent, SurahsState> {
  final BoxRepository<Surah> _surahBox;

  SurahsBloc(this._surahBox) : super(SurahsState()) {
    on<GetSurahsEvent>(_onGetSurahs);
  }

  void _onGetSurahs(GetSurahsEvent event, Emitter<SurahsState> emit) async {
    try {
      List<Surah> surahs = _surahBox.getAll();
      emit(state.copyWith(surahs: surahs));
    } catch (e) {
      print("SURAH CATCH: $e");
      emit(state.copyWith(isError: true, error: 'Error has occurred'));
    }
  }

  @override
  Future<void> close() {
    _surahBox.close();
    return super.close();
  }
}
