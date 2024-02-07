import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:math' as math;
import 'dart:math';
import 'package:ffi/ffi.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:app/utils/c_log_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mp_audio_stream/mp_audio_stream.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record_platform_interface/record_platform_interface.dart';
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

typedef CProcess = ffi.Void Function(
  ffi.Pointer<Float>,
  ffi.Pointer<Float>,
  ffi.Pointer<Float>,
);
typedef DartProcess = void Function(
  ffi.Pointer<Float>,
  ffi.Pointer<Float>,
  ffi.Pointer<Float>,
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

  final audioStream = getAudioStream();

  final player = AudioPlayer();
  List<InputDevice> devs = [];
  late InputDevice inputDevice;
  int globalTime = 0;
  bool stop = true;
  int rate = 44100;
  int channel = 1;

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

    audioStream.init(
      sampleRate: rate,
      channels: channel,
    );

    AudioStreamStat sta = audioStream.stat();

    getDevice();

    _initModel();

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

  _initModel() {
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
    int res2 = setParam.call(channel, rate);

    LOG.d(">>>>>>>>>>>> $res $res2");
  }

  _loadMath(List<double> li) {
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
    final process =
        dylib.lookupFunction<CProcess, DartProcess>('slt_audio_mic_process');

    int length = 48 * 16 * 2;

    li = [];
    for (int i = 0; i < length; i++) {
      double d = Random().nextDouble();
      li.add(d);
    }
    // ffi.Pointer<ffi.Float> l2 = ffi.
    final pointer = calloc<Float>(length);
    pointer.asTypedList(li.length).setAll(0, li);

    final pointer2 = calloc<Float>(0);
    pointer.asTypedList(0);

    final pointer3 = calloc<Float>(length);
    pointer.asTypedList(li.length).setAll(0, []);

    process.call(
      pointer,
      pointer2,
      pointer3,
    );

    // LOG.d(">>>>>>>>>>>> ${}");

    return pointer3.asTypedList(li.length);

    // LOG.d(">>>>>>>>>>>> $res $res2 $res3");
  }

  _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        const encoder = AudioEncoder.pcm16bits;

        if (!await _isEncoderSupported(encoder)) {
          return;
        }

        RecordConfig config = RecordConfig(
          encoder: encoder,
          device: inputDevice,
          sampleRate: rate,
          numChannels: channel,
        );

        // // Record to stream
        await recordStream(
          _audioRecorder,
          config,
          (data) async {
            var float32 = Float32List(data.length);
            for (var i = 0; i < data.length; i++) {
              float32[i] = data[i] / 65536.0;
            }

            var a = float32;
            // _loadMath(float32);

            audioStream.push(a);
          },
        );

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
                child: Text('load math'),
                onTap: () async {
                  _initModel();
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
