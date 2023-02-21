import 'package:flutter/material.dart';
import 'package:freelance_app/screens/activity/applicant-card.dart';
import 'jobs-card.dart';
import 'package:freelance_app/utils/layout.dart';
import 'package:freelance_app/utils/txt.dart';
import 'package:freelance_app/utils/clr.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApplicantsApp extends StatefulWidget {
  final String? job_id;
  const ApplicantsApp({super.key, this.job_id});

  @override
  State<ApplicantsApp> createState() => _ApplicantsAppState();
}

class _ApplicantsAppState extends State<ApplicantsApp> {
  final _auth = FirebaseAuth.instance;
  String? nameForposted;
  String? userImageForPosted;
  String? addressForposted;
  void getMyData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      nameForposted = userDoc.get('name');
      userImageForPosted = userDoc.get('user_image');
      addressForposted = userDoc.get('address');
    });
  }

  @override
  void initState() {
    super.initState();
    getMyData();
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    final uid = user!.uid;

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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('jobPosted')
                .doc(widget.job_id)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.data!["applicantsList"] == null) {
                  const Center(child: Text('No applicant for this job'));
                }
              }
              return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Applicant(
                      name: snapshot.data!['applicantsList'][index]['name'],
                      //title: snapshot.data.docs[index]['title'],
                      profilePic: snapshot.data!['applicantsList'][index]
                          ['user_image'],
                      date: snapshot.data!['applicantsList'][index]
                              ['timeapplied']
                          .toDate(),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    );
                  },
                  itemCount: snapshot.data!['applicantsList'].length);
            },
          ),
        ),
      ),
    );
  }
}



/*
Container(
      child: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('jobPosted')
            .doc('job_id')
            .get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data?.docs.isNotEmpty == true) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                  bottom: layout.padding,
                  left: layout.padding,
                  right: layout.padding,
                ),
                child: ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Applicant(
                        name: snapshot.data!['applicantsList'][index]['name'],
                        //title: snapshot.data.docs[index]['title'],
                        profilePic: snapshot.data!['applicantsList']
                            ['user_image'],
                        date: snapshot.data!['applicantsList'][index]
                                ['timeapplied']
                            .toDate(),
                      );
                    }),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(layout.padding * 6),
                child: Center(
                  child: Image.asset('assets/images/empty.png'),
                ),
              );
            }
          } else {
            return Center(
              child: Text(
                'FATAL ERROR',
                style: txt.error,
              ),
            );
          }
        },
      ),
    );
*/
/*
Column(
      children: [
        Job(
          position: 'Hospital Rceptionist',
          companyName: 'AAU',
          date: DateTime(2012, 1, 12),
          type: 'posted',
        ),
        Job(
          position: 'Script Writer',
          companyName: 'iCog',
          date: DateTime(2012, 2, 11),
          type: 'posted',
        ),
        Job(
          position: 'position',
          companyName: 'companyName',
          date: DateTime(2011, 10, 12),
          type: 'posted',
        ),
      ],
    )
*/