import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/models/user.dart' as model;
import 'package:social_app/providers/user_proiver.dart';
import 'package:social_app/utils/colors.dart';

import '../utils/global_variable.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  // global value
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  // tapped -> change page accordint to page value
  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  // change _page according to page value
  void onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }
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
            body: PageView(
              children: homeScreenItems,
              // no slide option between pages
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              // change _page value when tapped
              onPageChanged: onPageChange,
            ),
            bottomNavigationBar: CupertinoTabBar(
              backgroundColor: mobileBackgroundColor,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    // color change if curretn page is matche. white/grey
                    color: _page == 0 ? primaryColor : secondaryColor,
                  ),
                  label: '',
                  backgroundColor: mobileBackgroundColor,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search,
                      color: _page == 1 ? primaryColor : secondaryColor),
                  label: '',
                  backgroundColor: mobileBackgroundColor,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_circle,
                    color: _page == 2 ? primaryColor : secondaryColor,
                  ),
                  label: '',
                  backgroundColor: mobileBackgroundColor,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    color: _page == 3 ? primaryColor : secondaryColor,
                  ),
                  label: '',
                  backgroundColor: mobileBackgroundColor,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: _page == 4 ? primaryColor : secondaryColor,
                  ),
                  label: '',
                  backgroundColor: mobileBackgroundColor,
                ),
              ],
              onTap: navigationTapped,
            ));
  }
}
