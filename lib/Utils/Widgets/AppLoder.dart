import 'package:flutter/material.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';

class AppLoder extends StatefulWidget {
  const AppLoder({super.key});

  @override
  State<AppLoder> createState() => _AppLoderState();
}

class _AppLoderState extends State<AppLoder> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // Adjust duration as needed
    )..repeat();

    _colorAnimation = _controller.drive(
      ColorTween(
        begin: AppColors.appButton, // Initial color
        end: AppColors.appButton.withOpacity(0.5), // Final color
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: double.maxFinite,
        width: double.maxFinite,
        color: Colors.black.withOpacity(0.6),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          CircularProgressIndicator.adaptive(
            valueColor: _colorAnimation,
          )
        ]));
  }
}
