import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class LiquidRefreshComponent extends StatefulWidget {
  final Widget child;
  final Function onRefresh;
  const LiquidRefreshComponent({Key? key, required this.child, required this.onRefresh}) : super(key: key);

  @override
  State<LiquidRefreshComponent> createState() => _LiquidRefreshComponentState();
}

class _LiquidRefreshComponentState extends State<LiquidRefreshComponent> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: () async => widget.onRefresh(),
        showChildOpacityTransition: false,
        color: AppColors.milkCream,
        child: widget.child
    );
  }
}
