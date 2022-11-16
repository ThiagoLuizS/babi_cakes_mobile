import 'package:babi_cakes_mobile/src/features/core/models/dashboard/category.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_images.dart';

class ContentController {
  List<Category> getCategorys() {
    return [
      Category(name: 'Açai', picture: AppImages.acai),
      Category(name: 'Brasileira', picture: AppImages.brasileira),
      Category(name: 'Café', picture: AppImages.cafe),
      Category(name: 'Doces', picture: AppImages.doces),
      Category(name: 'Japonêsa', picture: AppImages.japones),
      Category(name: 'Lanches', picture: AppImages.lanches),
      Category(name: 'Marmita', picture: AppImages.marmita),
      Category(name: 'Mercado', picture: AppImages.mercado),
      Category(name: 'Padaria', picture: AppImages.padaria),
      Category(name: 'Pizza', picture: AppImages.pizza),
      Category(name: 'Promoções', picture: AppImages.promocoes),
      Category(name: 'Saudável', picture: AppImages.saudavel),
      Category(name: 'Vegetariano', picture: AppImages.vegetariano),
      Category(name: 'Vale Refeição', picture: AppImages.vr),
    ];
  }
}
