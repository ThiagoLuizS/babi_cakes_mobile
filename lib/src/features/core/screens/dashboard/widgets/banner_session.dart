import 'package:babi_cakes_mobile/src/features/core/models/banner/banner_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/banners_component.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_images.dart';
import 'package:flutter/material.dart';

class BannerSession extends StatefulWidget {
  final List<BannerView> bannerList;

  const BannerSession({Key? key, required this.bannerList}) : super(key: key);

  @override
  State<BannerSession> createState() => _BannerSessionState();
}

class _BannerSessionState extends State<BannerSession> {


  @override
  Widget build(BuildContext context) {
    return BannersComponent(
      list: widget.bannerList.map((e) => BannerItemComponent(view: e,)).toList()
    );
  }
}