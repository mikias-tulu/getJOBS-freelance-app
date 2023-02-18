import "package:flutter/material.dart";
import 'package:freelance_app/utils/colors.dart';

import '../homescreen/sidebar.dart';

class FieldModel {
  String? job_title;
  String? company_name;
  FieldModel(this.job_title, this.company_name);
}

class Search extends StatefulWidget {
  static const routename = "search";

  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
// sample lists for filtering

  static List<FieldModel> main_field_list = [
    FieldModel("web development", "b2b technology"),
    FieldModel("react developer", " Via solution "),
    FieldModel("flutter developer", "Adore Addis "),
    FieldModel("project managment", "Rakan Travel Solution"),
    FieldModel("back end developer", "Digital Addis"),
  ];
  List<FieldModel> display_list = List.from(main_field_list);
  void Updatelist(String value) {
// for filtering the list
    setState(() {
      display_list = main_field_list
          .where((element) =>
              element.job_title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

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
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30.0, top: 40),
                child: Text("Search For A Job",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: black)),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: TextField(
                  onChanged: (value) => Updatelist(value),
                  style: TextStyle(color: yellow),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    hintText: "Flutter development",
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Color.fromRGBO(245, 186, 65, 1),
                    suffixIcon: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        //fixedSize: const Size.fromWidth(100),
                        padding: const EdgeInsets.all(22),
                      ),
                      onPressed: () {},
                      child: const Icon(Icons.search),
                    ),
                    suffixIconColor: yellow,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 200,
                child: display_list.isEmpty
                    ? const Center(
                        child: Text("No result found",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            )))
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: display_list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text('${display_list[index].job_title!}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            subtitle:
                                Text('${display_list[index].company_name!}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                    )),
                          );
                        },
                      ),
              )
            ],
          ),
        ));
  }
}
