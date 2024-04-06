import 'package:flutter/material.dart';
import 'package:notely_app/features/home/utils/color_constant.dart';
import 'package:notely_app/features/home/utils/textstyle_constant.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
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
          'Support',
          style: maintextdark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
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
              width: MediaQuery.of(context).size.width * 0.95,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text("Contact Information", style: maintextdark),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: primarycolordark,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'vyshnavkm66@gmail.com',
                          style: subtextdark,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
