import 'package:flutter/material.dart';

/// description:
/// project: flutter_challenge
/// @package:
/// @author: dammyololade
/// created on: 21/08/2020
class PlaceModel {
  String image, title, name, amount, description;
  Reporter reporter;
  Color bgColor;
  int index;

  PlaceModel(this.image, this.title, this.name, this.amount, this.description,
      this.reporter, this.bgColor, this.index);
}

class Reporter {
  String image, name, title, subtitle, description, descriptionImage;
  DateTime uploadedDate;

  Reporter(this.image, this.name, this.title, this.subtitle, this.description,
      this.descriptionImage, this.uploadedDate);
}
