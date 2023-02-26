import "package:flutter/material.dart";
import 'package:freelance_app/screens/homescreen/components/posted_jobs.dart';

class Category extends StatefulWidget {
  //final cata = const Postedjob();
  const Category({
    super.key,
  });

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final List<String> fields = [
    "RECENT JOBS",
    "GRAPHICS DESIGN",
    "UI/UX",
    "WEB DEVELOPMENT",
    "PROJECT MANAGMENT",
    "GRAPHICS DESIGN",
    "UI/UX",
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: fields.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 2,
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    left: 18,
                    right: 5,
                  ),
                  child: Text(fields[index],
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                ));
          },
        ),
      ),
    );
  }
}
