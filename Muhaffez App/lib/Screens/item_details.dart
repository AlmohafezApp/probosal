import 'package:flutter/material.dart';
import 'package:voice_recognition/Model/recite_model.dart';
import 'package:voice_recognition/colors.dart';
import '../componants.dart';

class ItemDetails extends StatelessWidget {
  ItemDetails({required this.theRcite});
  final Rcite theRcite;
  @override
  Widget build(BuildContext context) {
    String therepeatedMistaksText = "";
    for (var i = 0; i < theRcite.repeatedWrongWordsList.length; i++) {
      therepeatedMistaksText += theRcite.repeatedWrongWordsList[i];
    }
    double titleFontSize = 20;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: customAppBar(thetitle: theRcite.title),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: const AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "The Text",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: titleFontSize),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete,
                          color: maincolor,
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        // 'بسم الله الرحمن الرحيم ' +
                        //     'الحمد لله رب العالمين' +
                        //     '\n' +
                        //     'الرحمن الرحيم ' +
                        //     'مالك يوم الدين ' +
                        //     'اياك نعبد واياك نستعين ' +
                        //     'اهدنا الصراط المستقيم '
                        //         'صراط الذين انعمت عليهم ' +
                        //     'غير المغضوب عليم ' +
                        //     ' ولا الضالين',
                        theRcite.text,

                        textAlign: TextAlign.start,
                        // overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                        text: "Edit",
                        icon: Icons.edit_rounded,
                        thefunction: () {},
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CustomButton(
                        text: "Start Recite",
                        icon: Icons.mic,
                        thefunction: () {},
                      ),
                    ],
                  ),
                ),
                Text(
                  "Repeated Mistakes",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: titleFontSize),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      therepeatedMistaksText == ""
                          ? "لا يوجد"
                          : therepeatedMistaksText,
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
                Text(
                  " last Trying",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: titleFontSize),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: theRcite.tringList.length,
                    itemBuilder: (context, index) =>
                        DetailsCard(rciteTring: theRcite.tringList[index])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  CustomButton({
    required this.text,
    required this.icon,
    this.thefunction,
    Key? key,
  }) : super(key: key);
  String text;
  IconData icon;
  void Function()? thefunction;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: thefunction,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              text,
              style: const TextStyle(color: maincolor),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              icon,
              color: maincolor,
              size: 20,
            ),
          ],
        ),
      ),
      color: Colors.white,
      height: 20,
    );
  }
}

class DetailsCard extends StatelessWidget {
  DetailsCard({Key? key, required this.rciteTring}) : super(key: key);
  final RciteTring rciteTring;
  @override
  Widget build(BuildContext context) {
    String theText = "";
    for (var i = 0; i < rciteTring.wrongWordsList.length; i++) {
      theText += rciteTring.wrongWordsList[i];
      if (i != rciteTring.wrongWordsList.length - 1) {
        theText += " , ";
      }
    }
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.close_rounded,
                        color: maincolor,
                      )),
                  Expanded(
                    child: Center(
                      child: Text(
                        "12/02/2022 9:30PM",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            color: Colors.black,
                            //    fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                ],
              ),
              Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: "Mistakes : ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    TextSpan(
                        text: theText == "" ? "لا يوجد" : theText,
                        style: TextStyle(color: Colors.black, fontSize: 18))
                  ]),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr),
              Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "total word: ${rciteTring.totalWords}",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "wrong word:${rciteTring.wrongWordsList.length}",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
