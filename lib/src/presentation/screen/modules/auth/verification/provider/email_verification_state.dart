
import 'package:flutter/material.dart';

enum VerificationState {
  initial,
  success,
  error,
}

class EmailVerificationState {
  EmailVerificationState({
    required this.status,
    this.errorMessage,

  });

  EmailVerificationState.initial() : this(status: VerificationState.initial);

 final VerificationState status;
  final String? errorMessage;


  EmailVerificationState copyWith({
    VerificationState? status,
     ValueGetter<String?>? errorMessage,
  
  }) =>
      EmailVerificationState(
        status: status ?? this.status,
        errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      );
}
