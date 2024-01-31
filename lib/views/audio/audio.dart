import 'dart:async';

import 'package:app/UI/custom_appbar.dart';
import 'package:app/views/audio/platform/audio_recorder_io.dart';
import 'package:app/views/audio/record.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:record_platform_interface/record_platform_interface.dart';

// import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:audioplayers/audioplayers.dart';

class Audio extends StatefulWidget {
  const Audio({super.key});

  @override
  State<StatefulWidget> createState() => _AudioState();
}

class _AudioState extends State<Audio> with AudioRecorderMixin {
  int _recordDuration = 0;
  Timer? _timer;
  late final AudioRecorder _audioRecorder;
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Amplitude? _amplitude;

  Uint8List uint8list = Uint8List.fromList([]);
  bool playing = false;

  final _audioPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);

  @override
  void initState() {
    _audioRecorder = AudioRecorder();

    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      _updateRecordState(recordState);
    });

    _amplitudeSub = _audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) {
      setState(() => _amplitude = amp);
    });

    // BytesSource bytesSource = BytesSource([]);
    // bytesSource.setOnPlayer(player)
    // _audioPlayer.setSource(source);

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    _amplitudeSub?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        const encoder = AudioEncoder.pcm16bits;

        if (!await _isEncoderSupported(encoder)) {
          return;
        }

        List<InputDevice> devs = await _audioRecorder.listInputDevices();
        debugPrint(devs.toString());

        RecordConfig config = RecordConfig(
          encoder: encoder,
          device: devs[1],
        );

        // Record to file
        await recordFile(_audioRecorder, config);

        // Record to stream
        // await recordStream(
        //   _audioRecorder,
        //   config,
        //   (data) {
        //     // print(data);

        //     print(">>> ${data.length}");
        //     // uint8list = data;

        //     // BytesSource source = BytesSource(data);
        //     // _audioPlayer.play(source);
        //   },
        // );

        _recordDuration = 0;

        _startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stop() async {
    final path = await _audioRecorder.stop();

    if (path != null) {
      // widget.onStop(path);
      print("path: $path");

      DeviceFileSource source = DeviceFileSource(path);
      _audioPlayer.play(source);
      // downloadWebData(path);
    }
  }

  Future<void> _pause() => _audioRecorder.pause();

  Future<void> _resume() => _audioRecorder.resume();

  void _updateRecordState(RecordState recordState) {
    setState(() => _recordState = recordState);

    switch (recordState) {
      case RecordState.pause:
        _timer?.cancel();
        break;
      case RecordState.record:
        _startTimer();
        break;
      case RecordState.stop:
        _timer?.cancel();
        _recordDuration = 0;
        break;
    }
  }

  Future<bool> _isEncoderSupported(AudioEncoder encoder) async {
    final isSupported = await _audioRecorder.isEncoderSupported(
      encoder,
    );

    if (!isSupported) {
      debugPrint('${encoder.name} is not supported on this platform.');
      debugPrint('Supported encoders are:');

      for (final e in AudioEncoder.values) {
        if (await _audioRecorder.isEncoderSupported(e)) {
          debugPrint('- ${encoder.name}');
        }
      }
    }

    return isSupported;
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.regularAppBar('title'),
        body: SafeArea(
          child: Container(
              child: Column(
            children: [
              GestureDetector(
                child: Text('play'),
                onTap: () async {
                  _stop();
                },
              ),
              GestureDetector(
                child: Text('record'),
                onTap: () async {
                  _start();
                },
              ),
              Text("> $_recordDuration"),
            ],
          )),
        ));
  }
}
