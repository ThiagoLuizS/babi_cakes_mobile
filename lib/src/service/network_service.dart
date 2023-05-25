import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {

  static isNetworkConnection() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();

      if(connectivityResult == ConnectivityResult.none) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}