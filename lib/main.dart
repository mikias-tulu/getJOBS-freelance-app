import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                    child: Text(
                  'Freelacne app initialized',
                  style: TextStyle(
                      fontFamily: 'signatra',
                      color: Colors.green,
                      fontSize: 30),
                )),
              ),
            );
          } else if (snapshot.hasError) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(child: Text('Error has occured')),
              ),
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Freelance App",
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.black,
                primarySwatch: Colors.blue),
            home: const Scaffold(),
          );
        });
  }
}
