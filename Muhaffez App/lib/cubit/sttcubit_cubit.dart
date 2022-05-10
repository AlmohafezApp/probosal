import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:voice_recognition/Model/recite_model.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'dart:math';
import 'dart:async';

import '../stt_class.dart';
part 'sttcubit_state.dart';

class SttcubitCubit extends Cubit<SttcubitState> {
  SttcubitCubit() : super(SttcubitInitial());
  List<Rcite> rciteList = [];
  Rcite currentRcite = Rcite();
  static String theMainText = '';
  bool hasSpeech = false;
  bool logEvents = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastError = '';
  String lastStatus = '';
  bool startlisteing = false;
  bool stoplisteing = false;
  bool pauselisteing = false;
  bool isCompreCorrect = false;
  String theStatus = '';
  bool themounted = true;
// String _currentLocaleId = '';
  List<String> theResultText = [];
  List<String> wrongWordList = [];
  String newCopyOfRecognizedWords = '';
  String oldRecoginzedWords = '';
  bool maincountinue = true;
  List<String> theMainListText = [];

  List<Widget> textSpans = [];
  String mainWord = "";
  String compareWord = "";
  int currentWordIndex = 0;
  bool stoplistening = false;
  String newVoiceText = "";
  bool isTTSintilzq = false;
  TextToSpeech tts = TextToSpeech();
  SttClass stt = SttClass();
  void convert() {
    if (theMainText.isNotEmpty) {
      final rows = theMainText.split("\n");
      for (String item in rows) {
        theMainListText.addAll(item.split(" "));
      }
    }
  }

  /// this for initilze Text To Speach(TTS) object
  void initilzeTTS() {
    tts.setLanguage("ar");
    tts.setVolume(1.0);
    tts.setRate(1.0);
    tts.setPitch(1.0);
  }

  Future<void> initSpeechState() async {
    if (SttClass.hasSpeech) {
      hasSpeech = SttClass.hasSpeech;
    }
    if (theMainListText.isEmpty) {
      convert();
    }
    if (isTTSintilzq) {
      initilzeTTS();
      isTTSintilzq = true;
    }
    emit(SttcubitInitial());
  }

  /// This is called each time the users wants to start a new speech
  /// recognition session
  void startListening() {
    SttClass.cubit = this;
    stt.startListening();
    startlisteing = true;
    newCopyOfRecognizedWords = "";
    emit(SttcubitInitial());
  }

  void stopListening() {
    stoplistening = true;
    startlisteing = false;
    level = 0.0;
    SttClass.cubit = this;
    stt.stopListening();

    emit(SttcubitInitial());
  }

  /// This called each time new recognition results are
  /// available after `listen` is called.

  void soundLevelListener(double _level) {
    minSoundLevel = min(minSoundLevel, _level);
    maxSoundLevel = max(maxSoundLevel, _level);
    level = _level;
    emit(SttcubitInitial());
  }

  /// This called each time new recognition results are
  /// available after `listen` is called.
  void resultListener(SpeechRecognitionResult result) {
    // here 'result.recognizedWords' have all recognized words but
    // we just need the new recognized words
    // so get copy for it then the next time we substract this copy
    // from the new 'result.recognizedWords'
    theResultText = result.recognizedWords
        .substring(newCopyOfRecognizedWords.length)
        .split(" ");
    newCopyOfRecognizedWords = result.recognizedWords;
    startComparing(theResultText);
  }

