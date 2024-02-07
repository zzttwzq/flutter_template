import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:math' as math;
import 'dart:io';
import 'package:app/utils/c_log_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mp_audio_stream/mp_audio_stream.dart';
import 'package:path/path.dart' as path;
import 'package:just_audio/just_audio.dart';
import 'package:record_platform_interface/record_platform_interface.dart';

import 'package:app/UI/custom_appbar.dart';
import 'package:app/views/audio/platform/audio_recorder_io.dart';
import 'package:app/views/audio/record.dart';

class MyCustomSource extends StreamAudioSource {
  final List<int> bytes;
  MyCustomSource(this.bytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= bytes.length;
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(bytes.sublist(start, end)),
      contentType: 'audio/pcm',
    );
  }
}

typedef CInitLib = ffi.Int32 Function();
typedef DartInitLib = int Function();
typedef CSetParam = ffi.Int32 Function(ffi.Int32, ffi.Int32);
typedef DartSetParam = int Function(int, int);
typedef CProcess = ffi.Pointer Function(
  ffi.Pointer l1,
  ffi.Pointer l2,
);
typedef DartProcess = ffi.Pointer Function(
  ffi.Pointer l1,
  ffi.Pointer l2,
);

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
  StreamSubscription<Amplitude>? _amplitudeSub;
  RecordState _recordState = RecordState.stop;
  Amplitude? _amplitude;

  final player = AudioPlayer();

  List<InputDevice> devs = [];
  late InputDevice inputDevice;
  int globalTime = 0;
  bool stop = true;

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

    getDevice();

    super.initState();
  }

  getDevice() async {
    devs = await _audioRecorder.listInputDevices();
    if (devs.isNotEmpty) {
      inputDevice = devs[0];
    }
    setState(() {});
  }

  List<Widget> getDeviceList() {
    List<Widget> list = [];

    for (InputDevice dev in devs) {
      list.add(GestureDetector(
        onTap: () {
          setState(() {
            inputDevice = dev;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: inputDevice.id == dev.id
                ? Border.all(
                    color: Colors.blue,
                  )
                : null,
          ),
          child: Text(dev.label),
        ),
      ));
    }

    return list;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    _amplitudeSub?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  _loadMath() {
    var libraryPath =
        path.join(Directory.current.path, 'hello_library', 'libhello.so');

    if (Platform.isMacOS) {
      libraryPath =
          path.join(Directory.current.path, 'hello_library', 'libhello.dylib');
    }

    if (Platform.isWindows) {
      libraryPath =
          path.join(Directory.current.path, 'assets', 'lib', 'SLTBasic.dll');
    }

    final dylib = ffi.DynamicLibrary.open(libraryPath);

    final initLib =
        dylib.lookupFunction<CInitLib, DartInitLib>('slt_audio_init');
    int res = initLib.call();

    final setParam = dylib
        .lookupFunction<CSetParam, DartSetParam>('set_input_acoustic_params');
    int res2 = setParam.call(2, 48000);

    final process = dylib
        .lookupFunction<CProcess, DartProcess>('set_input_acoustic_params');

    // int res3 = process.call([], []);

    LOG.d(">>>>>>>>>>>> ");
  }

  _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        const encoder = AudioEncoder.wav;

        if (!await _isEncoderSupported(encoder)) {
          return;
        }

        RecordConfig config = RecordConfig(
          encoder: encoder,
          device: inputDevice,
          sampleRate: 48000,
          numChannels: 2,
        );

        // Record to file
        // stop = false;
        // int index = 0;
        // Timer.periodic(const Duration(milliseconds: 800), (timer) {
        //   /// 停止并播放
        //   _stop();

        //   if (stop == true) {
        //     timer.cancel();
        //   } else {
        //     /// 录音
        //     recordFile(_audioRecorder, config, index % 3);
        //     index++;
        //     setState(() {
        //       globalTime++;
        //     });
        //   }
        // });

        final audioStream = getAudioStream();
        audioStream.init();
        const freq = 440;
        const rate = 44100;
        final sineWave = List.generate(rate * 1,
            (i) => math.sin(2 * math.pi * ((i * freq) % rate) / rate));
        audioStream.push(Float32List.fromList(sineWave));
        await Future.delayed(const Duration(seconds: 2));
        audioStream.uninit();

        // Record to stream
        // await recordStream(
        //   _audioRecorder,
        //   config,
        //   (data) async {

        //     print("><>>>>>");
        //     // await player.setAudioSource(MyCustomSource(List.from(data)));
        //     // player.play();
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
    String? path = await _audioRecorder.stop();
    if (path != null) {
      // widget.onStop(path);
      print("path: $path");

      player.setFilePath(path);
      player.play();
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
      // appBar: CustomAppBar.regularAppBar('音频测试'),
      body: SafeArea(
        child: Center(
          child: Container(
              child: Column(
            children: [
              // Image.asset("assets/images/assetsLib.png"),
              // Column(
              //   children: getDeviceList(),
              // ),
              const SizedBox(
                height: 80,
              ),
              GestureDetector(
                child: Text('stop'),
                onTap: () async {
                  stop = true;
                  globalTime = 0;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                child: Text('record'),
                onTap: () async {
                  _start();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text("${stop ? '等待中' : '录制中'} $globalTime"),
            ],
          )),
        ),
      ),
    );
  }
}
