import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import 'errors.dart';
import 'failures.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;
  
  T getOrCrach(){
    // id = identity - same as writing (right) => right
    return value.fold((f) => throw UnexpectedValueError(f),id);
  }
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ValueObject && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'EmailAdress(value: $value)';
}
