part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool isVisible;
  const AuthState({
    this.isVisible = true,
  });

  @override
  List<Object> get props => [isVisible];

  AuthState copyWith({bool? isVisible}) {
    return AuthState(
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSignUpSuccess extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}


class ForgotPasswordLoading extends AuthState {}
class ForgotPasswordSuccess extends AuthState {}
class ForgotPasswordFailure extends AuthState {
  final String error;

  const ForgotPasswordFailure(this.error);

  @override
  List<Object> get props => [error];
}
