import 'package:flutter/material.dart';

import 'colors.dart';

AppBar customAppBar({required thetitle}) {
  return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: maincolor,
      title: Center(
          child: Text(
        thetitle,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      )),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ));
}

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key? key, required this.controller, this.isObscure = false})
      : super(key: key);
  TextEditingController controller;
  bool isObscure;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        width: 300,
        child: Material(
          color: Colors.grey[200],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: TextFormField(
            obscureText: isObscure,
            controller: controller,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
