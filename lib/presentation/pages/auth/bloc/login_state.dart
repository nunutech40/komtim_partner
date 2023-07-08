part of 'login_bloc.dart';

enum LoginStatus {
  success,
  failure,
  loading,
}

class LoginState extends Equatable {
  const LoginState({
    this.message = '',
    this.status = LoginStatus.loading,
    this.username = '',
    this.password = '',
  });

  final String message;
  final LoginStatus status;
  final String username;
  final String password;

  LoginState copyWith({
    String? username,
    String? password,
    LoginStatus? status,
    String? message,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        message,
        status,
        username,
        password,
      ];
}
