import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  String username = '';

  // initialized the state when screen started
  @override
  void initState() {
    super.initState();
    getUserName();
  }

  void getUserName() async {
    // get object(document snapshot) from firebase database > collection users > match with doc (current user uid)
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    // set state of username
    setState(() {
      // snap.date() is not supported by [] thus object should be define as Map<>
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("$username")),
    );
  }
}
