import 'package:babi_cakes_mobile/src/models/dto/error_view.dart';

class ApiResponse<T> {
  late bool ok;
  late String msg;
  late T result;
  late List<String> erros;

  ApiResponse.ok(this.result) {
    ok = true;
  }
  ApiResponse.error(this.msg) {
    ok = false;
  }
  ApiResponse.errors(this.erros) {
    ok = false;
  }
}
