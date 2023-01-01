import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import "package:flutter/material.dart";
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/screens/search/search_screen.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bottomnavbar(),
      routes: {Search.routename: (_) => Search()},
    );
  }
}

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Scaffold(
        bottomNavigationBar:
            CurvedNavigationBar(backgroundColor: yellow, items: [
          Icon(Icons.home),
          GestureDetector(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => Search())),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Search.routename);
                },
                icon: Icon(Icons.search, size: 35)),
          ),
          Icon(Icons.post_add_rounded, size: 35),
          Icon(Icons.person, size: 35),
        ]),
      ),
    );
  }
}
