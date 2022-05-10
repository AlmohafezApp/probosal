import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../stt_class.dart';

part 'dialogcubit_state.dart';

class DialogCubit extends Cubit<DialogcubitState> {
  DialogCubit() : super(DialogcubitInitial());

  bool hasSpeech = false;
  bool logEvents = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastError = '';
  String newCopyOfRecognizedWords = '';

  bool startlisteing = false;
  bool stoplistening = false;
  List<String> theResultText_2 = [];
  String theFinaluslut = "";
  SttClass stt = SttClass();

  Future<void> initSpeechState() async {
    try {
      if (SttClass.hasSpeech) {
        hasSpeech = SttClass.hasSpeech;
      }
    } catch (e) {
      lastError = 'Speech recognition failed: ${e.toString()}';
      hasSpeech = false;
    }
    emit(DialogcubitInitial());
  }

  void startListening() {
    SttClass.cubit = this;
    stt.startListening();

    startlisteing = true;
    newCopyOfRecognizedWords = "";
    emit(DialogcubitInitial());
  }

  void statusListener(String status) async {
    if (status == "notListening") {
      startlisteing = false;
      level = 0.0;
      emit(DialogcubitInitial());
    }
  }

  void cancelListening() {
    // startlisteing = false;
    // level = 0.0;
    stoplistening = true;
    startlisteing = false;
    level = 0.0;
    SttClass.cubit = this;
    stt.cancelListening();
    //setState(() {});
  }

  void stopListening() {
    stoplistening = true;
    level = 0.0;
    SttClass.cubit = this;
    stt.stopListening();
  }

  void soundLevelListener(double _level) {
    minSoundLevel = min(minSoundLevel, _level);
    maxSoundLevel = max(maxSoundLevel, _level);
    level = _level;
    emit(DialogcubitInitial());
  }

  void resultListener(SpeechRecognitionResult result) {
    // check(result.recognizedWords);
    // print(result.recognizedWords);

    theResultText_2 = result.recognizedWords
        .substring(newCopyOfRecognizedWords.length)
        .split(" ");
    newCopyOfRecognizedWords = result.recognizedWords;
    //print(newCopyOfRecognizedWords);
    start(theResultText_2);
  }

  void start(List<String> _theResultText_2) {
    bool cond = true;
    if (_theResultText_2[0] == "") {
      if (_theResultText_2.length < 2) {
        cond = false;
      } else {
        _theResultText_2.removeAt(0);
      }
    }
    if (cond) {
      for (String item in _theResultText_2) {
        theFinaluslut += item + " ";
      }
    }
  }

  void endSpeech() {
    stopListening();
  }
}
