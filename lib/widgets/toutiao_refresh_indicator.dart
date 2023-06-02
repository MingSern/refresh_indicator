import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:refresh_indicator/widgets/toutiao_custom_header.dart';

class ToutiaoRefreshIndicator extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const ToutiaoRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  State<ToutiaoRefreshIndicator> createState() =>
      _ToutiaoRefreshIndicatorState();
}

class _ToutiaoRefreshIndicatorState extends State<ToutiaoRefreshIndicator> {
  final _refreshController = RefreshController();

  Future<void> _onRefresh() async {
    await widget.onRefresh();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      header: const ToutiaoCustomHeader(),
      child: widget.child,
    );
  }
}
