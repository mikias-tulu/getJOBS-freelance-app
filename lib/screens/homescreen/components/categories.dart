import "package:flutter/material.dart";

import 'package:freelance_app/utils/colors.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final List<String> fields = [
    "GRAPHICS DESIGN",
    "UI/UX",
    "WEB DEVELOPMENT",
    "PROJECT MANAGMENT",
    "GRAPHICS DESIGN",
    "UI/UX",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: fields.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              height: 2,
              margin: const EdgeInsets.all(8),
              /*
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),*/
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
    );
  }
}
