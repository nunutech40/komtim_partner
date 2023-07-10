part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.message = '',
    this.status = RequestStatus.empty,
    this.username = '',
    this.password = '',
  });

  final String message;
  final RequestStatus status;
  final String username;
  final String password;

  LoginState copyWith({
    String? username,
    String? password,
    RequestStatus? status,
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
