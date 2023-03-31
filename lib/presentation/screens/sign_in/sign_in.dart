import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/auth/sign_in_form/sign_in_bloc.dart';
import 'package:flutter_application_1/presentation/screens/sign_in/widget/sign_in_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../injection.dart';
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text('Sign In')
      ),
      body:BlocProvider(
        create:(context)=>getIt<SignInBloc>(),
        child: const SignInForm()
        ),
    );
  }
}