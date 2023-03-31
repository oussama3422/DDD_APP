import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/auth/sign_in_form/sign_in_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc,SignInState>(
      listener:(context,state){
       state.authFailureOrSucess.fold(
        (){},
        (either)=> either.fold(
          (l) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:l.map(
            cancelledByUser: (_)=>Text('Cancelled'),
            serverError: (_)=>Text('Server error'),
            emailAlreadyInUse: (_)=>Text('Email already in use'),
            invalidEmailAndPasswordCombination: (_)=>Text('invalid email and password combination'),
            )
            )
            ),
          (r) => null,
       )
       );
      },
      builder: (context,state){
        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
               const Text(
                '📝',
                textAlign: TextAlign.center,
                style:TextStyle(fontSize: 130),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration:const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Enail',
                  ),
                  autocorrect:false,
                  onChanged: (newVal){
                    BlocProvider.of<SignInBloc>(context).add(SignInEvent.emailChanged(newVal));
                  },
                  validator: (_) => 
                    BlocProvider.of<SignInBloc>(context).state.emailAdress.value.fold(
                    (failure) => failure.maybeMap(invalidEmail:(val)=>'Invalid Email', shortPassword:(val)=>null ,orElse: ()=>null) ,
                    (sucess) => null
                    ) ,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration:const InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      labelText: 'Password',
                  ),
                  autocorrect:false,
                  obscureText: true,
                  onChanged: (newVal){
                    BlocProvider.of<SignInBloc>(context).add(SignInEvent.passwordChanged(newVal));
                  },
                  validator: (_) => 
                    BlocProvider.of<SignInBloc>(context).state.password.value.fold(
                    (failure) => failure.maybeMap(invalidEmail:(val)=>'Short Password', shortPassword:(val)=>null ,orElse: ()=>null) ,
                    (sucess) => null
                    ) ,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: (){
                             BlocProvider.of<SignInBloc>(context).add(SignInEvent.signInWithEmailAndPasswordPressed());
                        },
                        child: Text('Sign In')
                        ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){
                          BlocProvider.of<SignInBloc>(context).add(SignInEvent.registerWithEmailAndPasswordPressed());
                        },
                        child: Text('Register')
                        ),
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: (){
                    BlocProvider.of<SignInBloc>(context).add(SignInEvent.signInWithGooglePressed());
                  },
                  child: Text('Sign In With Google'),
                  )
            ],
          ) 
          );
      },
      );
  }
}