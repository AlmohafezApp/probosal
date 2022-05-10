import 'package:flutter/material.dart';
import 'package:voice_recognition/colors.dart';

class SwipeToStartScreen extends StatelessWidget {
  const SwipeToStartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      body: Column(
        //textDirection: TextDirection.ltr,
        children: [
          const Spacer(),
          Material(
            color: backgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80), topRight: Radius.circular(80)),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
              child: Column(
                children: [
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      "Muhaffez App",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 40.0, horizontal: 18),
                    child: Text(
                      "best app to assisant you to memorizes  any thing you want let's start ...",
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(color: Colors.grey, fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: Material(
                        color: maincolor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Stack(
                          children: [
                            Center(
                                child: Text(
                              "Swipe to start",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                            Align(
                              alignment: Alignment(-1, 0),
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: SizedBox(
                                    width: 70,
                                    height: double.infinity,
                                    child: Material(
                                      color: backgroundColor,
                                      shape: CircleBorder(),
                                      child: Icon(
                                        Icons.arrow_back_rounded,
                                        size: 40,
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
