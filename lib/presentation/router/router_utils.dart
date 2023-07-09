enum PAGES {
  splash,
  login,
  main,
  error,
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
      case PAGES.error:
        return "/error";
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
      case PAGES.splash:
        return "SPLASH";
      case PAGES.error:
        return "ERROR";
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
      case PAGES.splash:
        return "Splash";
      case PAGES.error:
        return "Error";
      default:
        return "Home";
    }
  }
}
