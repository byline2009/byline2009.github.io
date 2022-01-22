import 'package:flutter/material.dart';

const kHintStyle = TextStyle(fontSize: 13, letterSpacing: 1.2);
var kOutlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.transparent));
var kOutlineBorderError = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.transparent));
const kLoaderBtn = SizedBox(
  height: 20,
  width: 20,
  child: CircularProgressIndicator(
      strokeWidth: 1.5,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
);
var kHeadingStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
