import 'package:flutter/material.dart';
//TODO make a selecton love card

class AvatarProfile extends StatefulWidget {
  const AvatarProfile({super.key});

  @override
  State<AvatarProfile> createState() => _AvatarProfileState();
}

class _AvatarProfileState extends State<AvatarProfile> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 4.0,vertical:6.0 ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.pink.shade100,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 37.0,
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 35.0,
              ),
            ),

          ),
          const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text("Name"),
          ),
        ],
      ),
    );
  }
}
