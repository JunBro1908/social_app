import 'package:flutter/material.dart';
import 'package:social_app/utils/dimensions.dart';

// change the widget according to screen size by using constraint
class ResponsiveLayoutScreen extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayoutScreen(
      {super.key,
      required this.webScreenLayout,
      required this.mobileScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          // over webScreenSize, display will be based on web
          return webScreenLayout;
        }
        // under webScreenSize, display will be based on mobile
        return mobileScreenLayout;
      },
    );
  }
}
