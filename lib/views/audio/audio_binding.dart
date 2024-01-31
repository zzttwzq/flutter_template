import 'package:app/views/audio/audio_controller.dart';
import 'package:get/get.dart';

class AudioBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => AudioController());
  }
}
