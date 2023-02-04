import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:dio/dio.dart';

import '../../utils/colors.dart';
import '../homescreen/sidebar.dart';
import 'package:freelance_app/utils/global_variables.dart';

TextEditingController fullName = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController phoneNum = TextEditingController();
TextEditingController address = TextEditingController();
TextEditingController college = TextEditingController();
TextEditingController degree = TextEditingController();
TextEditingController extra = TextEditingController();
TextEditingController skills = TextEditingController();
TextEditingController gender = TextEditingController();
TextEditingController dob = TextEditingController();
TextEditingController fb = TextEditingController();
TextEditingController telegram = TextEditingController();
TextEditingController linkedin = TextEditingController();
TextEditingController about = TextEditingController();
TextEditingController profession = TextEditingController();
TextEditingController exp = TextEditingController();
TextEditingController links = TextEditingController();

// ignore: prefer_typing_uninitialized_variables
var eduChosen;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
      body: const Profile(),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _currentInd = 0;

  List<Step> stepList() => [
        Step(
          title: const Text('Personal'),
          state: _currentInd <= 0 ? StepState.indexed : StepState.complete,
          isActive: _currentInd >= 0,
          content: const InfoForm(),
        ),
        Step(
          title: const Text('Education'),
          state: _currentInd <= 1 ? StepState.indexed : StepState.complete,
          isActive: _currentInd >= 1,
          content: const EduForm(),
        ),
        Step(
          title: const Text('Experience'),
          state: _currentInd <= 2 ? StepState.indexed : StepState.complete,
          isActive: _currentInd >= 2,
          content: const ExpForm(),
        ),
      ];

  Widget controlsBuilder(context, details) {
    return _currentInd == 0
        ? Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ],
          )
        : _currentInd != 2
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: details.onStepCancel,
                          child: const Text('Back'),
                        ),
                        ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: const Text('Next'),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: details.onStepCancel,
                          child: const Text('Back'),
                        ),
                        ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        type: StepperType.horizontal,
        steps: stepList(),
        currentStep: _currentInd,
        onStepContinue: () {
          if (_currentInd < stepList().length - 1) {
            ++_currentInd;
          } else {
            Fluttertoast.showToast(
                msg: "✔ SUBMITED",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          setState(() {});
        },
        onStepCancel: () {
          if (_currentInd == 0) {
            return;
          }
          --_currentInd;
          setState(() {});
        },
        controlsBuilder: controlsBuilder,
      ),
    );
  }
}

class InfoForm extends StatefulWidget {
  const InfoForm({super.key});

  @override
  State<InfoForm> createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  var fileName = '';
  File? image;
  Future pickImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img == null) return;
    final imgTemp = File(img.path);
    setState(() {
      this.image = imgTemp;
    });
  }

  List items = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    getAvatar();
    return Column(
      children: [
        InkWell(
          onTap: () => pickImage(),
          child: Stack(children: [
            image != null
                ? ClipOval(
                    child: Image.file(
                      image!,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: avatarImage,
                    /*
                    NetworkImage(
                        'https://st4.depositphotos.com/4329009/19956/v/600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg'),
                    */
                    backgroundColor: Colors.lightGreen,
                    radius: 100,
                  ),
            const Positioned(
              right: 20,
              bottom: 20,
              child: InkWell(
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.teal,
                ),
              ),
            ),
          ]),
        ),
        const SizedBox(
          height: 40,
        ),
        TextField(
          controller: fullName,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Full Name',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          controller: email,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          controller: profession,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Profession',
            prefixIcon: Icon(Icons.business),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          controller: phoneNum,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Phone Number',
            prefixIcon: Icon(Icons.phone),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          controller: address,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Address',
            prefixIcon: Icon(Icons.location_city),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          height: 60,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38, width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: DropdownButtonFormField(
                decoration: const InputDecoration.collapsed(
                  hintText: '',
                ),
                isExpanded: true,
                hint: const Text('Gender'),
                value: eduChosen,
                items: items.map((choice) {
                  return DropdownMenuItem(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    eduChosen = newValue;
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          controller: dob,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Date of Birth',
              prefixIcon: Icon(Icons.calendar_today_rounded)
              //prefixIconColor: Icon(Icons.calendar_today_rounded)
              ),
          onTap: (() async {
            DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2023));
            if (picked != null) {
              setState(() {
                dob.text = DateFormat('yyyy-MM-dd').format(picked);
              });
            }
          }),
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          maxLines: 1,
          controller: fb,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Facebook',
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          maxLines: 1,
          controller: telegram,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Telegram',
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          maxLines: 1,
          controller: linkedin,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'LinkedIn',
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          maxLines: 6,
          controller: about,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Tell us a bit about yourself...',
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 36,
            ),
            const Text('Upload an image of your kebele ID'),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  backgroundColor: const Color(0xFF42A5F5)),
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.any,
                  allowMultiple: false,
                );
                if (result == null) return;
                setState(() {
                  fileName = result.files.first.name;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.file_upload),
                ],
              ),
            ),
          ],
        ),
        fileName == ''
            ? Text(fileName)
            : Row(
                children: [
                  const Icon(Icons.upload_file),
                  Text(fileName),
                ],
              ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Myprofile()));
            },
            child: const Text('click'))
      ],
    );
  }

  //temporary profile controller from firestore
  getAvatar() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    avatarURL = userDoc.get('user_image');
    avatarImage = NetworkImage(avatarURL.toString());
  }
}

