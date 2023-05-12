import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/providers/user_proiver.dart';
import '../utils/global_variable.dart';

// change the widget according to screen size by using constraint
class ResponsiveLayoutScreen extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayoutScreen(
      {super.key,
      required this.webScreenLayout,
      required this.mobileScreenLayout});

  @override
  State<ResponsiveLayoutScreen> createState() => _ResponsiveLayoutScreenState();
}

class _ResponsiveLayoutScreenState extends State<ResponsiveLayoutScreen> {
  @override
  void initState() {
    super.initState();
    // provider
    addData();
  }

  // both web and mobile
  addData() async {
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refresUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          // over webScreenSize, display will be based on web
          return widget.webScreenLayout;
        }
        // under webScreenSize, display will be based on mobile
        return widget.mobileScreenLayout;
      },
    );
  }
}
