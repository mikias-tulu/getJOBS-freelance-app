import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/screens/activity/activity.dart';
import 'package:freelance_app/utils/colors.dart';
import '../../screens/activity/Activity_jobs_posted.dart';
import '../../config/user_state.dart';

class AboutUS extends StatelessWidget {
  const AboutUS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.orange,
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 180),
          child: Text(
            "getJOBS",
            style: TextStyle(color: Colors.orange),
          ),
        ),
      ),
      body: Column(
        children: const [
          SizedBox(
            height: 5,
          ),
          Text("About Us",
              style: TextStyle(color: Colors.orange, fontSize: 25)),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(
                '''Welcome to our freelancing app, the perfect platform for freelancers and clients to connect and work together. Our app is designed to make the freelancing experience easy, efficient and secure.

For freelancers, our app provides a wide range of job opportunities from various clients around the world. Our user-friendly interface allows you to showcase your skills, portfolio, and experience. You can bid on projects that match your expertise and receive payments for the work you complete.

For clients, our app offers a pool of talented and experienced freelancers to choose from. You can post your projects, receive bids from freelancers, and hire the best match for your project. Our app provides a secure payment system, ensuring that you only pay for the work that meets your expectations.

Our freelancing app is the ideal platform for freelancers and clients to work together and build successful projects. Join our community today and let's create something great!'''),
          ),
        ],
      ),
    );
  }
}

class SideBar extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(top: 0),
      child: SizedBox(
        width: 230,
        child: Drawer(
          child: ListView(
            padding: const EdgeInsets.only(top: 50, left: 10),
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const AboutUS()));
                },
                leading: const Icon(
                  Icons.post_add,
                  size: 35,
                  color: yellow,
                ),
                title: const Text("About Us",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const JobsActivity()));
                },
                leading: const Icon(
                  Icons.history,
                  size: 35,
                  color: yellow,
                ),
                title: const Text("Job Posted",
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
