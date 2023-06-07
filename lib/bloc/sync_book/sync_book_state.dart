part of 'sync_book_cubit.dart';

@immutable
abstract class SyncBookState {}

class SyncBookInitial extends SyncBookState {}

class SyncBookLoading extends SyncBookState {
  final String message;

  SyncBookLoading([this.message = "Loading..."]);
}

class SyncBookFailure extends SyncBookState {
  final String message;

  SyncBookFailure(this.message);
}

class SyncBookSuccess extends SyncBookState {}
