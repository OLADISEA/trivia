part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUpRequested({required this.name, required this.email, required this.password});

  @override
  List<Object> get props => [name, email, password];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LogoutRequested extends AuthEvent {}