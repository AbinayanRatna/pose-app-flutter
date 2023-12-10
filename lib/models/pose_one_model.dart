import 'package:flutter_bloc/flutter_bloc.dart';
enum PoseState {
  neutral,
  correct,
  incorrect,
}

class PoseDetector extends Cubit<PoseState> {
  PoseDetector() : super(PoseState.neutral);

  void setPoseState(PoseState current) {
    emit(current);
  }

  void poseDetected(bool isCorrect) {
    if (isCorrect) {
      emit(PoseState.correct);
    } else {
      emit(PoseState.incorrect);
    }
  }

  void reset() {
    emit(PoseState.neutral);
  }
}
