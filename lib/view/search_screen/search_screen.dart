import 'package:flutter/material.dart';
import 'package:notely_app/utils/color_constant.dart';
import 'package:notely_app/utils/textstyle_constant.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
        title: Text('Search', style: maintextdark),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: subtextdark,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: subtextdark,
                  prefixIcon: Icon(Icons.search, color: primarycolordark),
                  filled: true,
                  fillColor: primarycolorlight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
