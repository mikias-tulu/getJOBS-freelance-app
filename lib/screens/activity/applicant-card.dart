import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'applicants.dart';
import 'details.dart';

class Applicant extends StatelessWidget {
  final String name;
  //final String title;
  final DateTime date;
  final String profilePic;

  const Applicant(
      {Key? key,
      required this.name,
      // required this.title,
      required this.date,
      required this.profilePic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text(name),
              ),
              body: Center(child: Text('Application')),
            ),
          ),
        );
      },
      child: Card(
        child: ListTile(
          leading: Image.network(profilePic),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 20),
              ),
              // Row(
              //   children: [
              //     for (int i = 0; i < stars; i++)
              //       const Icon(Icons.star, color: Colors.yellow)
              //   ],
              // )
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Text(title),
              Text(DateFormat.yMMMd().add_jm().format(date)),
            ],
          ),
        ),
      ),
    );
  }
}
