enum Modo {
  development,
  homologation,
  production,
}

class Config {
  static Modo? buildMode;

  static String get apiURL {
    switch (buildMode) {
      case Modo.development:
        return '192.168.10.69:8080';
      case Modo.homologation:
        return '<SUA API RELEASE>';
      case Modo.production:
        return '<SUA API DEV>';
      default:
        return '<SUA API DEV>';
    }
  }
}
