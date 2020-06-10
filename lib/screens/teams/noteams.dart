import 'package:flutter/material.dart';
import 'package:mellon/shared/constants.dart';

class NoTeamsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.group,
              size: width * 0.5,
              color: Constants.kCommentColor,
            ),
            SizedBox(height: width * 0.03),
            Text(
              'You are currently not a member of any team.\nYou can create one by using the button at the bottom of this screen.',
              style: TextStyle(
                color: Constants.kCommentColor,
                fontSize: width * 0.04,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
