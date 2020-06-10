import 'package:flutter/material.dart';
import 'package:mellon/screens/initial_loading/splash.dart';
import 'package:mellon/shared/constants.dart';
import 'package:mellon/screens/wrapper.dart';
import 'package:mellon/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    if(loading) {
      return MaterialApp(
        title: 'Mellon',
        home: SplashScreen(afterLoadingFinished: () {
            setState(() {
              loading = false;
            });
        }),
        theme: ThemeData(
          primaryColor: Constants.kPrimaryColor,
          backgroundColor: Constants.kBackgroundColor,
        ),
      );
    }
    return StreamProvider.value(
      value: AuthenticationService().authStream,
      child: MaterialApp(
        title: 'Mellon',
        home: WrapperScreen(),
        theme: ThemeData(
          primaryColor: Constants.kPrimaryColor,
          backgroundColor: Constants.kBackgroundColor,
        ),
      ),
    );
  }
}
