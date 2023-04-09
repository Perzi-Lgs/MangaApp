import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../config/themes/theme_config.dart';
import 'gradient_circular_indicator.dart';

class CustomExtendIndicator extends StatefulWidget {
  final Widget child;
  final Function onRefresh;

  const CustomExtendIndicator({
    Key? key,
    required this.child, required this.onRefresh,
  }) : super(key: key);

  @override
  _CustomExtendIndicatorState createState() => _CustomExtendIndicatorState();
}

class _CustomExtendIndicatorState extends State<CustomExtendIndicator>
    with SingleTickerProviderStateMixin {
  static const _indicatorSize = 70.0;

  ScrollDirection prevScrollDirection = ScrollDirection.idle;

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      offsetToArmed: _indicatorSize,
      onRefresh: () => widget.onRefresh(),
      child: widget.child,
      completeStateDuration: const Duration(milliseconds: 500),
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        return Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget? _) {
                prevScrollDirection = controller.scrollingDirection;
          
                final containerHeight = controller.value * _indicatorSize;
          
                return Container(
                  alignment: Alignment.center,
                  height: containerHeight,
                  child: OverflowBox(
                    maxHeight: 40,
                    minHeight: 40,
                    maxWidth: 40,
                    minWidth: 40,
                    alignment: Alignment.center,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 15,
                        width: 15,
                        child: GradientCircularIndicator(
                          strokeWidth: 2,
                          size: 15,
                          primaryColor: CustomColors.lightGrey,
                          secondaryColor: Colors.transparent,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: CustomColors.darkGrey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0.0, controller.value * _indicatorSize),
                  child: child,
                );
              },
              animation: controller,
            ),
          ],
        );
      },
    );
  }
}
