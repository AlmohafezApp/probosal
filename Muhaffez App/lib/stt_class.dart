import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SttClass {
  SpeechToText speech = SpeechToText();
  static bool hasSpeech = false;
  bool logEvents = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = "ar_EG";
  bool isCurrentLanguageInstalled = false;

  List<LocaleName> _localeNames = [];
  List<String> theResultText_2 = [];
  static var cubit;
  SttClass() {
    initSpeechState();
  }

  Future<void> initSpeechState() async {
    try {
      var _hasSpeech = await speech.initialize(
        onStatus: statusListener,
        debugLogging: false,
      );
      if (hasSpeech) {
        _localeNames = await speech.locales();
      }

      hasSpeech = _hasSpeech;
    } catch (e) {
      lastError = 'Speech recognition failed: ${e.toString()}';
      hasSpeech = false;
    }
  }

  void startListening() {
    speech.listen(
        onResult: resultListener,
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        listenMode: ListenMode.confirmation);
  }

  void stopListening() {
    if (!speech.isNotListening) {
      speech.stop();
    }
  }

  void soundLevelListener(double _level) {
    cubit.soundLevelListener(_level);
  }

  void resultListener(SpeechRecognitionResult result) {
    cubit.resultListener(result);
  }

  void cancelListening() {
    if (speech.isListening) {
      speech.cancel();
    }
  }

  void statusListener(String status) async {
    cubit.statusListener(status);
  }
}
