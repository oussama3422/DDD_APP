part of 'sign_in_bloc.dart';

@freezed
class SignInEvent with _$SignInEvent {
  // const factory SignInEvent.started() = _Started;
  const factory SignInEvent.emailChanged(String emailStr) = EmailChanged;
  const factory SignInEvent.passwordChanged(String passStr) = PasswordChanged;
  const factory SignInEvent.registerWithEmailAndPasswordPressed() = RegisterWithEmailAndPasswordPressed;
  const factory SignInEvent.signInWithEmailAndPasswordPressed() = SignInWithEmailAndPasswordPressed;
  const factory SignInEvent.signInWithGooglePressed() = SignInWithGooglePressed;
}