import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../services/http_client.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit() : super(FeedbackInitial());

  final _httpClient = HttpClient();

  void send(String name, String email, String message) async {
    try {
      emit(FeedbackSending());

      await _httpClient.request.post(
        '/feedbacks',
        data: {
          'name': name,
          'email': email,
          'message': message,
        },
      );

      emit(FeedbackSent());
    } catch (e) {
      print(e);
      emit(FeedbackFailure(e.toString()));
    }
  }
}
