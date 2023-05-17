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
        return '192.168.10.69:8080';
      case Modo.production:
        return 'http://44.212.255.3:8080';
      default:
        return 'http://44.212.255.3:8080';
    }
  }
}
