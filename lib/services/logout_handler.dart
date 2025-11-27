typedef LogoutCallback = void Function();

class LogoutHandler {
  static LogoutCallback? onLogout;

  static void triggerLogout() {
    if (onLogout != null) {
      onLogout!(); // run the callback
    }
  }
}
