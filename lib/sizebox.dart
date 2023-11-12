// ignore_for_file: camel_case_extensions
import 'package:flutter/material.dart';

extension emptySpace on num
{
  SizedBox get h => SizedBox(height:toDouble());
  SizedBox get w => SizedBox(width:toDouble());
}

Color mainColor = const Color(0xffcfdddd);