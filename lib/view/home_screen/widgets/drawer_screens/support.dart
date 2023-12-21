import 'package:flutter/material.dart';
import 'package:notely_app/utils/color_constant.dart';
import 'package:notely_app/utils/textstyle_constant.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
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
          'Support',
          style: maintextdark,
        ),
      ),
    );
  }
}
