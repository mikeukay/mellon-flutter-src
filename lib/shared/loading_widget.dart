import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mellon/shared/constants.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Constants.kBackgroundColor,
      child: Center(
        child: SpinKitDualRing(
          color: Constants.kPrimaryColor,
          size: width * 0.2,
        ),
      ),
    );
  }
}
