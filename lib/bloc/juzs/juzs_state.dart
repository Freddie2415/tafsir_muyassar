part of 'juzs_bloc.dart';

class JuzsState {
  final bool isLoading;
  final bool isError;
  final String? error;
  final List<Juz> juzs;

  JuzsState({
    this.isError = false,
    this.error,
    this.isLoading = true,
    this.juzs = const [],
  });

  JuzsState copyWith({
    bool isLoading = false,
    bool isError = false,
    String? error,
    List<Juz>? juzs,
  }) {
    return JuzsState(
      isLoading: isLoading,
      isError: isError,
      error: error ?? this.error,
      juzs: juzs ?? this.juzs,
    );
  }
}
