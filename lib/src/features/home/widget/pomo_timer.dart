import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion/motion.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:tempo_zen/services/notifi_services.dart';

class PomoTimer extends StatefulWidget {
  const PomoTimer({super.key});

  @override
  _PomoTimerState createState() => _PomoTimerState();
}

class _PomoTimerState extends State<PomoTimer> {
  final StreamController minutesTimerStreamController =
      StreamController.broadcast();
  final StreamController secondsTimerStreamController =
      StreamController.broadcast();
  final StreamController pomoStreamController = StreamController.broadcast();
  final StreamController breaksStreamController = StreamController.broadcast();

  final NotificationService notificationService = NotificationService();

  int clock = 30;
  int pomo = 0;
  int breaks = 0;
  bool onBreak = false;

  Timer? _timer;

  @override
  void dispose() {
    minutesTimerStreamController.close();
    secondsTimerStreamController.close();
    pomoStreamController.close();
    breaksStreamController.close();
    super.dispose();
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    int totalSeconds = clock * 60;
    _timer = Timer.periodic(oneSecond, (timer) {
      if (totalSeconds > 0) {
        totalSeconds--;
        minutesTimerStreamController.add(totalSeconds ~/ 60);
        secondsTimerStreamController.add(totalSeconds % 60);
      } else {
        if (onBreak) {
          breaks += 1;
          breaksStreamController.add(breaks);
          onBreak = !onBreak;
          notificationService.showNotification(
            title: "Break's over!",
            body: "Back to work",
          );
          clock = 30;
          minutesTimerStreamController.add(clock);
        } else {
          pomo += 1;
          pomoStreamController.add(pomo);
          onBreak = !onBreak;
          notificationService.showNotification(
            title: "Time's up!",
            body: "Take a break",
          );
          clock = 5;
          minutesTimerStreamController.add(clock);
        }
        _stopTimer();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    minutesTimerStreamController.add(null);
    secondsTimerStreamController.add(null);
  }

  @override
  Widget build(BuildContext context) {
    if (Motion.instance.isPermissionRequired &&
        !Motion.instance.isPermissionGranted) {
      showPermissionRequestDialog(
        context,
        onDone: () {
          setState(() {});
        },
      );
    }
    return Motion.elevated(
      elevation: 10,
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      shadow: false,
      glare: false,
      child: Card(
        margin: const EdgeInsets.all(20),
        color: Theme.of(context).colorScheme.primary,
        child: StreamBuilder4(
          streams: StreamTuple4(
            minutesTimerStreamController.stream,
            secondsTimerStreamController.stream,
            pomoStreamController.stream,
            breaksStreamController.stream,
          ),
          builder: (context, snapshots) {
            if (snapshots.snapshot1.data == null ||
                snapshots.snapshot2.data == null) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          GlowText(
                            "Pomos",
                            blurRadius: 10,
                            glowColor: !onBreak
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.primary,
                            style: GoogleFonts.ralewayDots(
                              fontSize: 15,
                              color: !onBreak
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          GlowText(
                            snapshots.snapshot3.data == null
                                ? "0"
                                : snapshots.snapshot3.data.toString(),
                            blurRadius: 9,
                            glowColor: Theme.of(context).colorScheme.secondary,
                            style: GoogleFonts.ralewayDots(
                              fontSize: 50,
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GlowText(
                            "Breaks",
                            blurRadius: 10,
                            glowColor: onBreak
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.background,
                            style: GoogleFonts.ralewayDots(
                              fontSize: 15,
                              color: onBreak
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.background,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          GlowText(
                            snapshots.snapshot4.data == null
                                ? "0"
                                : snapshots.snapshot4.data.toString(),
                            blurRadius: 9,
                            glowColor: Theme.of(context).colorScheme.secondary,
                            style: GoogleFonts.ralewayDots(
                              fontSize: 50,
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.secondary,
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  clock++;
                                  minutesTimerStreamController.add(clock);
                                },
                                icon: GlowIcon(
                                  blurRadius: 9,
                                  glowColor:
                                      Theme.of(context).colorScheme.secondary,
                                  Icons.arrow_drop_up_rounded,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 40,
                                ),
                              ),
                              GlowText(
                                clock.toString(),
                                blurRadius: 9,
                                glowColor:
                                    Theme.of(context).colorScheme.secondary,
                                style: GoogleFonts.ralewayDots(
                                  fontSize: 70,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (clock > 1) {
                                    clock--;
                                  }
                                  minutesTimerStreamController.add(clock);
                                },
                                icon: GlowIcon(
                                  blurRadius: 9,
                                  glowColor:
                                      Theme.of(context).colorScheme.secondary,
                                  Icons.arrow_drop_down_rounded,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                          GlowText(
                            " : 00",
                            blurRadius: 9,
                            glowColor: Theme.of(context).colorScheme.secondary,
                            style: GoogleFonts.ralewayDots(
                              fontSize: 70,
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: _startTimer,
                        icon: GlowIcon(
                          Icons.play_arrow_rounded,
                          blurRadius: 9,
                          glowColor: Theme.of(context).colorScheme.secondary,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GlowText(
                  blurRadius: 9,
                  glowColor: Theme.of(context).colorScheme.secondary,
                  "${snapshots.snapshot1.data.toString()} : ${snapshots.snapshot2.data.toString()}",
                  style: GoogleFonts.ralewayDots(
                    fontSize: 70,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                IconButton(
                  onPressed: _stopTimer,
                  icon: GlowIcon(
                    blurRadius: 9,
                    glowColor: Theme.of(context).colorScheme.secondary,
                    Icons.stop_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 40,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

Future<void> showPermissionRequestDialog(BuildContext context,
    {required Function() onDone}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Permission required'),
      content: const Text(
          'On iOS 13+, you need to grant access to the gyroscope. A permission will be requested to proceed.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Motion.instance.requestPermission();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
