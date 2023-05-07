import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/models/user.dart' as model;
import 'package:social_app/providers/user_proiver.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  // String username = '';

  // // initialized the state when screen started
  // @override
  // void initState() {
  //   super.initState();
  //   getUserName();
  // }

  // void getUserName() async {
  //   // get object(document snapshot) from firebase database > collection users > match with doc (current user uid)
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();

  //   // set state of username
  //   setState(() {
  //     // snap.date() is not supported by [] thus object should be define as Map<>
  //     username = (snap.data() as Map<String, dynamic>)['username'];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // provider
    model.User? user = Provider.of<UserProvider>(context).getUser;
    return user == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : // _file == null ?
        Scaffold(
            body: Center(
              child: Text(user.username),
            ),
          );
  }
}
