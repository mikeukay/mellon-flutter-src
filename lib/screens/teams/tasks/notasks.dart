import 'package:flutter/material.dart';
import 'package:mellon/shared/constants.dart';

class NoTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.airline_seat_flat,
            size: width * 0.5,
            color: Constants.kCommentColor,
          ),
          SizedBox(height: width * 0.03),
          Text(
            'Yay! There are no tasks :)',
            style: TextStyle(
              color: Constants.kCommentColor,
              fontSize: width * 0.04,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
