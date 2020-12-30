import 'package:flutter/material.dart';
import 'package:sanskrit_project/models/dataModel.dart';
import 'package:sanskrit_project/models/firebaseModel.dart';

class Data with ChangeNotifier {
  List<DataModel> _usersData = [];
  List<String> _connectedUserIds = [];

  List<DataModel> get items {
    return [..._usersData];
  }

  void addDataModel(DataModel dataModel) {
    _usersData.add(dataModel);
    notifyListeners();
  }

  void storeConnectedUserIds(List<String> connectedUserIds) {
    _connectedUserIds = connectedUserIds;
  }

  List<String> get connectedUserIds {
    return [..._connectedUserIds];
  }

// void removeDataModel(DataModel dataModel){
//   _usersData.remove(dataModel);
//   notifyListeners();
// }
  bool isConnected(String id) {
    if (_connectedUserIds.contains(id)) return true;
    return false;
  }

  void toggleConnected(String id) {
    if (_connectedUserIds.contains(id)) {
      _connectedUserIds.remove(id);
    } else {
      _connectedUserIds.add(id);
    }
    notifyListeners();
    FirebaseModel fm = FirebaseModel();
    fm.updateConnectedUserIds(_connectedUserIds);

  }
}
