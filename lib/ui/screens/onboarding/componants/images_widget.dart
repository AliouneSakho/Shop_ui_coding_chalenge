import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ImagesWidget extends HookWidget {
  final String imagePath;
  final String coverPath;
  const ImagesWidget({
    Key? key,
    required this.imagePath,
    required this.coverPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const coversAnimationDuration = Duration(milliseconds: 1200);
    final animationController = useAnimationController(
      duration: const Duration(seconds: 1),
    );
    final isAnamtionShouldStart = useState(false);
    final fadeAnimation = Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(animationController);

    useEffect(
      () {
        animationController.forward();
        animationController.addListener(() {
          if (animationController.isAnimating) {
            isAnamtionShouldStart.value = true;
          }
        });

        return null;
      },
      [animationController],
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        FadeTransition(
          opacity: fadeAnimation,
          child: Image.asset(
            imagePath,
          ),
        ),
        AnimatedPositioned(
          top: -20,
          left: isAnamtionShouldStart.value ? 0 : -15,
          duration: coversAnimationDuration,
          child: Image.asset(
            coverPath,
            width: 140,
          ),
        ),
        AnimatedPositioned(
          bottom: -20,
          right: isAnamtionShouldStart.value ? 0 : -15,
          duration: coversAnimationDuration,
          child: RotatedBox(
            quarterTurns: -2,
            child: Image.asset(
              coverPath,
              width: 130,
            ),
          ),
        ),
      ],
    );
  }
}
