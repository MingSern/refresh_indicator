import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:refresh_indicator/widgets/toutiao_progress_indicator.dart';

import 'popup_chip.dart';

class ToutiaoCustomHeader extends StatefulWidget {
  const ToutiaoCustomHeader({super.key});

  @override
  State<ToutiaoCustomHeader> createState() => _ToutiaoCustomHeaderState();
}

class _ToutiaoCustomHeaderState extends State<ToutiaoCustomHeader> {
  final double _triggerHeight = 64;
  double _offset = 0;
  bool _hasVibrated = false;

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      height: _triggerHeight,
      onOffsetChange: (value) {
        _offset = value / _triggerHeight;
        setState(() {});
      },
      completeDuration: const Duration(seconds: 1),
      builder: (context, status) {
        switch (status) {
          case RefreshStatus.canRefresh:
            if (_hasVibrated) break;
            HapticFeedback.lightImpact();
            _hasVibrated = true;
            break;

          case RefreshStatus.refreshing:
            _hasVibrated = false;
            break;

          default:
            break;
        }

        return SizedBox(
          height: _triggerHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              status == RefreshStatus.completed
                  ? const PopupChip("Finished loading")
                  : ToutiaoProgressIndicator(value: _offset, status: status),
            ],
          ),
        );
      },
    );
  }
}
