import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/ui/screens/main/componants/navbar_selected_item_hover.dart';

class PlantNavigationBar extends StatefulHookConsumerWidget {
  final int initialIndex;
  final List<IconData> icons;
  final Color color;
  final Color? buttonBackgroundColor;
  final ValueChanged<int>? onTap;
  final Curve animationCurve;
  final Duration animationDuration;
  final double height;
  PlantNavigationBar({
    Key? key,
    required this.icons,
    this.initialIndex = 1,
    this.color = Colors.white,
    this.buttonBackgroundColor,
    this.onTap,
    this.animationCurve = Curves.linear,
    this.animationDuration = const Duration(milliseconds: 250),
    this.height = 75.0,
  })  : assert(icons.isNotEmpty),
        assert(0 <= height && height <= 75.0),
        super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      PlantNavigationBarState();
}

class PlantNavigationBarState extends ConsumerState<PlantNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final isIndexChanging = useState(false);
    final itemIndex = useState(widget.initialIndex);

    final itemWidth = MediaQuery.of(context).size.width / widget.icons.length;

    const double wantedWidth = 300;
    final double currentWidth = itemWidth * widget.icons.length;
    final double newWidth = currentWidth + (wantedWidth - itemWidth);
    final double difference = (newWidth - currentWidth) / 2;
    final double newPosition = itemWidth * itemIndex.value - difference;

    return Container(
      height: widget.height,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          AnimatedPositioned(
            left: newPosition,
            top: !isIndexChanging.value ? -16 : widget.height - 10,
            bottom: -widget.height,
            width: wantedWidth,
            duration: widget.animationDuration,
            curve: widget.animationCurve,
            child: AnimatedContainer(
              duration: widget.animationDuration,
              width: itemWidth,
              curve: widget.animationCurve,
              child: CustomPaint(
                painter: FocusedNavBarItemCustomPainter(
                  color: Theme.of(context).indicatorColor,
                ),
              ),
            ),
          ),
          Row(
            children: widget.icons.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isActive = index == itemIndex.value;
              return GestureDetector(
                onTap: () async {
                  if (!isActive) {
                    if (widget.onTap != null) {
                      widget.onTap!(index);
                    }
                    isIndexChanging.value = true;
                    await Future.delayed(widget.animationDuration -
                        const Duration(milliseconds: 100));
                    itemIndex.value = index;
                    isIndexChanging.value = true;
                    await Future.delayed(widget.animationDuration);
                    isIndexChanging.value = false;
                  }
                },
                child: SizedBox(
                  width: itemWidth,
                  height: 100,
                  child: Center(
                    child: Icon(
                      item,
                      color: isActive
                          ? Theme.of(context).scaffoldBackgroundColor
                          : null,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
