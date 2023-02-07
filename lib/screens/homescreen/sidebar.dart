import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/utils/colors.dart';

import '../../config/user_state.dart';

class SideBar extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: SizedBox(
        width: 280,
        child: Drawer(
          child: ListView(
            padding: const EdgeInsets.only(top: 50, left: 10),
            children: [
              const ListTile(
                leading: Icon(
                  Icons.post_add,
                  size: 35,
                  color: yellow,
                ),
                title: Text("job's posted",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              const ListTile(
                leading: Icon(
                  Icons.history,
                  size: 35,
                  color: yellow,
                ),
                title: Text("job history",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              const ListTile(
                leading: Icon(
                  Icons.settings,
                  size: 35,
                  color: yellow,
                ),
                title: Text("Settings",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                onTap: () {
                  _auth.signOut();
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserState()));
                },
                leading: const Icon(
                  Icons.logout,
                  size: 35,
                  color: yellow,
                ),
                title: const Text(
                  "Log out",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
