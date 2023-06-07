part of 'surahs_bloc.dart';

class SurahsState {
  final bool isLoading;
  final bool isError;
  final String? error;
  final List<Surah> surahs;

  SurahsState({
    this.isError = false,
    this.error,
    this.isLoading = true,
    this.surahs = const [],
  });

  SurahsState copyWith({
    bool isError = false,
    bool isLoading = false,
    String? error,
    List<Surah>? surahs,
  }) {
    return SurahsState(
      error: error ?? this.error,
      isError: isError,
      isLoading: isLoading,
      surahs: surahs ?? this.surahs,
    );
  }
}
