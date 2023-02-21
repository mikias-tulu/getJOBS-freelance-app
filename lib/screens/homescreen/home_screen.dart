import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:freelance_app/screens/activity/activity.dart';

import 'package:freelance_app/screens/homescreen/components/categories.dart';
import 'package:freelance_app/screens/profile/profile.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/screens/homescreen/components/posted_jobs.dart';
import 'package:freelance_app/screens/homescreen/sidebar.dart';
import 'package:freelance_app/screens/search/search_screen.dart';
import 'package:uuid/uuid.dart';

import 'components/job_post.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationPage(
        title: "getJOBS",
      ),
    );
  }
}

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  late int currentIndex;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int? index) {
    setState(() {
      currentIndex = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _uid = user!.uid;
    print(_uid);
    return Scaffold(
      body: <Widget>[
        const Homepage(),
        const Search(),
        const JobsActivity(),
        ProfilePage(
          userID: _uid,
        ),
      ][currentIndex],
      floatingActionButton: currentIndex == 0 || currentIndex == 1
          ? FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 245, 171, 59),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Upload(
                            userID: _uid,
                          ) //const LoginScreen(),
                      ),
                );
              },
              child: const Icon(
                Icons.add_rounded,
                //size: 40,
                color: Colors.white,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: Colors.white,
        hasNotch: false,
        //fabLocation: BubbleBottomBarFabLocation.end,
        opacity: 0.5,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(0),
        ), //border radius doesn't work when the notch is enabled.
        //elevation: 10,
        tilesPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),

        items: const <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Colors.blueGrey,
            icon: Icon(
              Icons.dashboard,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.dashboard,
              color: Colors.white,
            ),
            title: Text(
              "Home",
              style: TextStyle(color: Color(0xFFFFFFFF)),
            ),
          ),
          BubbleBottomBarItem(
              backgroundColor: Colors.blueGrey,
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              title: Text(
                "Search",
                style: TextStyle(color: Color(0xFFFFFFFF)),
              )),
          BubbleBottomBarItem(
              backgroundColor: Colors.blueGrey,
              icon: Icon(
                Icons.library_books,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.library_books,
                color: Colors.white,
              ),
              title: Text(
                "Activity",
                style: TextStyle(color: Color(0xFFFFFFFF)),
              )),
          BubbleBottomBarItem(
              backgroundColor: Colors.blueGrey,
              icon: Icon(
                Icons.person_outline,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.person_outline_rounded,
                color: Colors.white,
              ),
              title: Text(
                "Profile",
                style: TextStyle(color: Color(0xFFFFFFFF)),
              )),
        ],
      ),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Text(
                "Find Your Perfect ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 15),
              child: Text(
                "Job",
                style: TextStyle(
                  color: yellow,
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              ),
            ),
            // Category(),
            SizedBox(
              height: 10,
            ),
            Postedjob(),
            //Bottomnavbar(),
          ],
        ),
      ),
    );
  }
}
