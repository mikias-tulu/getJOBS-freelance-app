import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

TextEditingController fullName = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController phoneNum = TextEditingController();
TextEditingController address = TextEditingController();

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Profile(),
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
    return Row(
      children: [
        ElevatedButton(
          onPressed: details.onStepContinue,
          child: const Text('Next'),
        ),
        const SizedBox(
          width: 10,
        ),
        OutlinedButton(
            onPressed: details.onStepCancel, child: const Text('Back'))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
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
        onStepTapped: (int index) {
          setState(
            () {
              _currentInd = index;
            },
          );
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: fullName,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Full Name',
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          controller: email,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          controller: phoneNum,
          obscureText: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Phone Number',
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          controller: address,
          obscureText: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Address',
          ),
        ),
      ],
    );
  }
}

class EduForm extends StatefulWidget {
  const EduForm({super.key});

  @override
  State<EduForm> createState() => _EduFormState();
}

class _EduFormState extends State<EduForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Text('edu'),
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
  @override
  Widget build(BuildContext context) {
    return const Text('exp');
  }
}
