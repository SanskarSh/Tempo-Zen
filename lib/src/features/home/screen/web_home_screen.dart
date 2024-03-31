import 'package:flutter/material.dart';
import 'package:tempo_zen/src/features/home/widget/pomo_timer.dart';

class WebHomeScreen extends StatelessWidget {
  const WebHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          "https://www.icegif.com/wp-content/uploads/2021/09/icegif-5.gif",
          fit: BoxFit.cover,
        ),
        Scaffold(
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(.5),
            body: PomoTimer()),
      ],
    );
  }
}
