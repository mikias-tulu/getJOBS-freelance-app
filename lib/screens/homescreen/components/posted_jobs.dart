import "package:flutter/material.dart";

import 'package:freelance_app/utils/colors.dart';

class Postedjob extends StatefulWidget {
  @override
  State<Postedjob> createState() => _PostedjobState();
}

class _PostedjobState extends State<Postedjob> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 250,
              width: 200,
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: grey,
                      offset: Offset(15, 5),
                      blurRadius: 30,
                    )
                  ]),
              child: Column(
                children: [
                  const ListTile(
                    leading: Text("name of company",
                        style: TextStyle(
                            fontSize: 21,
                            color: yellow,
                            fontWeight: FontWeight.w800)),
                    trailing: Text("contractual",
                        style: TextStyle(
                          fontSize: 12,
                        )),
                  ),
                  const ListTile(
                      trailing: Text("payment type",
                          style: TextStyle(
                            fontSize: 18,
                          ))),
                  const ListTile(
                    leading: Text("job title",
                        style: TextStyle(
                            fontSize: 25,
                            color: yellow,
                            fontWeight: FontWeight.w900)),
                  ),
                  ListTile(
                    leading: const Text("posted time",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    trailing: ElevatedButton(
                      onPressed: () => {},
                      child: const Text(
                        "See Details ->",
                        style: TextStyle(
                            fontFamily: "Nexa-Thin",
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: red),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
