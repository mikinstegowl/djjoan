import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  double _currentPosition = 0.0;
  double _totalDuration = 0.0;

  @override
  void initState() {
    super.initState();

    // Listen to player events to update seek bar
    audioPlayer.currentPosition.listen((event) {
      setState(() {
        _currentPosition = event.inMilliseconds.toDouble();
      });
    });

    audioPlayer.current.listen((event) {
      setState(() {
        _totalDuration = event?.audio.duration.inMilliseconds.toDouble() ?? 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets Audio Player with Seek Bar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0.0),
              ),
              child: Slider(
                allowedInteraction: SliderInteraction.values[0],
                value: _currentPosition,
                min: 0.0,
                max: _totalDuration,
                onChanged: (value) {
                  setState(() {
                    _currentPosition = value;
                  });
                },
                onChangeEnd: (value) {
                  audioPlayer.seek(Duration(milliseconds: value.toInt()));
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(Duration(minutes: _currentPosition.toInt() * 10 ~/ 10000)
                    .toString()),
                Text(Duration(minutes: (_totalDuration * 10 / 10000).toInt())
                    .toString())
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Play audio from assets
                audioPlayer.open(
                  Audio.network(
                      "https://alajaza.s3.amazonaws.com/uploads/01IntroEnVivo3MeN2Edit_1713613126.mp3"),
                  autoStart: true,
                  showNotification: true,
                );
              },
              child: const Text('Play Audio'),
            ),
            ElevatedButton(
              onPressed: () {
                // Pause audio
                audioPlayer.pause();
              },
              child: const Text('Pause Audio'),
            ),
            ElevatedButton(
              onPressed: () {
                // Stop audio
                audioPlayer.stop();
              },
              child: const Text('Stop Audio'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AudioPlayerScreen(),
  ));
}
