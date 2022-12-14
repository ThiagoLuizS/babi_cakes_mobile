import 'dart:convert';

import 'package:babi_cakes_mobile/src/constants/colors.dart';
import 'package:babi_cakes_mobile/src/features/core/models/banner/banner_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/product_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/product_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/dashboard.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/product/product_list_category.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannersComponent extends StatefulWidget {
  final List<BannerItemComponent> list;

  const BannersComponent({Key? key, required this.list}) : super(key: key);

  @override
  _BannersComponentState createState() => _BannersComponentState();
}

class _BannersComponentState extends State<BannersComponent> {
  final PageController _pageController =
      PageController(viewportFraction: 0.8, initialPage: 1);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onChangePage);
  }

  _onChangePage() {
    setState(() {
      _currentIndex = _pageController.page!.round();
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_onChangePage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Column(
        children: [
          SizedBox(
            height: height / 3,
            child: PageView(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              pageSnapping: true,
              scrollDirection: Axis.horizontal,
              children: widget.list,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.list
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.list.indexOf(e) == _currentIndex
                                ? AppColors.grey7
                                : AppColors.grey2,
                          ),
                          height: 6,
                          width: 6,
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

class BannerItemComponent extends StatelessWidget {
  final BannerView view;

  const BannerItemComponent({Key? key, required this.view}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        if(view.category != null) {
          Get.offAll(() => ProductListCategory(categoryView: view.category!));
        } else {
          Get.offAll(() => ProductComponent(productView: view.product!));
        }

      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                      image: MemoryImage(base64Decode(view.file!.photoBase64ToString))),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 19,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x32989191),
                      offset: Offset(0.6, 0.6),
                      blurRadius: 1.5,
                      spreadRadius: 1.5,
                    ),
                  ],
                  color: Colors.white),
              width: width / 1.5,
              height: 112,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      view.title,
                      style: const TextStyle(color: Colors.black, fontSize: 16, overflow: TextOverflow.ellipsis, fontFamily: AutofillHints.countryName),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.orange, size: 18,),
                          const Icon(Icons.star, color: Colors.orange, size: 18,),
                          const Icon(Icons.star, color: Colors.orange, size: 18,),
                          const Icon(Icons.star, color: Colors.orange, size: 18,),
                          const Icon(Icons.star, color: Colors.orange, size: 18,),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 2),
                            child: Text("5.0", style: TextStyle(color: AppColors.grey5, fontSize: 12),),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.fast_forward_outlined, color: Colors.orange,),
                              Text("rápida", style: TextStyle(color: AppColors.grey5, fontSize: 10, overflow: TextOverflow.ellipsis),)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.location_on, color: Colors.orange,),
                              Text("na sua casa", style: TextStyle(color: AppColors.grey5, fontSize: 10, overflow: TextOverflow.ellipsis),)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.lock_clock, color: Colors.orange,),
                              Text("limitado", style: TextStyle(color: AppColors.grey5, fontSize: 10, overflow: TextOverflow.ellipsis),)
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
