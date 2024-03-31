import 'package:flutter/material.dart';
import 'package:tempo_zen/src/features/home/widget/pomo_timer.dart';
import 'package:tempo_zen/src/features/home/widget/video_player.dart';
import 'package:tempo_zen/src/settings/theme/settings_controller.dart';
import 'package:tempo_zen/src/settings/theme/settings_toggle_view.dart';

class MobileHomeScreen extends StatelessWidget {
  final SettingsController controller;
  MobileHomeScreen({super.key, required this.controller});

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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: ToggleTheme(controller: controller),
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(.3),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(flex: 3, child: PomoTimer()),
                Spacer(),
                const VideoPlayer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// const List<Color> retroPlasmaColors = [
//   Colors.blue,
//   Colors.lightBlue,
//   Colors.purple,
//   Colors.pink,
//   Colors.orange,
//   Colors.yellow,
// ];

// class RetroPlasmaEffect extends StatefulWidget {
//   final double cellSize;

//   const RetroPlasmaEffect({Key? key, required this.cellSize}) : super(key: key);

//   @override
//   State<RetroPlasmaEffect> createState() => _RetroPlasmaEffectState();
// }

// class _RetroPlasmaEffectState extends State<RetroPlasmaEffect>
//     with SingleTickerProviderStateMixin {
//   AnimationController? _animationController;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(vsync: this)
//       ..repeat(
//           period: const Duration(milliseconds: 500)); // Adjust animation speed
//   }

//   @override
//   void dispose() {
//     _animationController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animationController!,
//       builder: (context, child) {
//         final noiseData = List<double>.generate(
//             (widget.cellSize * widget.cellSize).toInt(),
//             (_) => Random().nextDouble());

//         return CustomPaint(
//           painter: RetroPlasmaPainter(
//               cellSize: widget.cellSize,
//               colors: retroPlasmaColors,
//               noiseData: noiseData),
//         );
//       },
//     );
//   }
// }

// class RetroPlasmaPainter extends CustomPainter {
//   final double cellSize;
//   final List<Color> colors;
//   final List<double> noiseData; // For animation (optional)

//   RetroPlasmaPainter(
//       {required this.cellSize, required this.colors, required this.noiseData});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = Colors.black; // Background color

//     // Fill the background
//     canvas.drawRect(Offset.zero & size, paint);

//     for (int y = 0; y < size.height ~/ cellSize; y++) {
//       for (int x = 0; x < size.width ~/ cellSize; x++) {
//         final int index = y * (size.width ~/ cellSize) + x;
//         final double noise = noiseData[index]; // Use noiseData for animation

//         // Calculate the color based on noise value and color palette
//         final int colorIndex = (noise * (colors.length - 1)).floor();
//         final Color cellColor = colors[colorIndex];

//         // Draw the rectangle for each cell
//         canvas.drawRect(
//             Rect.fromLTWH(x * cellSize, y * cellSize, cellSize, cellSize),
//             Paint()..color = cellColor);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(RetroPlasmaPainter oldDelegate) => true;
// }
