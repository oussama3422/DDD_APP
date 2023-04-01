import 'package:flutter_application_1/application/auth/sign_in_form/sign_in_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'domain/auth/i_auth_facade.dart';
import 'infrastructure/auth/firebase_auth_facade.dart';
final GetIt getIt = GetIt.instance;

void init(String env) {
// final firebaseInjectionMNodule = _$FirebaseInjectionModule();
// getIt.registerLazySingleton<FirebaseAuth>(() => firebaseInjectionMNodule.firebaseAuth);
getIt.registerFactory<SignInBloc>(() => SignInBloc(getIt<IAuthFacade>()));
getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
getIt.registerSingleton<GoogleSignIn>(GoogleSignIn());
getIt.registerLazySingleton<IAuthFacade>(() => FirebaseAuthFacade(
  getIt<FirebaseAuth>(),
  getIt<GoogleSignIn>(),
));

// Register the FirebaseInjectableModule as a singleton in the dependency injection container
  // getIt.registerSingleton<FirebaseInjectableModeule>();

  // Register the GoogleSignIn instance as a singleton in the dependency injection container
  // getIt.registerSingleton<GoogleSignIn>(getIt<FirebaseInjectableModeule>().googleSignIn);

  // Register the FirebaseAuth instance as a singleton in the dependency injection container
  // getIt.registerSingleton<FirebaseAuth>(getIt<FirebaseInjectableModeule>().firebaseAuth);
}

// class  _$FirebaseInjectionModule extends FirebaseInjectableModeule{}