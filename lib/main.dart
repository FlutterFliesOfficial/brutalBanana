import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'utils/colors.dart';
import 'view/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAAGOArob6ydiAnldyND3UQTU7aIYO",
          appId: "1:812737820429:web:32f20709326a071198e244",
          messagingSenderId: "812737820429",
          projectId: "brutalbanana-a669e"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' Dashboard  ',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: darkBlack,
      ),
      home: const HomeScreen(),
    );
  }
}
