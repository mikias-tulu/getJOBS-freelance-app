import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:freelance_app/screens/homescreen/components/categories.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/screens/homescreen/components/posted_jobs.dart';
import 'package:freelance_app/screens/homescreen/sidebar.dart';
import 'package:freelance_app/screens/homescreen/bottom_navbar.dart';
import 'package:freelance_app/screens/search/search_screen.dart';
import 'package:popup_card/popup_card.dart';

import 'components/job_post.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
      routes: {Search.routename: (_) => const Search()},
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
      drawer: const SideBar(),
      appBar: AppBar(
        backgroundColor: yellow,
        title: const Padding(
          padding: EdgeInsets.only(left: 180),
          child: Text("getJOBS"),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 5, top: 20),
              child: Text(
                "Find Your Perfect ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 30),
              child: Text(
                "Job",
                style: TextStyle(
                  color: yellow,
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              ),
            ),
            Category(),
            SizedBox(
              height: 25,
            ),
            Postedjob(),
            //Bottomnavbar(),
          ],
        ),
      ),

      //job post floating action button
      floatingActionButton: PopupItemLauncher(
        tag: 'test',
        popUp: PopUpItem(
          padding: const EdgeInsets.all(8),
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          elevation: 2,
          tag: 'test',
          child: const JobPosts(),
        ),
        child: Material(
          color: Colors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: const Icon(FontAwesomeIcons.filePen),
          /* const Icon(
            Icons.,
            size: 56,
          ), */
        ),
      ),

      /*
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 15),
        color: white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.home, size: 35),
            /* GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Second())),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Second.routename);
                  },
                  icon: Icon(Icons.shopping_bag_outlined, size: 35)),
            ),*/
            Icon(Icons.search, size: 35),
            Icon(Icons.post_add_rounded, size: 35),
            Icon(Icons.person, size: 35),
          ],
        ),
      ),*/
    );
  }
}
