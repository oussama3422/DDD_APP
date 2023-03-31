import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/domain/auth/core/errors.dart';
import 'package:flutter_application_1/domain/auth/i_auth_facade.dart';
import 'package:flutter_application_1/domain/auth/value_objects.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@named
@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  FirebaseAuthFacade(
    this._firebaseAuth,
    this._googleSignIn,
  );

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required EmailAdress emailAdress, required Password password}) async {
    final emailAdressString = emailAdress.getOrCrach();
    final passwordToString = password.getOrCrach();
    // final passwordToString=password.value.getOrElse(() => 'Failure');
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailAdressString, password: passwordToString);
      return right(unit);
    } on PlatformException catch (error) {
      if (error.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        return left(AuthFailure.emailAlreadyInUse());
      } else {
        return left(AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required EmailAdress emailAdress, required Password password}) async {
    final emailAdressString = emailAdress.getOrCrach();
    final passwordToString = password.getOrCrach();
    // final passwordToString=password.value.getOrElse(() => 'Failure');
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: emailAdressString,
          password: passwordToString
          );
      return right(unit);
    } on PlatformException catch (error) {
      if (error.code == 'wrong-password' || error.code == 'user-not-found' ) {
        return left(AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async{
    try{
   final googleUser= await _googleSignIn.signIn();
   if(googleUser==null){
    return left(AuthFailure.cancelledByUser());
   }
   final googleAuthentication = await googleUser.authentication;
   final googleAuthCredential= GoogleAuthProvider.credential(idToken: googleAuthentication.idToken,accessToken:googleAuthentication.accessToken,);
   return  _firebaseAuth.signInWithCredential(googleAuthCredential).then((value) {
      return right(unit);
    });
    } on PlatformException catch(_){
       return left(AuthFailure.serverError()); 
    }
  }

  
}
