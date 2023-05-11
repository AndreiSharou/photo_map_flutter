import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/auth_repository.dart';
import 'session_state.dart';


class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepo;

  SessionCubit({required this.authRepo}) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      final user = await authRepo.getCurrentUser();
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    } on Exception {
      emit(Unauthenticated());
    }
  }

  // void showAuth() => emit(Unauthenticated());
  //
  // // go homescreen
  void goToHomeScreen() {
    // final user = dataRepo.getUser(credentials.userId);
    attemptAutoLogin();
  }

  void signOut() {
    authRepo.signOut();
    emit(Unauthenticated());
  }
}
