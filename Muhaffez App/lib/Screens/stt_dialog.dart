import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_recognition/Model/recite_model.dart';
import 'package:voice_recognition/colors.dart';

import '../dialog/dialogcubit_cubit.dart';

openSpeechToTextDialog(BuildContext context, cubit) {
  return showDialog(
      context: context,
      builder: (context) {
        final titleEditController = TextEditingController();
        final textEditController = TextEditingController();
        return BlocProvider(
          create: (context) => DialogCubit(),
          child: AlertDialog(
            title: const Text('speech to text'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<DialogCubit, DialogcubitState>(
                    buildWhen: (previous, current) {
                      return true;
                    },
                    builder: (context, state) {
                      DialogCubit dialogCubit = BlocProvider.of(context);
                      textEditController.text = dialogCubit.theFinaluslut;
                      return Column(
                        children: [
                          TextField(
                            maxLines: null,
                            textAlign: TextAlign.center,
                            controller: titleEditController,
                          ),
                          TextField(
                            maxLines: null,
                            textAlign: TextAlign.center,
                            controller: textEditController,
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<DialogCubit, DialogcubitState>(
                    buildWhen: (previous, current) {
                      return true;
                    },
                    builder: (context, state) {
                      DialogCubit dialogCubit = BlocProvider.of(context);
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 70,
                          height: 70,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: .26,
                                  spreadRadius: dialogCubit.level * 1.5,
                                  color: Colors.black.withOpacity(.05))
                            ],
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                          ),
                          child: IconButton(
                            iconSize: 40,
                            icon: const Icon(
                              Icons.mic,
                              color: maincolor,
                            ),
                            onPressed: () {
                              // if (dialogCubit.startlisteing) {
                              //   dialogCubit.stopListening();
                              // } else {
                              //   dialogCubit.startListening();
                              // }
                              if (!dialogCubit.hasSpeech) {
                                dialogCubit.initSpeechState();
                              } else {
                                if (dialogCubit.startlisteing) {
                                  dialogCubit.stopListening();
                                } else {
                                  dialogCubit.startListening();
                                }
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<DialogCubit, DialogcubitState>(
                    buildWhen: (previous, current) {
                      return true;
                    },
                    builder: (context, state) {
                      DialogCubit dialogCubit = BlocProvider.of(context);
                      return Text(!dialogCubit.hasSpeech
                          ? "not Initialize"
                          : dialogCubit.startlisteing
                              ? "listening"
                              : "not listening");
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              BlocBuilder<DialogCubit, DialogcubitState>(
                builder: (context, state) {
                  DialogCubit dialogCubit = BlocProvider.of(context);
                  return TextButton(
                    child: const Text('save'),
                    onPressed: () {
                      dialogCubit.endSpeech();
                      Rcite newRcite = Rcite();
                      newRcite.title = titleEditController.text;
                      newRcite.text = textEditController.text;
                      cubit.save(newRcite);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ],
          ),
        );
      });
}
