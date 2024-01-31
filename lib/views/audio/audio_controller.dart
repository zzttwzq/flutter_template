import 'package:app/views/audio/audio_model.dart';
import 'package:get/get.dart';

class AudioController extends GetxController {
  Rx<AudioModel> audioModel = AudioModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
