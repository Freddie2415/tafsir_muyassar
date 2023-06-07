import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/juz.dart';
import '../../repositories/local/box_repository.dart';

part 'juzs_event.dart';

part 'juzs_state.dart';

class JuzsBloc extends Bloc<JuzsEvent, JuzsState> {
  final BoxRepository<Juz> _juzsBoxRepo;

  JuzsBloc(this._juzsBoxRepo) : super(JuzsState()) {
    on<GetJuzsEvent>(_onGetJuzs);
  }

  void _onGetJuzs(GetJuzsEvent event, Emitter<JuzsState> emit) async {
    try {
      final List<Juz> juzs = _juzsBoxRepo.getAll();
      emit(state.copyWith(juzs: juzs));
    } catch (e) {
      emit(state.copyWith(isError: true, error: 'An error occurred'));
    }
  }

  @override
  Future<void> close() {
    _juzsBoxRepo.close();
    return super.close();
  }
}
