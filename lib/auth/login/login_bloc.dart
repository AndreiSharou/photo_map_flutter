import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth_cubit.dart';
import '/auth/auth_repository.dart';
import '/auth/form_submission_status.dart';
import '/auth/login/login_event.dart';
import '/auth/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc({required this.authRepo, required this.authCubit})  : super(LoginState()) {
    on<LoginUsernameChanged>(_handleLoginUsernameChangedEvent);
    on<LoginPasswordChanged>(_handleLoginPasswordChangedEvent);
    on<LoginSubmitted>(_handleLoginWithEmailAndPasswordEvent);

  }
  
  Future<void> _handleLoginUsernameChangedEvent(
      LoginUsernameChanged event,
      Emitter<LoginState> emit,
      ) async {
    emit(state.copyWith(username: event.username));
  }

  Future<void> _handleLoginPasswordChangedEvent(
      LoginPasswordChanged event,
      Emitter<LoginState> emit,
      ) async {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _handleLoginWithEmailAndPasswordEvent(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    try {
      await authRepo.signIn(
        email: state.username,
        password: state.password,
      );
      emit(state.copyWith(formStatus: SubmissionSuccess()));

      authCubit.launchSession();
    } catch (e) {
      emit(state.copyWith(formStatus: SubmissionFailed(Exception(e.toString()))));
    }
  }

}
