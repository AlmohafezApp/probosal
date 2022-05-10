import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_recognition/colors.dart';
import 'package:voice_recognition/Screens/stt_dialog.dart';
import 'addtion_records.dart';
import '../componants.dart';
import '../cubit/sttcubit_cubit.dart';
import 'item_details.dart';
import 'login.dart';
import 'splash_Screen.dart';

class HomePage extends StatelessWidget {
  //static final navKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SttcubitCubit(),
        child: MaterialApp(
          color: maincolor,
          theme: ThemeData(primarySwatch: Colors.deepPurple),
          debugShowCheckedModeBanner: false,
          home: Directionality(
              textDirection: TextDirection.rtl, child: SplashScreen()),
        ));
  }
}

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
    //required this.cubit,
  }) : super(key: key);

  // final SttcubitCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: maincolor,
          child: Icon(Icons.list),
          onPressed: (() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddtionRecords()));
          })),
      appBar: customAppBar(thetitle: 'Muhaffez App'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<SttcubitCubit, SttcubitState>(
                  builder: (context, state) {
                    SttcubitCubit cubit = BlocProvider.of(context);

                    return IconButton(
                        onPressed: () {
                          openSpeechToTextDialog(context, cubit);
                        },
                        icon: const Icon(
                          Icons.add,
                          color: maincolor,
                        ));
                  },
                ),
                const Spacer(),
                const Text(
                  "Main Text",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () async {},
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: maincolor,
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<SttcubitCubit, SttcubitState>(
              buildWhen: (previous, current) {
                return true;
              },
              builder: (context, state) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        SttcubitCubit.theMainText,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Recogized Words",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            BlocBuilder<SttcubitCubit, SttcubitState>(
              buildWhen: (previous, current) {
                return true;
              },
              builder: (context, state) {
                SttcubitCubit cubit = BlocProvider.of(context);
                cubit.emit(state);
                return Container(
                  width: double.infinity,
                  height: 200,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Wrap(
                          textDirection: TextDirection.rtl,
                          alignment: WrapAlignment.center,
                          // spacing: 0.2,
                          children: cubit.textSpans)),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                BlocBuilder<SttcubitCubit, SttcubitState>(
                  buildWhen: (previous, current) {
                    return true;
                  },
                  builder: (context, state) {
                    SttcubitCubit cubit = BlocProvider.of(context);

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
                                spreadRadius: cubit.level * 1.5,
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
                            print(!cubit.hasSpeech);
                            if (!cubit.hasSpeech) {
                              cubit.initSpeechState();
                            } else {
                              if (cubit.startlisteing) {
                                cubit.stopListening();
                              } else {
                                cubit.stoplistening = true;
                                cubit.startListening();
                              }
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
                BlocBuilder<SttcubitCubit, SttcubitState>(
                  builder: (context, state) {
                    SttcubitCubit cubit = BlocProvider.of(context);

                    return Positioned(
                      right: 100,
                      top: 15,
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.bottomCenter,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: IconButton(
                          splashRadius: 30,
                          iconSize: 20,
                          icon: const Icon(
                            Icons.replay,
                            color: maincolor,
                          ),
                          onPressed: () {
                            cubit.currentWordIndex = 0;
                            cubit.oldRecoginzedWords = '';
                            cubit.textSpans = [];
                            cubit.maincountinue = true;
                            cubit.theStatus = '';
                            cubit.emit(SttcubitInitial());
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<SttcubitCubit, SttcubitState>(
              buildWhen: (previous, current) {
                return true;
              },
              builder: (context, state) {
                SttcubitCubit cubit = BlocProvider.of(context);
                if (!cubit.maincountinue) {
                  cubit.startlisteing = false;
                }
                return Text(!cubit.hasSpeech
                    ? "not Initilize"
                    : cubit.startlisteing
                        ? "listening"
                        : "not listening");
              },
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<SttcubitCubit, SttcubitState>(
              builder: (context, state) {
                SttcubitCubit cubit = BlocProvider.of(context);

                return Text(
                  cubit.theStatus,
                  textAlign: TextAlign.center,
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<SttcubitCubit, SttcubitState>(
              builder: (context, state) {
                SttcubitCubit cubit = BlocProvider.of(context);

                return MaterialButton(
                  onPressed: () {
                    cubit.theStatus = "";
                    cubit.emit(SttcubitInitial());
                  },
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text(
                    "clear status",
                    style: TextStyle(color: maincolor),
                  ),
                  color: Colors.white,
                  height: 20,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
