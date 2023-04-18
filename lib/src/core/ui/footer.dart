import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/colors.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              Text(
                'Powered by ',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
              ),
              InkWell(
                onTap: () async {
                  const url = 'https://asterinnovations.com/privacy-policy/';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Text(
                  'Aster Innovations',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Text(
                ' © All Rights Reserved',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
              )
            ],
          ),
        ),
      ),
    );
  }
}
