import 'package:flutter/material.dart';
import 'package:freelance_app/widgets/custom_textfield.dart';

class JobPosts extends StatelessWidget {
  TextEditingController fullName = TextEditingController();
  JobPosts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Post Job",
            style: TextStyle(fontSize: 20, color: Colors.blueGrey),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.2,
            indent: 35,
            endIndent: 35,
          ),
          CustomTextfield(
            myController: fullName,
            hintText: "hint",
            isPassword: false,
          ),
          CustomTextfield(
            myController: fullName,
            hintText: "hint",
            isPassword: false,
          ),
          CustomTextfield(
            myController: fullName,
            hintText: "hint",
            isPassword: false,
          ),
          CustomTextfield(
            myController: fullName,
            hintText: "hint",
            isPassword: false,
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
