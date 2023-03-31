import 'dart:convert';

import 'package:flutter_application_1/domain/auth/core/failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;
  UnexpectedValueError(
    this.valueFailure,
  );

  @override
  String toString() {
      const explanation='Encountered a ValueFailure at an unrecoverable point. Terminating.';
      return Error.safeToString('$explanation Failure was: $valueFailure');
  }

}
