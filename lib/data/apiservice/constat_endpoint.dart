class Endpoints {
  // This is base url
  static const String _BaseURL = 'https://dev.go.komtim.komerce.my.id';

  // These are the endpoints

  // Auth Endpoints
  static const String login = '$_BaseURL/api/v1/auth/login';
  static const String logout = '$_BaseURL/api/v1/auth/logout';
  static const String forgotPassword = '$_BaseURL/api/v1/auth/forget_password';

  // Profile Endpoints
  static const String getProfile = '$_BaseURL/api/v1/auth/profile';

  
}
