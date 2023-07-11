part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.message = '',
      this.status = RequestStatus.empty,
      this.username = '',
      this.password = '',
      this.passwordErrorMessage = '',
      this.usernameErrorMessage = ''});

  final String message;
  final RequestStatus status;
  final String username;
  final String password;
  final String usernameErrorMessage;
  final String passwordErrorMessage;

  LoginState copyWith({
    String? username,
    String? password,
    RequestStatus? status,
    String? message,
    String? usernameErrorMessage, // Add this
    String? passwordErrorMessage, // Add this
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message ?? this.message,
      usernameErrorMessage:
          usernameErrorMessage ?? this.usernameErrorMessage, // And this
      passwordErrorMessage:
          passwordErrorMessage ?? this.passwordErrorMessage, // And this
    );
  }

  @override
  List<Object?> get props => [
        message,
        status,
        username,
        password,
        usernameErrorMessage,
        passwordErrorMessage,
      ];
}
