import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/event/event_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/content_category.dart';
import 'package:babi_cakes_mobile/src/features/core/models/event/event_view.dart';
import 'package:babi_cakes_mobile/src/service/simple_bloc.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';

class EventBloc extends SimpleBloc<bool> {
  Future<ApiResponse<List<EventView>>> getByUserNotVisualized() async {
    add(true);
    ApiResponse<List<EventView>> response = await EventController.getByUserNotVisualized();
    add(false);
    return response;
  }

  Future<ApiResponse<bool>> updateEventVizualized(int eventId) async {
    add(true);
    ApiResponse<bool> response = await EventController.updateEventVizualized(eventId);
    add(false);
    return response;
  }

  Future<ApiResponse<int>> countByDeviceUserAndVisualizedIsFalse() async {
    add(true);
    ApiResponse<int> response = await EventController.countByDeviceUserAndVisualizedIsFalse();
    add(false);
    return response;
  }
}