import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/views/login_view.dart';

import 'firebase_options.dart';

void main() {
  //To initialize the firebase without having to click on register
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          //The switch statement is to handle the exceptions when the user's network connection is too slow
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            //////////////////////////////////////////
            /// this part is the email verification check
              final user = FirebaseAuth.instance.currentUser;
              if (user?.emailVerified ?? false) {
                print('You are a verified user');
              } else {
                print('Verify your email first');
              }
            ///////////////////////////////////////////////
              return const Text('Done');
            default:
              return const Text('Loading..');
          }
        },
      ),
    );
  } 
}