class EduForm extends StatefulWidget {
  const EduForm({super.key});

  @override
  State<EduForm> createState() => _EduFormState();
}

class _EduFormState extends State<EduForm> {
  List items = [
    'No Education',
    'Primary School',
    'High School',
    'Some College',
    'Assoc. Degree',
    'BA/BS Degree',
    'Masters Degree',
    'Doctoral Degree',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38, width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    hint: const Text('Select Education Level..'),
                    value: eduChosen,
                    items: items.map((choice) {
                      return DropdownMenuItem(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        eduChosen = newValue;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: college,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.school),
              labelText: 'School/college you go/went to..',
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: degree,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.school),
              labelText: 'Field',
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: skills,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.assignment),
              labelText: 'Skills...',
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            maxLines: 4,
            controller: extra,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Extracurricular activities',
            ),
          ),
        ],
      ),
    );
  }
}

class ExpForm extends StatefulWidget {
  const ExpForm({super.key});

  @override
  State<ExpForm> createState() => _ExpFormState();
}

class _ExpFormState extends State<ExpForm> {
  var cvName = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            maxLines: 6,
            controller: exp,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Write down your past work experiences...',
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            maxLines: 3,
            controller: links,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText:
                  "Any links you'd want to share (portfolio, \nLinkedIn, github... )",
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 36,
              ),
              const Text('Upload your CV'),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                    backgroundColor: const Color(0xFF42A5F5)),
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.any,
                    allowMultiple: false,
                  );
                  if (result == null) return;
                  setState(() {
                    cvName = result.files.first.name;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.file_upload),
                  ],
                ),
              ),
            ],
          ),
          cvName == ''
              ? Text(cvName)
              : Row(
                  children: [
                    const Icon(Icons.upload_file),
                    Text(cvName),
                  ],
                )
        ],
      ),
    );
  }
}

class Myprofile extends StatefulWidget {
  const Myprofile({super.key});

  @override
  State<Myprofile> createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {
  Widget socialIcon(IconData icon) {
    return CircleAvatar(
      radius: 25,
      child: Center(
          child: Icon(
        icon,
        size: 32,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY Profile'),
      ),
      body: ListView(padding: EdgeInsets.zero, children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 100),
                child: coverImage()),
            const Positioned(
              top: 190,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                radius: 90,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://marketplace.canva.com/EAFEits4-uw/1/0/1600w/canva-boy-cartoon-gamer-animated-twitch-profile-photo-oEqs2yqaL8s.jpg'),
                  backgroundColor: Colors.lightGreen,
                  radius: 85,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_rate,
                          color: Colors.yellow.shade700,
                        ),
                        Icon(
                          Icons.star_rate,
                          color: Colors.yellow.shade700,
                        ),
                        Icon(
                          Icons.star_rate,
                          color: Colors.yellow.shade700,
                        ),
                        Icon(
                          Icons.star_rate,
                          color: Colors.yellow.shade700,
                        ),
                        Icon(
                          Icons.star_rate,
                          color: Colors.yellow.shade700,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Nick Manning',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Flutter Software Engineer',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        socialIcon(FontAwesomeIcons.addressCard),
                        const SizedBox(
                          width: 12,
                        ),
                        socialIcon(FontAwesomeIcons.github),
                        const SizedBox(
                          width: 12,
                        ),
                        socialIcon(FontAwesomeIcons.telegram),
                        const SizedBox(
                          width: 12,
                        ),
                        socialIcon(FontAwesomeIcons.linkedin),
                        const SizedBox(
                          width: 12,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'About',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Flutter Software Engineer and Google Developer Expert for Flutter with years of experience as a consultant for multiple companies in Europe, USA and Asia.\n\nMy mission is to create a netter world with beautiful flutter app designs and software.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('My Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: 'Nickmanning0@gmail.com',
                readOnly: true,
                //controller: email,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: 'Mali Bero Boulevard 169, Niamey, Niger',
                readOnly: true,
                maxLines: 2,
                //controller: address,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_city),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Education',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: 'BSC in Computer Science',
                readOnly: true,
                //controller: address,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.school),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: 'University of Colorado',
                readOnly: true,
                //controller: address,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.school),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLines: 3,
                initialValue:
                    'Flutter, Firebase, Angular, React Native, Version Control, Node.JS',
                readOnly: true,
                //controller: address,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.assignment),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLines: 3,

                initialValue:
                    'Swimming team captain, \nChess club, Debate club, Football, arts club',
                readOnly: true,
                //controller: address,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Work Experience',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue:
                    '* Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod \n* tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, \n* quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo\n* consequat. Duis aute irure dolor in reprehenderit in ',
                maxLines: 10,
                readOnly: true,
                //controller: address,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.business),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: 'Nickmanning.com',
                readOnly: true,
                //controller: address,
                decoration: const InputDecoration(
                  labelText: 'Portfolio',
                  prefixIcon: Icon(Icons.web),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: 'Nickmanning.com',
                readOnly: true,
                //controller: address,
                decoration: const InputDecoration(
                  labelText: 'Portfolio',
                  prefixIcon: Icon(Icons.web),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}

Widget coverImage() {
  return SizedBox(
    //color: Colors.grey,
    width: double.infinity,
    height: 280,

    child: FittedBox(
      fit: BoxFit.fill,
      child: Image.network(
          'https://tandsgo.com/wp-content/uploads/2020/09/Facebook-cover-photo-black-desktop-with-keyboard-680x259.jpg'),
    ),
  );
}
