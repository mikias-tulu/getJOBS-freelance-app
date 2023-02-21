import 'package:flutter/material.dart';
import 'jobs-card.dart';
import 'package:freelance_app/utils/layout.dart';
import 'package:freelance_app/utils/txt.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class posted extends StatefulWidget {
  const posted({super.key});

  @override
  State<posted> createState() => _postedState();
}

class _postedState extends State<posted> {
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

    return Container(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('jobPosted')
            .where('id', isEqualTo: uid)
            .orderBy('created', descending: true)
            .snapshots(),
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
                      return Job(
                        jobID: snapshot.data.docs[index]['job_id'],
                        contactName: snapshot.data.docs[index]['name'],
                        contactImage: snapshot.data.docs[index]['user_image'],
                        jobTitle: snapshot.data.docs[index]['title'],
                        uploadedBy: snapshot.data.docs[index]['id'],
                        date: snapshot.data.docs[index]['created'].toDate(),
                        type: snapshot.data.docs[index]['id'] == uid
                            ? 'posted'
                            : 'taken',
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
  }
}



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