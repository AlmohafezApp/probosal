import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_recognition/Model/recite_model.dart';
import 'package:voice_recognition/colors.dart';

import '../cubit/sttcubit_cubit.dart';
import 'item_details.dart';

class AddtionRecords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: maincolor,
          title: const Center(
              child: Text(
            'Addtion Records',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          )),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          )),
      body: BlocBuilder<SttcubitCubit, SttcubitState>(
        builder: (context, state) {
          SttcubitCubit cubit = BlocProvider.of(context);
          return ListView.builder(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: cubit.rciteList.length,
            itemBuilder: (context, index) =>
                AddtionItem(rciteItem: cubit.rciteList[index]),
          );
        },
      ),
    );
  }
}

class AddtionItem extends StatelessWidget {
  AddtionItem({Key? key, required this.rciteItem}) : super(key: key);
  Rcite rciteItem;

  @override
  Widget build(BuildContext context) {
    int totalWords =
        rciteItem.tringList[rciteItem.tringList.length - 1].totalWords;
    int wrongwords = rciteItem
        .tringList[rciteItem.tringList.length - 1].wrongWordsList.length;
    int prograss = (((totalWords - wrongwords) / totalWords) * 100).toInt();
    double width = (prograss * 200) / 100;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemDetails(
                      theRcite: rciteItem,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 280,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Text(
                      rciteItem.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                  Material(
                    color: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          rciteItem.text,
                          textDirection: TextDirection.rtl,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              //   fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 10,
                            width: 200,
                            child: Material(
                              color: Colors.grey[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                            width: width,
                            child: Material(
                              color: maincolor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        "Progres: ${prograss.toInt()}%",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
