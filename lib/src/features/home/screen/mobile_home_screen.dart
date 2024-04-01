import 'package:flutter/material.dart';
import 'package:tempo_zen/src/features/home/widget/pomo_timer.dart';
import 'package:tempo_zen/src/features/home/widget/tv_lines.dart';
import 'package:tempo_zen/src/features/home/widget/video_player.dart';

class MobileHomeScreen extends StatelessWidget {
  const MobileHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          "https://www.icegif.com/wp-content/uploads/2021/09/icegif-5.gif",
          fit: BoxFit.cover,
        ),
        const TVLines(
          lineThickness: 1.5,
          lineSpacing: 8.0,
          lineColor: Colors.black12,
        ),
        Scaffold(
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(.3),
          body: const SafeArea(
            child: Column(
              children: [
                Spacer(),
                Expanded(flex: 2, child: PomoTimer()),
                VideoPlayer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
