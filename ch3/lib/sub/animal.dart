import 'package:flutter/material.dart';

class Animal{
  String? imagePath;
  String? name;
  String? kind;
  bool? flyExist = false;

  Animal({
    required this.imagePath,
    required this.name,
    required this.kind,
    this.flyExist
  });
}