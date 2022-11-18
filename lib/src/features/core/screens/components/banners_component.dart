import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BannersComponent extends StatefulWidget {
  final List<BannerItemComponent> list;

  const BannersComponent({Key? key, required this.list}) : super(key: key);

  @override
  _BannersComponentState createState() => _BannersComponentState();
}

class _BannersComponentState extends State<BannersComponent> {
  final PageController _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
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
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
      child: Column(
        children: [
          SizedBox(
            height: 140,
            child: PageView(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: widget.list,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
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
  final String? imagePath;

  const BannerItemComponent({Key? key, this.imagePath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imagePath!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
