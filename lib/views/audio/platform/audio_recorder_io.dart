import 'dart:io';
import 'dart:typed_data';

import 'package:app/utils/c_log_util.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:app/views/audio/record.dart';
import 'package:record_platform_interface/record_platform_interface.dart';

mixin AudioRecorderMixin {
  Future<void> recordFile(
      AudioRecorder recorder, RecordConfig config, int tag) async {
    final path = await _getPath(tag);
    LOG.d(">>> $path");
    await recorder.start(config, path: path);
  }

  Future<void> recordStream(
    AudioRecorder recorder,
    RecordConfig config,
    Function(List data) dataChanged,
  ) async {
    final path = await _getPath(333);

    // final file = File(path);

    final stream = await recorder.startStream(config);

    stream.listen(
      (data) {
        // ignore: avoid_print
        // print(
        //   recorder.convertBytesToInt16(Uint8List.fromList(data)),
        // );
        // file.writeAsBytesSync(data, mode: FileMode.append);

        dataChanged
            .call(recorder.convertBytesToInt16(Uint8List.fromList(data)));
      },
      // ignore: avoid_print
      onDone: () {
        // ignore: avoid_print
        print('End of stream. File written to $path.');
      },
    );
  }

  void downloadWebData(String path) {}

  Future<String> _getPath(int tag) async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(
      dir.path,
      'audio_$tag.wav',
    );
  }
}
