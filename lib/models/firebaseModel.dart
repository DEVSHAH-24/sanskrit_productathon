import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseModel {
  static const String projectName = 'sanskrit';
  static const String messagingSenderId = '68627785713';
  static const String projectId = 'sanskrit-f24c2';
  static const String apiKey = 'AIzaSyAqdnYH3NngvrpLB4a0MsNnZIZHOXmreg4';
  static const String appId = '1:68627785713:android:39ee8d5ca584fb837e0650';
  static FirebaseFirestore _db;

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      name: projectName,
      options: FirebaseOptions(
        messagingSenderId: messagingSenderId,
        projectId: projectId,
        apiKey: apiKey,
        appId: appId,
      ),
    );
  }

}
