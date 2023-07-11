class Endpoints {
  // This is base url
  static const String _BaseURL = 'https://dev.go.komtim.komerce.my.id';

  // These are the endpoints
  static const String login = '$_BaseURL/api/v1/auth/login';
  static const String logout = '$_BaseURL/api/v1/auth/profile/logout';
  static const String getProfile = '$_BaseURL/api/v1/auth/profile';
}
