import 'package:flutter/material.dart';
import 'package:notely_app/utils/color_constant.dart';
import 'package:notely_app/utils/textstyle_constant.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolorlight,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: primarycolordark,
          ),
        ),
        backgroundColor: primarycolorlight,
        centerTitle: true,
        title: Text(
          'Privacy Policy',
          style: maintextdark,
        ),
      ),
    );
  }
}
