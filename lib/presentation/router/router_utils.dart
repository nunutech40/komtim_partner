enum PAGES {
  splash,
  login,
  forgotPasswrod,
  main,
  error,
  profileInfo,
}

extension AppPageExtension on PAGES {
  String get screenPath {
    switch (this) {
      case PAGES.main:
        return "/";
      case PAGES.splash:
        return "/splash";
      case PAGES.login:
        return "/login";
      case PAGES.forgotPasswrod:
        return "/forgot_password";
      case PAGES.error:
        return "/error";
      case PAGES.profileInfo:
        return "/profile_info";
      default:
        return "/";
    }
  }

  String get screenName {
    switch (this) {
      case PAGES.main:
        return "HOME";
      case PAGES.login:
        return "LOGIN";
      case PAGES.forgotPasswrod:
        return "FORGOTPASSWORD";
      case PAGES.splash:
        return "SPLASH";
      case PAGES.error:
        return "ERROR";
      case PAGES.profileInfo:
        return "PROFILEINFO";
      default:
        return "HOME";
    }
  }

  String get screenTitle {
    switch (this) {
      case PAGES.main:
        return "Home";
      case PAGES.login:
        return "Login";
      case PAGES.forgotPasswrod:
        return "Forgot Password";
      case PAGES.splash:
        return "Splash";
      case PAGES.profileInfo:
        return "Profile Info";
      case PAGES.error:
        return "Error";
      default:
        return "Home";
    }
  }
}
