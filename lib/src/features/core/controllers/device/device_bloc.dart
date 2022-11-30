import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/device/device_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/content_category.dart';
import 'package:babi_cakes_mobile/src/features/core/models/device/device_form.dart';
import 'package:babi_cakes_mobile/src/service/simple_bloc.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';

class DeviceBloc extends SimpleBloc<bool> {
  Future<ApiResponse<Object>> saveDevice(DeviceForm deviceForm) async {
    add(true);
    ApiResponse<Object> response = await DeviceController.saveDevice(deviceForm);
    add(false);
    return response;
  }
}