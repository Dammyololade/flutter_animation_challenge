import 'package:flutter/cupertino.dart';

/// description:
/// project: flutter_challenge
/// @package: 
/// @author: dammyololade
/// created on: 22/08/2020
class PageViewHolder extends ChangeNotifier{

  double value;


  PageViewHolder({this.value});

  void setValue(newValue) {
    this.value = newValue;
    notifyListeners();
  }
}