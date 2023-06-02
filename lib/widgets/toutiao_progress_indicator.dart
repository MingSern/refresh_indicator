import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rive/rive.dart';

class ToutiaoProgressIndicator extends StatefulWidget {
  final double value;
  final RefreshStatus? status;

  const ToutiaoProgressIndicator({
    super.key,
    required this.value,
    required this.status,
  });

  @override
  State<ToutiaoProgressIndicator> createState() =>
      ToutiaoProgressIndicatorState();
}

class ToutiaoProgressIndicatorState extends State<ToutiaoProgressIndicator> {
  final _filePath = 'assets/loading_indicator.riv';
  final _controller = OneShotAnimation('idle');
  SMIInput<double>? _input;

  @override
  void didUpdateWidget(covariant ToutiaoProgressIndicator oldWidget) {
    if (widget.value == oldWidget.value) return;
    double value = widget.value - 0.58;

    if (_input?.value == value) return;
    _input?.change(value * 100 * 1.58);

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      width: 34,
      child: widget.status == RefreshStatus.refreshing
          ? RiveAnimation.asset(
              _filePath,
              controllers: [_controller],
            )
          : RiveAnimation.asset(
              _filePath,
              onInit: (artboard) {
                final controller = StateMachineController.fromArtboard(
                  artboard,
                  "State Machine",
                );

                if (controller == null) return;
                artboard.addController(controller);
                _input = controller.findInput<double>("value");
              },
            ),
    );
  }
}
