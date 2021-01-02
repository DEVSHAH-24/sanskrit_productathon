import 'package:flutter/material.dart';
import 'package:sanskrit_project/models/dataModel.dart';
import 'package:sanskrit_project/models/firebaseModel.dart';

class Data with ChangeNotifier {
  List<DataModel> _usersData = [];
  List<String> _connectedUserIds = [];
  Map<String, List<String>> _requestedUserIds = {'SentByMe':[],'ReceivedForMe':[]};
  final FirebaseModel fm = FirebaseModel();

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

  Map<String, List<String>> get requestedUserIds {
    return {..._requestedUserIds};
  }

  List<String> get sentByMe {
    return [...requestedUserIds['SentByMe']];
  }

  List<String> get receivedForMe {
    return [...requestedUserIds['ReceivedForMe']];
  }

// void removeDataModel(DataModel dataModel){
//   _usersData.remove(dataModel);
//   notifyListeners();
// }
  bool isConnected(String id) {
    if (_connectedUserIds.contains(id)) return true;
    return false;
  }

  void removeConnect(String id) {
    _connectedUserIds.remove(id);
    notifyListeners();
    fm.updateConnectedUserIds(_connectedUserIds);
  }

  void connect(String id) {
    _requestedUserIds['SentByMe'].add(id);
    notifyListeners();
    fm.makeRequest(id,_requestedUserIds);
  }

  void accept(String id) {
    _requestedUserIds['ReceivedForMe'].remove(id);
    _connectedUserIds.add(id);
    notifyListeners();
    fm.acceptRequest(id,_requestedUserIds,_connectedUserIds);
  }

  bool sentByMeRequest(String id) {
    if (_requestedUserIds['SentByMe'].contains(id)) return true;
    return false;
  }

  bool receivedForMeRequest(String id) {
    if (_requestedUserIds['ReceivedForMe'].contains(id)) return true;
    return false;
  }
}
