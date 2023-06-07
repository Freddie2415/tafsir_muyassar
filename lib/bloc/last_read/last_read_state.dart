part of 'last_read_cubit.dart';

@immutable
abstract class LastReadState {}

class LastReadInitial extends LastReadState {}

class LastReadSaved extends LastReadState {
  final Chapter chapter;
  final Ayat ayat;

  LastReadSaved({
    required this.chapter,
    required this.ayat,
  });
}
