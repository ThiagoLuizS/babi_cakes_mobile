import 'package:babi_cakes_mobile/config.dart';

class PayPalService {

  static String clientId = 'AXijYhbQ8CPtONWe353HiMxchS9vWbtD_-BbL9xDvf7vwpdzoMtp-fOZ4H_FoLMkuGqweqwgW_681h7Q';
  static String secretKey = 'EDmH-2XumOpaZxPNkpCTFrL4vj1Mwv5YRRtDNzJvji_FE-a3Nxh-Aip8vbRWnohUWmmqWrWpJuXv2LHm';
  static String returnUrl = 'nativexo://paypalpay';

  static bool getSandBox() {
    Modo? buildMode = Config.buildMode;
    switch (buildMode) {
      case Modo.development:
        return true;
      case Modo.homologation:
        return true;
      case Modo.production:
        return false;
      default:
        return true;
    }
  }
  
}