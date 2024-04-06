import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notely_app/features/home/utils/color_constant.dart';
import 'package:notely_app/features/home/utils/textstyle_constant.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final descriptionstyle =
      GoogleFonts.poppins(color: textcolordark, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
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
        backgroundColor: bgcolor,
        centerTitle: true,
        title: Text(
          'Privacy Policy',
          style: maintextdark,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: primarycolorlight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: primarycolordark,
                      width: 3,
                    )),
                width: MediaQuery.of(context).size.width * 0.99,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. Information We Collect", style: maintextdark),
                      Text(
                        '1.1 Personal Information: Notely App does not collect any personal information\n1.2 Device Information: We may collect information about the device you use to access the app, including device type, operating system, and unique device identifiers.',
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("2. Data Storage", style: maintextdark),
                      Text(
                        '2.1 Note created using NOTELY are stored locally on the user device.\n2.2 The Hive database for local storage. Hive is an open source, small database.',
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("3. Security", style: maintextdark),
                      Text(
                        '3.1 We implement reasonable security measures to protect your information from unauthorized access, disclosure, alteration, destruction and 100% secure.',
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("4. Children's Privacy", style: maintextdark),
                      Text(
                        '4.1 Our app is not intended for children under the age of 13, and we do not knowingly collect personal information from children.',
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("5. Changes to the Privacy Policy",
                          style: maintextdark),
                      Text(
                        '5.1 We reserve the right to update or modify our privacy policy at any time. We will notify you of any changes by posting the updated policy on our website or through the app.',
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("6. Third-Party Services", style: maintextdark),
                      Text(
                        '6.1 NOTELY App may use third-party services for analytics and crash reporting. These services may collect anonymous usage data to help identify and fix app issues.\n6.2 Users are encouraged to review the privacy policies of third-party services used by NOTELY App.',
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
