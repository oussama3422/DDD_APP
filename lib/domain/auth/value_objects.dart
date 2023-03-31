import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/domain/auth/core/errors.dart';
import 'core/failures.dart';
import 'core/value_objects.dart';
import 'core/value_validators.dart';

class EmailAdress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>,String> value;
  // final Either<Left,Right> failure;
  // final Exception failure;


 bool isValid()=> value.isRight();
  
 // here we do contructor as private
  const EmailAdress._(
    this.value,
    // this.failure,
  );
  
  //factory Method
  factory EmailAdress(String input){
    // assert(input!=null);
    return EmailAdress._(validateEmailAdress(input));
  }

 //:::::ASSET THE VALUE TO BE SOULD NOT EQUAL NULL::::
 // +++++ const EmailAdress(this.value):assert(value!=null); +++++

}



///
class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>,String> value;
  // final Either<Left,Right> failure;
  // final Exception failure;
 bool isValid()=> value.isRight();
 // here we do contructor as private
  const Password._(
    this.value,
    // this.failure,
  );

  //
  
  //factory Method
  factory Password(String input){
    // assert(input!=null);
    return Password._(validatePassword(input));
  }

 //:::::ASSET THE VALUE TO BE SOULD NOT EQUAL NULL::::
 // +++++ const Password(this.value):assert(value!=null); +++++

}







