import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/providers/user_proiver.dart';
import 'package:social_app/responsive/mobile_screen_layout.dart';
import 'package:social_app/responsive/reponsive_layout_screen.dart';
import 'package:social_app/responsive/web_screen_layout.dart';
import 'package:social_app/screen/login_screen.dart';
import 'package:social_app/screen/signup_screen.dart';
import 'package:social_app/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // make sure flutter widget initialized
  WidgetsFlutterBinding.ensureInitialized();
  // be sure to initialize the app after the flutter widget come in or make error
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // setting default option according to current platForm (Web, ios, android)
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // provider
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // remove debug Banner
        title: 'Social App',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
          // from utils>colors use MobileBack.. color as background
        ),
        home: StreamBuilder(
          // three option 1) idTokenChanges 2) userChanges 3) authStateChanges
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // 1) connection is good
            if (snapshot.connectionState == ConnectionState.active) {
              // 1-1) connection is good and also has a data
              if (snapshot.hasData) {
                return const ResponsiveLayoutScreen(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout(),
                  //change widget by maxwidth from responsive_layout_screen
                );
              }
              // 1-2) connection is good but null value
              else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            // 2) connection is waiting
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
