part of 'sign_in_bloc.dart';

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState({
    required EmailAdress emailAdress,
    required Password password,
    required bool showErrorMessages,
    required bool isSubmitting,
    required  Option<Either<AuthFailure,Unit>> authFailureOrSucess,
  }) = _SignInState;


  factory SignInState.initial() => SignInState(
    emailAdress: EmailAdress(''),
    password: Password(''),
    showErrorMessages: true,
    isSubmitting:false,
    authFailureOrSucess: none(),
  );
} 

