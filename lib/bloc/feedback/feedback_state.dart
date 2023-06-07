part of 'feedback_cubit.dart';

@immutable
abstract class FeedbackState {}

class FeedbackInitial extends FeedbackState {}

class FeedbackSending extends FeedbackState {}

class FeedbackSent extends FeedbackState {}

class FeedbackFailure extends FeedbackState {
  final String message;

  FeedbackFailure(this.message);
}
