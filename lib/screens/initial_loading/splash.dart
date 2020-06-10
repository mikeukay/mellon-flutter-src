import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mellon/shared/constants.dart';

class SplashScreen extends StatelessWidget {

  final Function afterLoadingFinished;

  SplashScreen({this.afterLoadingFinished});

  Future<void> load() async {
    await Future.delayed(const Duration(milliseconds: 2500));

    String answer = "";
    final HttpsCallable ping = CloudFunctions.instance.getHttpsCallable(functionName: 'ping')
    ..timeout = const Duration(seconds: 30);
    final HttpsCallableResult res = await ping.call();
    answer = res.data;
    if(answer == "pong!") {
      afterLoadingFinished();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if(afterLoadingFinished != null) {
      load();
    }

    return Scaffold(
      body: Container(
          color: Constants.kPrimaryColor,
          width: width,
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Mellon',
                style: TextStyle(
                  color: Constants.kBackgroundColor,
                  fontSize: width * 0.1,
                ),
              ),
              SizedBox(width: width * 0.03),
              SvgPicture.asset(
                'assets/svg/logo.svg',
                color: Constants.kBackgroundColor,
                width: width * 0.1,
              )
            ],
          ),
        ),
    );
  }
}
