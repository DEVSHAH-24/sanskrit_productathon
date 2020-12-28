import 'package:flutter/material.dart';
import 'package:sanskrit_project/models/dataModel.dart';

class Data with ChangeNotifier {
  List<DataModel> _usersData = [];

  List<DataModel> get items {
    return [..._usersData];
  }

  void addDataModel(DataModel dataModel) {
    _usersData.add(dataModel);
    notifyListeners();
  }
  // void removeDataModel(DataModel dataModel){
  //   _usersData.remove(dataModel);
  //   notifyListeners();
  // }
}
