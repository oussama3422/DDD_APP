import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/domain/auth/auth_failure.dart';

import 'value_objects.dart';

// FirebaseAuth ,GoogleSignIn

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAdress emailAdress,
    required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAdress emailAdress,
    required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  //Example instead of return Unit here we might return String cause we know what comes in
  // Future<Either<AuthFailure, String>> returnsAValueString();
}