  /// here we compare the new result list with the main text list
  /// start from index 0 for the result list and
  /// last correct index+1 'currentWordIndex' for the main text list
  void startComparing(List<String> _theResultText_2) {
    bool cond = true;
    bool _comparecountinue = true;
    bool _charcountinue = true;
    //may be afrer substrcat "check method before"first index become null
    //which will cause error while checking
    //so this code check if first index is null and is the list is empty
    // if we remove the the first index
    if (_theResultText_2[0] == "") {
      if (_theResultText_2.length < 2) {
        cond = false;
      } else {
        _theResultText_2.removeAt(0);
      }
    }

    if (maincountinue && cond) {
      ///select compare word
      for (int currentcomperindex = 0; _comparecountinue;) {
        if (currentcomperindex < _theResultText_2.length) {
          if (currentWordIndex < theMainListText.length) {
            mainWord = theMainListText[currentWordIndex];

            _charcountinue = true;
          } else {
            maincountinue = false;
            _comparecountinue = false;
            _charcountinue = false;
            break;
          }
          compareWord = _theResultText_2[currentcomperindex];

          ///char compare
          if (mainWord.length == compareWord.length) {
            for (int charindex = 0; _charcountinue;) {
              if (charindex < mainWord.length &&
                  charindex < compareWord.length) {
                if (mainWord[charindex] == compareWord[charindex]) {
                  charindex++;
                } else {
                  ///if the two words dosenot match
                  isCompreCorrect = false;
                  break; //break char compare
                }
              } else {
                ///if compate char done without problems
                if (maincountinue) {
                  isCompreCorrect = true;
                }
                break; //break char compare
              }
            }
          } else {
            isCompreCorrect = false;
          }

          if (isCompreCorrect) {
            if (maincountinue) {
              stoplistening = false;
              textSpans.add(
                Container(
                  color: const Color(0xff94FFBE),
                  child: Text(
                    " $compareWord ",
                    textAlign: TextAlign.center,
                  ),
                ),
              );
              emit(SttcubitInitial());
            }
            currentWordIndex++;
          } else {
            ///if the two words dose not match
            cancelListening();
            _charcountinue = false;
            _comparecountinue = false;
            newVoiceText =
                "خطأ ليس ${compareWord} ولكن ${theMainListText[currentWordIndex]}";

            textSpans.add(
              Container(
                color: const Color(0xffFFA794),
                child: Text(
                  " $compareWord",
                  textAlign: TextAlign.center,
                ),
              ),
            );
            wrongWordList.add(compareWord);
            emit(SttcubitInitial());

            theStatus += newVoiceText + "\n";
            initilzeTTS();
            // here we use  text to speach to say the error
            tts.speak(newVoiceText);
            // here we start listening after we say the error
            Future.delayed(const Duration(milliseconds: 4000), () {
              isCompreCorrect = true;
              startListening();
            });
          }

          ///end char compare
          currentcomperindex++;
        } else {
          ///if the Ruslt list end
          _comparecountinue = false;
        }
      }

      ///End compare word segment

      if (!(currentWordIndex < theMainListText.length)) {
        maincountinue = false;
        stopListening();
        RciteTring newtring = RciteTring();
        final date = DateTime.now();
        newtring.date = "${date.day}/${date.month}/${date.year}";

        if (date.hour > 12) {
          newtring.time = "${date.hour - 12}:${date.minute}PM ";
        } else {
          newtring.time = "${date.hour}:${date.minute}PM ";
        }
        newtring.wrongWordsList = wrongWordList;
        newtring.totalWords = currentRcite.wordsList.length;
        currentRcite.tringList.add(newtring);
        print("------END-------");
      }
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
  }

  void statusListener(String status) async {
    print("status : " + status);
    if (status == "notListening") {
      startlisteing = false;
      level = 0.0;
      if (maincountinue && !stoplistening) {
        Future.delayed(const Duration(milliseconds: 2000), () {
          if (!stoplistening) {
            startListening();
          }
        });
      }
      if (!maincountinue) {
        startlisteing = false;
        level = 0.0;
      }
      emit(SttcubitInitial());
      print("not ------------------------");
    }
  }

  void convertFromDialog() {
    theMainListText.clear();
    final stringList = theMainText.split(" ");
    for (String item in stringList) {
      if (item != "") {
        theMainListText.add(item);
      }
    }
    theMainText = '';
    for (int i = 0; i < theMainListText.length; i++) {
      if (theMainListText[i] != "") {
        theMainText += theMainListText[i] + " ";
        if (i % 5 == 0 && i != 0) {
          theMainText += "\n";
        }
      }
    }
  }

  void save(Rcite value) {
    theMainText = value.text;
    value.convertTextToList(theMainText);
    rciteList.add(value);
    currentRcite = value;
    convertFromDialog();
    print(theMainListText);
    emit(SttcubitInitial());
  }
  // void imageToText() async {
  //   final ImagePicker _picker = ImagePicker();
  //   // Pick an image
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   // Capture a photo
  //   // final XFile? photo = await _picker.pickImage(
  //   //     source: ImageSource.camera);
  //    final imageFile = File(image!.path);

  //   final GoogleVisionImage visionImage = GoogleVisionImage.fromFile(imageFile);
  //   final TextRecognizer textRecognizer =
  //       GoogleVision.instance.textRecognizer();

  //   final VisionText visionText =
  //       await textRecognizer.processImage(visionImage);

  //   String text = visionText.text!;
  //   print(text);
  //   // for (TextBlock block in visionText.blocks) {
  //   //   final Rect boundingBox = block.boundingBox!;
  //   //   final List<Offset> cornerPoints =
  //   //       block.cornerPoints;
  //   //   final String text = block.text!;
  //   //   final List<RecognizedLanguage> languages =
  //   //       block.recognizedLanguages;

  //   //   for (TextLine line in block.lines) {
  //   //     // Same getters as TextBlock
  //   //     for (TextElement element in line.elements) {
  //   //       // Same getters as TextBlock
  //   //     }
  //   //   }
  //   // }
  // }
}
