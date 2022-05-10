import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:voice_recognition/Screens/mainpage.dart';

import 'bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(HomePage());
}
