import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _controller;
  double _volume = 100;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: "AzwgsZUcTfM",
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        loop: true,
        forceHD: false,
      ),
    );
  }

  play() {
    _controller.play();
  }

  reduceVolume(int level) {
    _controller.setVolume(_controller.value.volume - level);
  }

  void pause() {
    _controller.pause();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 200,
      width: size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      if (!_controller.value.isPlaying) {
                        play();
                      } else {
                        pause();
                      }
                    },
                    icon: GlowIcon(
                      blurRadius: 9,
                      glowColor: Theme.of(context).colorScheme.secondary,
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: reduceVolume(100),
                    icon: GlowIcon(
                      blurRadius: 9,
                      glowColor: Theme.of(context).colorScheme.secondary,
                      _controller.value.volume == 0
                          ? Icons.volume_off
                          : Icons.volume_up,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 40,
                    ),
                  ),
                  Row(
                    children: List.generate(
                      6,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: InkWell(
                          onTap: () {
                            reduceVolume(100 - (index * 20));
                          },
                          child: GlowText(
                            "🁢",
                            blurRadius: 9,
                            glowColor: Theme.of(context).colorScheme.secondary,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Expanded(
                  //   child: Slider(
                  //     inactiveColor: Colors.transparent,
                  //     value: _volume,
                  //     min: 0.0,
                  //     max: 100.0,
                  //     divisions: 10,
                  //     label: '${(_volume).round()}',
                  //     onChanged: _isPlayerReady
                  //         ? (value) {
                  //             setState(() {
                  //               _volume = value;
                  //             });
                  //             _controller.setVolume(_volume.round());
                  //           }
                  //         : null,
                  //   ),
                  // ),
                ],
              ),
            ),
            IgnorePointer(
              ignoring: true,
              child: YoutubePlayer(
                controller: _controller,
                onReady: () {
                  _isPlayerReady = true;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// class VideoPlayer extends StatefulWidget {
//   const VideoPlayer({super.key});

//   @override
//   State<VideoPlayer> createState() => _VideoPlayerState();
// }

// class _VideoPlayerState extends State<VideoPlayer> {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   final yt = YoutubeExplode();
//   final String _videoId = 'https://youtube.com/watch?v=AzwgsZUcTfM';

//   Future<void> _playAudio() async {
//     final manifest = await yt.videos.streamsClient.getManifest(_videoId);
//     // final manifest = await yt.videos.get(_videoId);
//     final audioStreamInfo = manifest.audioOnly.last;

//     String url = audioStreamInfo.url.toString();

//     await _audioPlayer.play(UrlSource(url));

//     print(audioStreamInfo);
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     yt.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: _playAudio,
//         child: Text('Play Audio'),
//       ),
//     );
//   }
// }
