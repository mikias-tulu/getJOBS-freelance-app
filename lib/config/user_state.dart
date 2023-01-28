import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/screens/homescreen/home_screen.dart';
import 'package:freelance_app/screens/introduction_screen.dart';

class UserState extends StatelessWidget {
  const UserState({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        if (userSnapshot.data == null) {
          return const OnBoardingPage();
        } else if (userSnapshot.hasData) {
          return const Homescreen();
        } else if (userSnapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text(
                'An error has occurred. Try again later.',
              ),
            ),
          );
        } else if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return const Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Text(
              'FATAL ERROR',
              style: TextStyle(color: Colors.red, fontSize: 30),
            ),
          ),
        );
      },
    );
  }
}
