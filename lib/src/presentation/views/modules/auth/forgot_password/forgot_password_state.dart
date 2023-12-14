import 'package:flutter/material.dart';

enum ForgotPasswordStatus {
  initial,
  success,
  error,
}

class ForgotPasswordState {
  final ForgotPasswordStatus status;
  final String? errorMessage;

  ForgotPasswordState.initial() : this(status: ForgotPasswordStatus.initial);

  ForgotPasswordState({
    required this.status,
    this.errorMessage,
  });

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? status,
    ValueGetter<String?>? errorMessage,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }
}
