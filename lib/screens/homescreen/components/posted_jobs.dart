import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:freelance_app/utils/global_variables.dart';

import 'package:freelance_app/utils/layout.dart';
import 'package:freelance_app/utils/txt.dart';
import 'package:freelance_app/utils/clr.dart';
import 'package:freelance_app/widgets/job_tile.dart';

class Postedjob extends StatefulWidget {
  const Postedjob({super.key});

  @override
  State<Postedjob> createState() => _PostedjobState();
}

class _PostedjobState extends State<Postedjob> {
  String? jobCategoryFilter;

  void getMyData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      name = userDoc.get('name');
      user_image = userDoc.get('user_image');
      address = userDoc.get('address');
    });
  }

  @override
  void initState() {
    super.initState();
    getMyData();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Expanded(
          flex: 0,
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {
                  showJobCategoriesDialog();
                },
                icon: const Icon(
                  Icons.filter_list,
                  color: clr.primary,
                  size: layout.iconMedium,
                ),
              ),
              Text(
                "Filter Jobs based on your choice",
                style: txt.body2Dark.copyWith(color: Colors.grey),
                //TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ],
          ),
        ),
        Container(
          child: jobCategoryFilter != null
              ? Text(
                  jobCategoryFilter.toString(),
                  style: txt.body2Dark,
                )
              : const Text(
                  "Recent Jobs",
                  style: txt.body2Dark,
                ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('jobPosted')
                .where('category', isEqualTo: jobCategoryFilter)
                .where('recruiting', isEqualTo: true)
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
                          return JobTile(
                            jobID: snapshot.data.docs[index]['job_id'],
                            jobTitle: snapshot.data.docs[index]['title'],
                            jobDesc: snapshot.data.docs[index]['desc'],
                            uploadedBy: snapshot.data.docs[index]['id'],
                            contactName: snapshot.data.docs[index]['name'],
                            contactImage: snapshot.data.docs[index]
                                ['user_image'],
                            contactEmail: snapshot.data.docs[index]['email'],
                            jobLocation: snapshot.data.docs[index]['address'],
                            recruiting: snapshot.data.docs[index]['recruiting'],
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
        ),
      ],
    ));
  }

  //job filtering

  showJobCategoriesDialog() {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: Padding(
            padding: const EdgeInsets.only(
              top: layout.padding,
              bottom: layout.padding,
            ),
            child: Text(
              'Job Categories',
              textAlign: TextAlign.center,
              style: txt.titleLight.copyWith(color: clr.passiveLight),
            ),
          ),
          content: SizedBox(
            width: size.width * 0.9,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: jobCategories.length,
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      jobCategoryFilter = jobCategories[index];
                    });
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: index != jobCategories.length - 1
                          ? layout.padding
                          : 0,
                    ),
                    child: Row(children: [
                      Icon(
                        Icons.business,
                        color: clr.passiveLight,
                        size: 25.0,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: layout.padding * 1.25,
                          ),
                          child: Text(
                            jobCategories[index],
                            style: txt.body2Light
                                .copyWith(color: clr.passiveLight),
                          ),
                        ),
                      ),
                    ]),
                  ),
                );
              }),
            ),
          ),
          actions: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              InkWell(
                onTap: () {
                  setState(() {
                    jobCategoryFilter = null;
                  });
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: layout.padding,
                    bottom: layout.padding * 2,
                  ),
                  child: Row(children: [
                    Icon(
                      Icons.clear_all,
                      color: clr.passiveLight,
                      size: layout.iconSmall,
                    ),
                    const Text(
                      ' Clear Filter',
                      style: txt.body1Light,
                    ),
                  ]),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                InkWell(
                  onTap: () {
                    // setState(() {
                    //   jobCategoryFilter = null;
                    // });
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: layout.padding,
                      bottom: layout.padding * 2,
                    ),
                    child: Row(children: [
                      Icon(
                        Icons.close,
                        color: clr.passiveLight,
                        size: layout.iconSmall,
                      ),
                      const Text(
                        ' Close',
                        style: txt.button,
                      ),
                    ]),
                  ),
                ),
              ]),
            ]),
          ],
        );
      },
    );
  }
}
