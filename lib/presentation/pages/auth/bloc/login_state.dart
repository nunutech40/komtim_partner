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
    this.loginFrom = 'mobile', // default value for applicationType
    this.fcmToken =
        'fMFJVmT_vCk:APA91bEwLh3_5dGKDFJI9M4ISZrqD9sOuN_mtYKxj85ZyaLaxo1sBIi9Iq8X5ZUieX5GyGDfkl_woikKVfJCp5j-U7MxNWDE5GlNg8E3IpnsP7GQARlsbcMsLmiM9eMD5xXYTSGXUUKS', // default value for fcmToken
  });

  final String message;
  final LoginStatus status;
  final String username;
  final String password;
  final String loginFrom;
  final String fcmToken;

  LoginState copyWith({
    String? username,
    String? password,
    LoginStatus? status,
    String? message,
    String? loginFrom,
    String? fcmToken,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message ?? this.message,
      loginFrom: loginFrom ?? this.loginFrom,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  @override
  List<Object?> get props => [
        message,
        status,
        username,
        password,
        loginFrom,
        fcmToken,
      ];
}
