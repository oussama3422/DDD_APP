import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/domain/auth/i_auth_facade.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/auth/auth_failure.dart';
import '../../../domain/auth/value_objects.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';
part 'sign_in_bloc.freezed.dart';



class SignInBloc extends Bloc<SignInEvent, SignInState> {
  IAuthFacade _authFacade;
  SignInBloc(this._authFacade) : super(SignInState.initial()) {
    on<SignInEvent>((event, emit) async {
      if (event is EmailChanged) {
        // Handle EmailChanged event
        emit(state.copyWith(
          emailAdress: EmailAdress(event.emailStr),
          authFailureOrSucess: none(),
        ));
      } else if (event is PasswordChanged) {
        // Handle PasswordChanged event
      } else if (event is RegisterWithEmailAndPasswordPressed) {
        // Handle RegisterWithEmailAndPasswordPressed event
        emit(_performActionOnAuthFacadeWithEmailEmailAndPassword(_authFacade.registerWithEmailAndPassword));
      } else if (event is SignInWithEmailAndPasswordPressed) {
        // Handle SignInWithEmailAndPasswordPressed event
        emit(_performActionOnAuthFacadeWithEmailEmailAndPassword(_authFacade.signInWithEmailAndPassword));
      } else if (event is SignInWithGooglePressed) {
        // Handle SignInWithGooglePressed event
        final isEmailValid = state.emailAdress.isValid();
        final isPasswordValid = state.password.isValid();
        var failureOrSuccess;
        if (isEmailValid && isPasswordValid) {
          emit(state.copyWith(
            isSubmitting: true,
            authFailureOrSucess: none(),
          ));
          failureOrSuccess = await _authFacade.signInWithEmailAndPassword(
              emailAdress: state.emailAdress, password: state.password);
        }
        emit(state.copyWith(isSubmitting: false,showErrorMessages: true,   authFailureOrSucess: optionOf(failureOrSuccess)));
          // authFailureOrSucess:failureOrSuccess==null?none():some(failureOrSuccess),
          //+++++++++ Same That above ++++++
        emit(state.copyWith(isSubmitting: true,authFailureOrSucess: none(),));
        var failureOrScuess = await _authFacade.signInWithGoogle();
        emit(state.copyWith(isSubmitting: false, authFailureOrSucess: some(failureOrScuess)));
      }
   
    });
  }

   _performActionOnAuthFacadeWithEmailEmailAndPassword(
   Future<Either<AuthFailure, Unit>> Function({
    required EmailAdress emailAdress, required Password password
    })
    forwardedCall, 
  )async {
    Either<AuthFailure,Unit> failureOrSucess;
        // ignore: invalid_use_of_visible_for_testing_member

      final isEmailValid = state.emailAdress.isValid();
        final isPasswordValid = state.password.isValid();
        var failureOrSuccess;
        if (isEmailValid && isPasswordValid) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(
            state.copyWith(isSubmitting: true,authFailureOrSucess: none(),));
            failureOrSuccess = await forwardedCall(emailAdress: state.emailAdress, password: state.password);
        }
        // ignore: invalid_use_of_visible_for_testing_member
        emit(
          state.copyWith(isSubmitting: false,showErrorMessages: true,authFailureOrSucess: optionOf(failureOrSuccess),
          // authFailureOrSucess:failureOrSuccess==null?none():some(failureOrSuccess),
          //+++++++++ Same That above ++++++
        ));
        // ignore: invalid_use_of_visible_for_testing_member
        emit(state.copyWith(
          isSubmitting: true,
          authFailureOrSucess: none(),
        ));
        var failureOrScuess = await _authFacade.signInWithGoogle();
        // ignore: invalid_use_of_visible_for_testing_member
        emit(state.copyWith( isSubmitting: false, authFailureOrSucess: some(failureOrScuess)));
  }
}
