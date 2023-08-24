import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOption {
    if (Platform.isAndroid) {
      return const FirebaseOptions(
          apiKey: 'AIzaSyDFbxDco0hS1zfMSenGtHYywpW12nmyaCI',
          appId: '1:303907978899:android:c8de5fae042f30ea9e5766',
          messagingSenderId: '303907978899',
          projectId: 'clothesappfinal');
    } else
      return const FirebaseOptions(
        apiKey: 'AIzaSyDSuEQzw6v_MxP_owGMMFPO4y1NV0u41HQ', 
        appId: '1:303907978899:ios:c43aa634e79324019e5766', 
        messagingSenderId: '303907978899', 
        projectId: 'clothesappfinal');
  }
}
